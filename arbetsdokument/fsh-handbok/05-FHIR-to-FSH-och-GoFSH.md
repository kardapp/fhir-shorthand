# 05 - FHIR to FSH och GoFSH-flöde

## Syfte
När vi har profiler i JSON (t.ex. från Forge/Simplifier) vill vi få in dem i vårt FSH-baserade arbetsflöde.

## Två vägar in
- Enskild fil: VS Code-kommandot FHIR to FSH.
- Flera filer: GoFSH på en input-mapp.

## Rekommenderat massflöde
1. Lägg nedladdade JSON-profiler i `simplifier-json/`.
2. Flytta relevanta filer till `GDRFirstRelease/GoFSH-input/`.
3. Kör konvertering:
```bash
gofsh "GDRFirstRelease/GoFSH-input" -o "GDRFirstRelease/input/fsh"
```
4. Kvalitetssäkra genererad FSH innan fortsatt utveckling.

## Efter konvertering - alltid nödvändigt
- Rensa upp namn och struktur för läsbarhet.
- Justera cardinalities och binding strength utifrån lokala krav.
- Säkerställ konsekvent namngivning enligt teamets standard.
- Kör SUSHI och därefter IG Publisher.

## Vanliga konverteringsartefakter
- Verbos FSH som behöver förenklas.
- Överflödiga regler som speglar basresurs utan lokalt värde.
- Inkonsekventa alias eller canonical-referenser.

## Definition of Done för importerad profil
- FSH är läsbar och team-godkänd.
- Build passerar utan blockerande fel.
- Minst en exempelinstans finns vid behov.
- Ändringen är spårbar i PR med tydlig beskrivning.
