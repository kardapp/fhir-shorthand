[CmdletBinding()]
param(
    [string[]]$TodoFiles = @("TODO.md", "ISSUES-TODO-LIST.md"),
    [string]$JiraBaseUrl = $env:JIRA_BASE_URL,
    [string]$JiraEmail = $env:JIRA_EMAIL,
    [string]$JiraApiToken = $env:JIRA_API_TOKEN,
    [string]$JiraProjectKey = $env:JIRA_PROJECT_KEY,
    [string]$ParentIssueKey = $env:JIRA_PARENT_ISSUE_KEY,
    [switch]$CreateInJira,
    [switch]$SyncJiraStatus,
    [switch]$SyncParentIssueTasks,
    [switch]$UpdateExistingJiraFields,
    [string]$SubTaskIssueTypeName = "Sub-task",
    [switch]$WriteBackJiraKeys,
    [switch]$IncludeCompleted,
    [string[]]$OngoingTransitionNames = @("In Progress", "Start Progress", "Doing"),
    [string[]]$CompletedTransitionNames = @("Done", "Complete", "Completed", "Close Issue", "Resolved"),
    [string[]]$BlockedTransitionNames = @("Blocked", "On Hold", "To Do"),
    [string]$OutputJson = "jira-sync-preview.json"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Test-JiraConfig {
    param(
        [string]$BaseUrl,
        [string]$Email,
        [string]$ApiToken,
        [string]$ProjectKey
    )

    if ([string]::IsNullOrWhiteSpace($BaseUrl) -or
        [string]::IsNullOrWhiteSpace($Email) -or
        [string]::IsNullOrWhiteSpace($ApiToken) -or
        [string]::IsNullOrWhiteSpace($ProjectKey)) {
        throw "Jira config missing. Set JIRA_BASE_URL, JIRA_EMAIL, JIRA_API_TOKEN, and JIRA_PROJECT_KEY."
    }

    if ($BaseUrl -match "yourcompany\.atlassian\.net" -or
        $Email -match "^your\.email@" -or
        $ApiToken -eq "replace_with_token") {
        throw "Jira config still uses placeholder values. Update scripts/jira-sync.env with your real Jira base URL, email, and API token."
    }
}

function Get-TaskStatus {
    param(
        [string]$CheckMark,
        [string]$Text
    )

    if ($CheckMark -match "[xX]") {
        return "Completed"
    }

    if ($Text -match "(?i)\b(done|completed|klar)\b") {
        return "Completed"
    }

    if ($Text -match "(?i)\b(blocked|paused|on hold|waiting)\b") {
        return "Blocked"
    }

    if ($Text -match "(?i)\b(ongoing|in progress|pag\w*ende|p\w*gende)\b") {
        return "Ongoing"
    }

    return "Ongoing"
}

function Remove-MarkdownFormatting {
    param([string]$Text)

    $clean = $Text
    $clean = $clean -replace "\[([^\]]+)\]\(([^\)]+)\)", '$1 ($2)'
    $clean = $clean -replace '`', ""
    return $clean.Trim()
}

function Get-AgendaFromTask {
    param([string]$TaskText)

    $agenda = Remove-MarkdownFormatting -Text $TaskText
    $agenda = $agenda -replace "\s*\(~[^\)]*\)\s*", " "
    $agenda = $agenda -replace "\s*-\s*(?i:done|klar|completed)\s*$", ""
    $agenda = $agenda -replace "\s+", " "
    return $agenda.Trim()
}

function Update-HeadingStack {
    param(
        [System.Collections.Generic.List[object]]$Stack,
        [int]$Level,
        [string]$Title
    )

    for ($i = $Stack.Count - 1; $i -ge 0; $i--) {
        if ($Stack[$i].Level -ge $Level) {
            $Stack.RemoveAt($i)
        }
    }

    $Stack.Add([pscustomobject]@{
        Level = $Level
        Title = $Title.Trim()
    })
}

function Get-SectionPath {
    param([System.Collections.Generic.List[object]]$Stack)

    if ($Stack.Count -eq 0) {
        return "General"
    }

    return (($Stack | ForEach-Object { $_.Title }) -join " > ")
}

function Parse-TodoFile {
    param([string]$FilePath)

    if (-not (Test-Path -LiteralPath $FilePath)) {
        throw "TODO file not found: $FilePath"
    }

    $lines = Get-Content -LiteralPath $FilePath -Encoding UTF8
    $headingStack = New-Object "System.Collections.Generic.List[object]"
    $items = New-Object "System.Collections.Generic.List[object]"

    for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
        $line = $lines[$lineIndex]

        if ($line -match "^(#{1,6})\s+(.+?)\s*$") {
            $level = $Matches[1].Length
            $title = $Matches[2]
            Update-HeadingStack -Stack $headingStack -Level $level -Title $title
            continue
        }

        if ($line -match "^\s*-\s*\[([ xX])\]\s+(.+?)\s*$") {
            $checkMark = $Matches[1]
            $rawTaskText = $Matches[2].Trim()
            $agenda = Get-AgendaFromTask -TaskText $rawTaskText
            $status = Get-TaskStatus -CheckMark $checkMark -Text $rawTaskText
            $existingJiraKey = $null
            if ($rawTaskText -match "\[JIRA:\s*([A-Z][A-Z0-9]+-\d+)\s*\]") {
                $existingJiraKey = $Matches[1]
            }
            elseif ($rawTaskText -cmatch "\b([A-Z][A-Z0-9]+-\d+)\b") {
                $existingJiraKey = $Matches[1]
            }

            $section = Get-SectionPath -Stack $headingStack
            $sourceFileName = [System.IO.Path]::GetFileName($FilePath)
            $description = @(
                "Agenda: $agenda",
                "",
                "Task description:",
                (Remove-MarkdownFormatting -Text $rawTaskText),
                "",
                "Progress status: $status",
                "Checklist state: [$checkMark]",
                "Section: $section",
                "Source: ${sourceFileName}:$($lineIndex + 1)"
            ) -join "`n"

            $items.Add([pscustomobject]@{
                SourceFile = $FilePath
                SourceLine = $lineIndex + 1
                Section = $section
                Agenda = $agenda
                Description = $description
                Status = $status
                ExistingJiraKey = $existingJiraKey
                RawTaskText = $rawTaskText
                OriginalLine = $line
                CheckMark = $checkMark
            })
        }
    }

    return [pscustomobject]@{
        FilePath = $FilePath
        Lines = $lines
        Items = $items
    }
}

function New-JiraIssue {
    param(
        [string]$BaseUrl,
        [string]$Email,
        [string]$ApiToken,
        [string]$ProjectKey,
        [string]$ParentKey,
        [string]$SubTaskTypeName,
        [pscustomobject]$TaskItem
    )

    $pair = "$Email`:$ApiToken"
    $basicToken = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($pair))
    $headers = @{
        Authorization = "Basic $basicToken"
        Accept = "application/json"
        "Content-Type" = "application/json"
    }

    $statusLabel = "sync-status-" + $TaskItem.Status.ToLowerInvariant()
    $safeSection = ($TaskItem.Section -replace "[^a-zA-Z0-9]+", "-").Trim("-").ToLowerInvariant()

    $fields = @{
        project = @{ key = $ProjectKey }
        summary = $TaskItem.Agenda
        description = $TaskItem.Description
        issuetype = @{ name = "Task" }
        labels = @("todo-sync", $statusLabel, "section-$safeSection")
    }

    if (-not [string]::IsNullOrWhiteSpace($ParentKey)) {
        $fields.issuetype = @{ name = $SubTaskTypeName }
        $fields.parent = @{ key = $ParentKey }
    }

    $payload = @{ fields = $fields }

    $uri = ($BaseUrl.TrimEnd("/")) + "/rest/api/2/issue"
    $body = $payload | ConvertTo-Json -Depth 10
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)

    return Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $bodyBytes
}

function Get-HttpErrorDetails {
    param([System.Exception]$Exception)

    $message = $Exception.Message
    try {
        $response = $Exception.Response
        if ($null -eq $response) {
            return $message
        }

        $stream = $response.GetResponseStream()
        if ($null -eq $stream) {
            return $message
        }

        $reader = New-Object System.IO.StreamReader($stream)
        $body = $reader.ReadToEnd()
        if (-not [string]::IsNullOrWhiteSpace($body)) {
            return "$message | Response: $body"
        }
    }
    catch {
        return $message
    }

    return $message
}

function Normalize-TaskText {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return ""
    }

    $normalized = $Text.ToLowerInvariant()
    $normalized = $normalized -replace "\([^\)]*\)", " "
    $normalized = $normalized -replace "[^a-z0-9]+", ""
    return $normalized.Trim()
}

function Get-JiraIssuesByJql {
    param(
        [string]$BaseUrl,
        [hashtable]$Headers,
        [string]$Jql,
        [int]$MaxResults = 100
    )

    $v3Uri = ($BaseUrl.TrimEnd("/")) + "/rest/api/3/search"
    $v3Body = @{
        jql = $Jql
        maxResults = $MaxResults
        fields = @("summary", "status", "parent")
    } | ConvertTo-Json -Depth 6

    $errors = New-Object System.Collections.Generic.List[string]

    try {
        $response = Invoke-RestMethod -Method Post -Uri $v3Uri -Headers $Headers -Body $v3Body
        return @($response.issues)
    }
    catch {
        $errors.Add("/rest/api/3/search failed: $($_.Exception.Message)")
    }

    try {
        $v3AltUri = ($BaseUrl.TrimEnd("/")) + "/rest/api/3/search/jql"
        $v3AltResponse = Invoke-RestMethod -Method Post -Uri $v3AltUri -Headers $Headers -Body $v3Body
        return @($v3AltResponse.issues)
    }
    catch {
        $errors.Add("/rest/api/3/search/jql failed: $($_.Exception.Message)")
    }

    throw "Could not query Jira issues by JQL. " + ($errors -join " | ")
}

function Set-JiraIssueFields {
    param(
        [string]$BaseUrl,
        [hashtable]$Headers,
        [string]$IssueKey,
        [pscustomobject]$TaskItem
    )

    $payload = @{
        fields = @{
            summary = $TaskItem.Agenda
            description = $TaskItem.Description
        }
    }

    $uri = ($BaseUrl.TrimEnd("/")) + "/rest/api/2/issue/$IssueKey"
    $body = $payload | ConvertTo-Json -Depth 6
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    Invoke-RestMethod -Method Put -Uri $uri -Headers $Headers -Body $bodyBytes | Out-Null
}

function New-JiraAuthHeaders {
    param(
        [string]$Email,
        [string]$ApiToken
    )

    $pair = "$Email`:$ApiToken"
    $basicToken = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($pair))
    return @{
        Authorization = "Basic $basicToken"
        Accept = "application/json"
        "Content-Type" = "application/json; charset=utf-8"
    }
}

function Get-CandidateTransitionNamesForStatus {
    param(
        [string]$Status,
        [string[]]$OngoingNames,
        [string[]]$CompletedNames,
        [string[]]$BlockedNames
    )

    switch ($Status) {
        "Completed" { return $CompletedNames }
        "Blocked" { return $BlockedNames }
        default { return $OngoingNames }
    }
}

function Resolve-JiraTransitionId {
    param(
        [string]$BaseUrl,
        [hashtable]$Headers,
        [string]$IssueKey,
        [string[]]$CandidateNames
    )

    $uri = ($BaseUrl.TrimEnd("/")) + "/rest/api/2/issue/$IssueKey/transitions"
    $transitionResponse = Invoke-RestMethod -Method Get -Uri $uri -Headers $Headers
    $transitions = @($transitionResponse.transitions)

    foreach ($candidate in $CandidateNames) {
        $match = $transitions | Where-Object { $_.name -ieq $candidate } | Select-Object -First 1
        if ($null -ne $match) {
            return [pscustomobject]@{
                Id = [string]$match.id
                Name = [string]$match.name
            }
        }
    }

    return $null
}

function Set-JiraIssueTransition {
    param(
        [string]$BaseUrl,
        [hashtable]$Headers,
        [string]$IssueKey,
        [string]$TransitionId
    )

    $uri = ($BaseUrl.TrimEnd("/")) + "/rest/api/2/issue/$IssueKey/transitions"
    $body = @{
        transition = @{ id = $TransitionId }
    } | ConvertTo-Json -Depth 5
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)

    Invoke-RestMethod -Method Post -Uri $uri -Headers $Headers -Body $bodyBytes | Out-Null
}

function Get-TaskJiraIssueKey {
    param([pscustomobject]$Task)

    $prop = $Task.PSObject.Properties["JiraIssueKey"]
    if ($null -eq $prop) {
        return $null
    }

    return [string]$prop.Value
}

$allParsedFiles = New-Object "System.Collections.Generic.List[object]"
$allTasks = New-Object "System.Collections.Generic.List[object]"

foreach ($todoFile in $TodoFiles) {
    $absoluteTodoPath = Resolve-Path -LiteralPath $todoFile | Select-Object -ExpandProperty Path
    $parsed = Parse-TodoFile -FilePath $absoluteTodoPath
    $allParsedFiles.Add($parsed)

    foreach ($item in $parsed.Items) {
        if (-not $IncludeCompleted -and $item.Status -eq "Completed") {
            continue
        }

        $allTasks.Add($item)
    }
}

if ($CreateInJira -or $SyncJiraStatus -or $SyncParentIssueTasks -or $UpdateExistingJiraFields) {
    Test-JiraConfig -BaseUrl $JiraBaseUrl -Email $JiraEmail -ApiToken $JiraApiToken -ProjectKey $JiraProjectKey
}

$jiraHeaders = $null
if ($CreateInJira -or $SyncJiraStatus -or $SyncParentIssueTasks -or $UpdateExistingJiraFields) {
    $jiraHeaders = New-JiraAuthHeaders -Email $JiraEmail -ApiToken $JiraApiToken
}

$parentIssuesByNormalizedSummary = @{}
if ($SyncParentIssueTasks) {
    if ([string]::IsNullOrWhiteSpace($ParentIssueKey)) {
        throw "SyncParentIssueTasks requires ParentIssueKey (or JIRA_PARENT_ISSUE_KEY)."
    }

    $parentJql = "parent = $ParentIssueKey ORDER BY created ASC"
    $parentSubtasks = Get-JiraIssuesByJql -BaseUrl $JiraBaseUrl -Headers $jiraHeaders -Jql $parentJql -MaxResults 500
    foreach ($issue in $parentSubtasks) {
        $norm = Normalize-TaskText -Text ([string]$issue.fields.summary)
        if (-not [string]::IsNullOrWhiteSpace($norm) -and -not $parentIssuesByNormalizedSummary.ContainsKey($norm)) {
            $parentIssuesByNormalizedSummary[$norm] = $issue
        }
    }
}

$createdCount = 0
$skippedExistingCount = 0
$statusSyncedCount = 0
$statusSyncFailedCount = 0
$matchedParentCount = 0
$updatedFieldsCount = 0
$updateFieldsFailedCount = 0

foreach ($task in $allTasks) {
    if (-not [string]::IsNullOrWhiteSpace($task.ExistingJiraKey)) {
        $task | Add-Member -NotePropertyName JiraIssueKey -NotePropertyValue $task.ExistingJiraKey -Force
        $task | Add-Member -NotePropertyName JiraAction -NotePropertyValue "SkippedExisting" -Force
        $skippedExistingCount++
    }

    if ([string]::IsNullOrWhiteSpace((Get-TaskJiraIssueKey -Task $task)) -and $SyncParentIssueTasks) {
        $taskNorm = Normalize-TaskText -Text $task.Agenda
        if (-not [string]::IsNullOrWhiteSpace($taskNorm) -and $parentIssuesByNormalizedSummary.ContainsKey($taskNorm)) {
            $matchedIssue = $parentIssuesByNormalizedSummary[$taskNorm]
            $task | Add-Member -NotePropertyName JiraIssueKey -NotePropertyValue $matchedIssue.key -Force
            $task | Add-Member -NotePropertyName JiraAction -NotePropertyValue "MatchedParentSubtask" -Force
            $matchedParentCount++
        }
    }

    if ([string]::IsNullOrWhiteSpace((Get-TaskJiraIssueKey -Task $task)) -and $CreateInJira) {
        try {
            $createParentKey = $null
            if (-not [string]::IsNullOrWhiteSpace($ParentIssueKey)) {
                $createParentKey = $ParentIssueKey
            }

            $response = New-JiraIssue -BaseUrl $JiraBaseUrl -Email $JiraEmail -ApiToken $JiraApiToken -ProjectKey $JiraProjectKey -ParentKey $createParentKey -SubTaskTypeName $SubTaskIssueTypeName -TaskItem $task
            $task | Add-Member -NotePropertyName JiraIssueKey -NotePropertyValue $response.key -Force
            $task | Add-Member -NotePropertyName JiraAction -NotePropertyValue "Created" -Force
            $createdCount++

            if ($WriteBackJiraKeys) {
                $parsedFile = $allParsedFiles | Where-Object { $_.FilePath -eq $task.SourceFile } | Select-Object -First 1
                if ($null -ne $parsedFile) {
                    $lineIndex = [int]$task.SourceLine - 1
                    $lineText = $parsedFile.Lines[$lineIndex]
                    if ($lineText -notmatch "\[JIRA:\s*[A-Z][A-Z0-9]+-\d+\]") {
                        $parsedFile.Lines[$lineIndex] = $lineText.TrimEnd() + " [JIRA:$($response.key)]"
                    }
                }
            }
        }
        catch {
            $task | Add-Member -NotePropertyName JiraAction -NotePropertyValue "Failed" -Force
            $task | Add-Member -NotePropertyName JiraError -NotePropertyValue (Get-HttpErrorDetails -Exception $_.Exception) -Force
        }
    }

    if (-not $task.PSObject.Properties["JiraAction"]) {
        $task | Add-Member -NotePropertyName JiraAction -NotePropertyValue "PreviewOnly" -Force
    }

    $taskJiraIssueKey = Get-TaskJiraIssueKey -Task $task

    if ($UpdateExistingJiraFields -and -not [string]::IsNullOrWhiteSpace($taskJiraIssueKey)) {
        try {
            Set-JiraIssueFields -BaseUrl $JiraBaseUrl -Headers $jiraHeaders -IssueKey $taskJiraIssueKey -TaskItem $task
            $updatedFieldsCount++
            $task | Add-Member -NotePropertyName JiraFieldsSync -NotePropertyValue "Updated" -Force
        }
        catch {
            $updateFieldsFailedCount++
            $task | Add-Member -NotePropertyName JiraFieldsSync -NotePropertyValue "Failed" -Force
            $task | Add-Member -NotePropertyName JiraFieldsSyncMessage -NotePropertyValue (Get-HttpErrorDetails -Exception $_.Exception) -Force
        }
    }

    if ($SyncJiraStatus) {
        if ([string]::IsNullOrWhiteSpace($taskJiraIssueKey)) {
            $task | Add-Member -NotePropertyName JiraStatusSync -NotePropertyValue "SkippedNoIssueKey" -Force
            continue
        }

        try {
            $candidateNames = Get-CandidateTransitionNamesForStatus -Status $task.Status -OngoingNames $OngoingTransitionNames -CompletedNames $CompletedTransitionNames -BlockedNames $BlockedTransitionNames
            $transition = Resolve-JiraTransitionId -BaseUrl $JiraBaseUrl -Headers $jiraHeaders -IssueKey $taskJiraIssueKey -CandidateNames $candidateNames

            if ($null -eq $transition) {
                $statusSyncFailedCount++
                $task | Add-Member -NotePropertyName JiraStatusSync -NotePropertyValue "NoMatchingTransition" -Force
                $task | Add-Member -NotePropertyName JiraStatusSyncMessage -NotePropertyValue ("No transition matched status '{0}'. Candidates: {1}" -f $task.Status, ($candidateNames -join ", ")) -Force
                continue
            }

            Set-JiraIssueTransition -BaseUrl $JiraBaseUrl -Headers $jiraHeaders -IssueKey $taskJiraIssueKey -TransitionId $transition.Id
            $statusSyncedCount++
            $task | Add-Member -NotePropertyName JiraStatusSync -NotePropertyValue "Transitioned" -Force
            $task | Add-Member -NotePropertyName JiraStatusSyncTransition -NotePropertyValue $transition.Name -Force
        }
        catch {
            $statusSyncFailedCount++
            $task | Add-Member -NotePropertyName JiraStatusSync -NotePropertyValue "Failed" -Force
            $task | Add-Member -NotePropertyName JiraStatusSyncMessage -NotePropertyValue (Get-HttpErrorDetails -Exception $_.Exception) -Force
        }
    }
}

if ($WriteBackJiraKeys -and $CreateInJira) {
    foreach ($parsedFile in $allParsedFiles) {
        Set-Content -LiteralPath $parsedFile.FilePath -Value $parsedFile.Lines -Encoding UTF8
    }
}

$preview = $allTasks | Select-Object SourceFile, SourceLine, Section, Agenda, Status, ExistingJiraKey, JiraIssueKey, JiraAction, JiraError, JiraFieldsSync, JiraFieldsSyncMessage, JiraStatusSync, JiraStatusSyncTransition, JiraStatusSyncMessage
$preview | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $OutputJson -Encoding UTF8

Write-Host ""
Write-Host "Todo sync summary"
Write-Host "-----------------"
Write-Host "Tasks parsed: $($allTasks.Count)"
Write-Host "Skipped (already had Jira key): $skippedExistingCount"
Write-Host "Matched existing parent subtasks: $matchedParentCount"
Write-Host "Created in Jira: $createdCount"
Write-Host "Updated Jira summary/description: $updatedFieldsCount"
Write-Host "Update Jira summary/description failed: $updateFieldsFailedCount"
Write-Host "Status synced in Jira: $statusSyncedCount"
Write-Host "Status sync failed: $statusSyncFailedCount"
Write-Host "Output report: $OutputJson"

$preview | Format-Table -AutoSize
