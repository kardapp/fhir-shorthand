# 07 - Jira-koppling till GitHub

## Varför vi kopplar Jira och GitHub
- Spårbarhet från krav till implementation.
- Enklare uppföljning av vad som är levererat.
- Tydlig kontext vid felsökning och revision.

## Praktiskt arbetssätt
1. Starta arbete från en Jira-ticket.
2. Namnge branch och commits så att Jira-nyckeln framgår (t.ex. `GDR-123`).
3. Länka ticket i PR-beskrivningen.
4. Säkerställ att utvecklingspanelen i Jira visar branch/commit/PR.

## Lokal referens i repot
Detaljerat arbetssätt finns i:
- `GDRFirstRelease/docs/FSH-JIRA-WORKFLOW.md`

## Verifiering av synk
- Branch med Jira-key syns i ticket.
- Commit med Jira-key syns i ticket.
- PR status (open/merged) är synlig i Jira.

## Vanliga orsaker till utebliven synk
- Jira-key saknas i branch- eller commitnamn.
- Integration är inte aktiv/inloggad i verktygen.
- PR skapad utan tydlig koppling till ticket.
