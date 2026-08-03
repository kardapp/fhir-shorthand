# Arbetssammanfattning (Från 7 juli 2026)

Denna fil sammanfattar arbetet som har genomförts från och med 7 juli 2026.


  - Lade till exempelinstanser för genomiska extensions, inklusive pedigree, specimen och analysis pipeline.
  - Uppdaterade genomiska extension-instanser till inline-usage och lade till identifierare.
  - Förbättrade workflow för publisher-uppdatering med ett lokalt uppdateringsskript för att undvika överskrivning av `.bat`/`.sh` vid IG-generering.
  - Uppdaterade numreringen på index-sidan för korrekt HTML-visning.
  - Rättade varningar i instanser.
  - Förbättrade profiler för genomiska specimen med fler identifierare och kodningsuppdateringar.
  - Löste tidigare profilvalideringsfel.
  - Uppdaterade instruktioner för IG-generering.
  - Uppdaterade restriktioner i study analysis-profilen (inklusive ändringar i code/cardinality och städning av child coding-attribut).
  - Uppdaterade dokumentations-URI:er för instanser av bioinformatics pipeline och nanopore sequencing platform.
  - Uppdaterade experimental-status i ValueSet och höjde beroendeversionen för `hl7.fhir.us.core`.
  - Lade till Bundle-profil och Bundle-exempel för genomiska inlämningar.
  - Uppdaterade tillhörande index- och dokumentationssidor.
  - Lade till use-case-dokumentation för CapabilityStatement.
  - Lade till instansen `GDRCapabilityStatement`.
  - Lade till dokumentation för Search Parameters och uppdaterade TODO-checklistan för `GDRCapabilityStatement`.
  - Rättade kanoniska `SearchParameter`-definitioner i `GDRCapabilityStatement` (Patient/Procedure/DocumentReference-relaterade definitioner).
  - Förbättrade dokumentationen i genomikprofiler med tydligare profilbeskrivningar samt elementnivå med `short`/`definition`.
  - Översatte sektioner i `index.md` till engelska.
  - Normaliserade indentering/formattering i profilfiler.
  - Körde om IG-build och validering i offline-läge för terminologi.

## Nuvarande publiceringsproblem

genonce.bat fungerar inte och vi måste hoppa över terminologiservern genom att köra cmd /c "(echo.|_genonce.bat -tx n/a)". Tidigare fungerade det, men nu behöver vi åtgärda detta problem.

## Update:

Det verkar som att terminologiservern ibland inte fungerar eller ansluter, därför var jag tvungen att hoppa över det. Men nu fungerar det bra igen med koden.
