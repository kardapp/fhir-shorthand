# Att göra-lista


---

- [ ] Skapa fungerande dependency till basprofil i StockholmGenomicPatient
- [ ] Alla koder, i value sets och hårdkodade CodeableConcepts, ska uppdateras när SnomedCT-begrepp lagts in i internationella releasen
- [ ] Lägga till läslängd i geneSequencing- profilen  – Engelsk term: Read cycle. Read cycle kan var både ett numeriskt värde + antingen Paired end read (PE) eller Single end read (SE)

## IG Publisher-fel att fixa (2026-06-26)

### 1) Fel kod i DeviceNameType
- [ ] Fixa `Device.deviceName[0].type` i `fsh-generated/resources/Device-BioinformaticsPipelineDevice-Example.json`: byt `modelname` till giltig kod i FHIR R4 `DeviceNameType`.
- [ ] Verifiera att `package.tgz`-felet för R4B-konvertering försvinner efter ändringen.

### 2) Canonical URL mismatch
- [ ] Aligna canonical URL i `CodeSystem-stockholm-genomic-device-type-cs` (filer/definition och förväntad URL måste matcha).
- [ ] Aligna canonical URL i `StructureDefinition-StockholmGenomicExtensionSpecimen`.
- [ ] Aligna canonical URL i `ValueSet-Stockholm-genomic-study-type-vs`.
- [ ] Aligna canonical URL i `ValueSet-stockholm-genomic-device-type-vs`.
- [ ] Aligna canonical URL i `ValueSet-stockholm-genomic-study-data-format-vs`.

### 3) Fel targetProfile-typ i Extension
- [ ] Fixa `targetProfile`-pekning där `Extension.value[x]` är `Reference` men profil pekar på en Extension (måste peka på Resource-profil).
- [ ] Kontrollera att både differential- och snapshot-felen försvinner.

### 4) Trasiga länkar i generated HTML
- [ ] Fixa länken `profiles.html` i startsidan.
- [ ] Fixa länken `downloads.html` i startsidan.
- [ ] Fixa interna länkar till `...study-analysis-procedure-definitions.html#Procedure.code.coding` i generated narrative.

### 5) Verifiering efter fix
- [ ] Kör IG Publisher lokalt/offline: `java -jar input-cache\\publisher.jar -ig . -tx n/a` från `GDRFirstRelease`.
- [ ] Öppna `output/qa.html` och kontrollera att error/warning/broken links har gått ner.
- [ ] Dokumentera kvarstående fel med datum i denna TODO.
