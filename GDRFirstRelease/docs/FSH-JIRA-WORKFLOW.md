# FSH and Jira - Practical Team Workflow

This document defines the shared team workflow for keeping the repository TODO lists and Jira in sync.

Goals:

1. Every active task exists in both the repo and Jira.
2. Every commit and pull request is linked to the correct Jira issue.
3. We can read assigned Jira issues and execute them directly in this repo.

---

## 1. Prerequisites

The following must be in place:

1. Jira is connected to GitHub for this repository.
2. You are signed in to the Jira integration in VS Code.
3. You have Jira project permissions to create, comment, update, and close issues.

Verification:

1. Fetch your assigned Jira issues in VS Code.
2. If you can see issue data and status, the connection is ready.

---

## 2. Team Standards (Always Required)

### 2.1 Branch naming

Use one of these formats:

- feature/KGIT-386-fsh-migration
- fix/GDR-63-reference-validation
- chore/KGIT-387-doc-update

### 2.2 Commit message format

Always include the issue key in the first line.

Format:

- KGIT-386 Short clear action
- GDR-63 Short clear action

Examples:

- KGIT-386 Add FSH instance for StockholmGenomicDevice
- KGIT-387 Update mapping docs for device changes
- GDR-63 Fix extension reference validation rule

### 2.3 Pull request title

PR title must start with the issue key.

Example:

- KGIT-386 Add missing FSH instances for profile examples

---

## 3. Keep TODO and Jira in 1:1 Sync

Source files:

- TODO.md
- ISSUES-TODO-LIST.md

Rules:

1. Every active TODO item must include a Jira issue key.
2. Every Jira issue in progress must be traceable to a TODO item.

### 3.1 Weekly operating routine

1. Groom TODO lists and select this week's tasks.
2. Create Jira issues for TODO items missing an issue key.
3. Update each TODO line with the issue key.
4. Move Jira issues to the correct workflow state, such as To Do or In Progress.

TODO examples:

- [ ] KGIT-501 Create instance for StockholmGenomicSpecimen
- [ ] KGIT-502 Add metadata in CodeSystem StockholmGenomicStudyTypeCS

### 3.2 Minimum content required in each Jira issue

Each issue should include:

1. Reference to the exact TODO line or TODO section.
2. Clear acceptance criteria.
3. Target files or folders, for example input/fsh/Instances.
4. Validation method, for example _genonce.bat and qa.html review.

---

## 4. Task Lifecycle (Repo + Jira)

For each TODO/Jira task:

1. Create or open the Jira issue.
2. Create a branch using the issue key.
3. Implement the FSH change.
4. Commit with the issue key.
5. Push and create a PR with the issue key.
6. Update Jira with short progress and validation results.
7. When PR is merged, mark TODO item done and move Jira issue to Done.

This keeps the repo and Jira aligned at all times.

---

## 5. Create, Update, and Close Jira Issues

### 5.1 Create

Create an issue whenever a TODO item has no key.

Title template:

- [karolinska] <short task title>

Description template:

1. Background: why the task is needed.
2. Scope: exact expected change.
3. Files: which files are affected.
4. Acceptance criteria: how completion is verified.

### 5.2 Update

During implementation, update the issue with:

1. What changed.
2. PR link when available.
3. Build/QA result summary.

### 5.3 Close

After merge:

1. Set Jira status to Done.
2. Mark the corresponding TODO item as complete.
3. If follow-up work remains, create a new TODO line and a new Jira issue.

---

## 6. Commits in Jira and Jira Comments

Baseline behavior (always):

1. Jira shows branches, commits, and PRs in the Development panel when the issue key is present in branch/commit/PR text.

Optional behavior:

1. Auto-comments on issues via Jira Automation.
2. Rule can post comments on commit or PR events.

Recommendation:

1. First enforce strong issue-key discipline in branch and commit naming.
2. Then add automation for comments when the team is ready.

---

## 7. Read Assigned Jira Issues and Work with Copilot

Daily workflow:

1. Fetch assigned Jira issues (open and in progress).
2. Select one issue.
3. Ask Copilot to break it into concrete file changes.
4. Let Copilot implement changes, run build, review QA, and update docs.

Prompt examples:

- Show my assigned Jira issues and suggest which one to start with.
- Help me complete KGIT-386 step by step in this repository.
- Update TODO so it mirrors KGIT-386 and related subtasks.

---

## 8. FSH Definition of Done Linked to Jira

An issue is complete only when all conditions below are met:

1. FSH change exists in the correct source path under input/fsh.
2. Build has been executed and is acceptable for the change scope.
3. qa.html has been reviewed and no new blocking errors were introduced.
4. PR exists with issue key and is merged.
5. Jira issue status is Done.
6. Matching TODO line is checked complete.

---

## 9. Team Quickstart

Run this in the next planning meeting:

1. Select 5 highest-priority TODO lines.
2. Create 5 Jira issues, one per TODO line.
3. Add each issue key back into each TODO line.
4. Assign an owner to each issue.
5. Start implementation with branch and commit naming standards above.

---

## 10. Checklist

- [ ] Jira and GitHub integration is active
- [ ] All active TODO lines include a Jira issue key
- [ ] All active Jira issues are represented in TODO
- [ ] All commits include an issue key
- [ ] All PR titles start with an issue key
- [ ] Jira status and TODO status are updated together
