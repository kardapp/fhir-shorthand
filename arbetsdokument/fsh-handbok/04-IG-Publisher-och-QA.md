# 04 - IG Publisher och QA

## Vad är IG Publisher?
IG Publisher tar fram färdiga Implementation Guide-sidor (HTML), validerar artefakter och sammanställer QA-rapporter.

## Körning i detta repo
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
java -jar input-cache\publisher.jar -ig .
```

Snabbare lokal iteration utan terminologivalidering:
```powershell
java -jar input-cache\publisher.jar -ig . -tx n/a
```

## Viktiga output-filer
- `GDRFirstRelease/output/index.html` - själva guiden.
- `GDRFirstRelease/output/qa.html` - full QA.
- `GDRFirstRelease/output/qa.min.html` - koncentrerad felvy.

## Kvalitetsrutin inför PR
1. Kör Publisher.
2. Kontrollera sammanfattningen i `qa.html`.
3. Hantera fel först, därefter varningar med hög påverkan.
4. Dokumentera medvetna undantag i PR-beskrivning.

## Terminologi-server och timeout
- Standard är validering mot `tx.fhir.org`.
- Vid tillfälliga nätverksproblem kan `-tx n/a` användas lokalt för att inte blockera iteration.
- `-tx n/a` ska inte vara normalläge för release-kritisk validering.

## Uppdatera Publisher
Om cache- eller kompatibilitetsvarningar uppstår:
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
.\_updatePublisher.bat
```
