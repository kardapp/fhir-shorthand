# 06 - GitHub-arbetssätt (branch, commit, PR)

## Mål
Skapa spårbar, granskbar och stabil leverans av FSH-ändringar.

## Rekommenderat flöde
1. Skapa en branch per uppgift (gärna kopplad till Jira-ticket).
2. Gör små, logiska commits med tydliga meddelanden.
3. Öppna PR tidigt och uppdatera löpande.
4. Kör build/QA före merge.

## Commit-principer
- En commit ska ha ett tydligt syfte.
- Beskriv vad och varför, inte bara att filer ändrats.
- Undvik att blanda dokumentation och kodändringar utan orsak.

## PR-checklista
- Syfte och scope tydligt beskrivet.
- Påverkade profiler/extensions listade.
- QA-status sammanfattad (fel, varningar, avvikelser).
- Eventuella kända begränsningar dokumenterade.

## Kodgranskning i praktiken
- Granska semantiken i FHIR-regler, inte bara syntax.
- Bekräfta att constraints stöder verksamhetskravet.
- Kontrollera att terminologi-binds är rimliga.
- Be om exempelinstanser när tolkningen är tvetydig.
