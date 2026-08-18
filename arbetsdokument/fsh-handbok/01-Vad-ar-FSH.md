# 01 - Vad är FSH

## Kort definition
FHIR Shorthand (FSH) är ett domänspecifikt språk för att definiera FHIR-artefakter i textformat. I stället för att redigera stora JSON-filer skriver man kompakta, läsbara regler som sedan kompileras till FHIR-resurser.

## Varför vi använder FSH
- Högre läsbarhet än rå JSON.
- Lättare kodgranskning i GitHub (diffar blir tydligare).
- Snabbare iteration mellan krav och implementation.
- Bättre samarbete mellan informatik och utveckling.

## Centrala begrepp
- Profil: en anpassning av en basresurs (t.ex. Patient, Observation).
- Extension: tillägg av information som inte finns i basresursen.
- ValueSet/CodeSystem: terminologi för kodade fält.
- Instance: exempeldata eller resurser för test/dokumentation.
- Invariant: regel/constraint som måste uppfyllas.

## Enkel mental modell
1. Vi skriver FSH i `GDRFirstRelease/input/fsh/`.
2. SUSHI omvandlar FSH till FHIR JSON i `fsh-generated/`.
3. IG Publisher validerar och bygger Implementation Guide till `output/`.

## När FSH inte räcker ensam
- Vid komplex felsökning läser vi även genererad JSON för att verifiera resultatet.
- Vid import av existerande profiler använder vi FHIR to FSH eller GoFSH för konvertering.
