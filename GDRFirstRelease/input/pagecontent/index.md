# Stockholm Genomic Data Repository Implementation Guide

## Introduktion

Denna Implementation Guide definierar FHIR-profiler och artefakter för representation av genomisk data inom Stockholm sjukhuset.

Specifikationen är utformad för att möjliggöra strukturerad rapportering av genetiska analyser, sekvensering, laboratorieprov och medicinska enheter enligt FHIR-standarden R4, med fokus på interoperabilitet och dataintegration i elektroniska patientjournaler.

## Omfattning

Denna guide omfattar:

### Artefakttyper

- **Device-profiler**: Strukturerade definitioner för medicinska enheter
- **Värdesets**: Standardiserade värden för device-status, typ och klassificering
- **Kodningssystem**: Standardiserade koder för device-klassificering
- **Extensions**: Tilläggsfält för dokumentation och metadata

## Målgrupp

### Primära användare

- Systemarkitekter och IT-utvecklare
- Klinisk IT-personal
- FHIR-implementörer
- Projektledare inom digitalisering av hälsovård

## Tekniska detaljer

- **FHIR Version**: 4.0.1
- **Status**: Draft
- **Version**: 0.1.2
- **Canonical URL**: https://pub.regionstockholm.se/fhir/gdr
- **Publisher**: Karolinska University Hospital

## Hur man använder denna guide

1. **Börja med [Artifacts](artifacts.html)** för en översikt över alla definierade profiler, extensions, value sets och code systems
2. **Hämta artefakter** från [Artifacts](artifacts.html) sidan för implementering
3. **Kontakta** [Region Stockholms IT-avdelning](https://www.regionstockholm.se/) för frågor och support

## Versionshistorik

| Version | Datum | Ändringar |
|---------|-------|-----------|
| 0.1.2 | 2025-01-XX | Initial draft version |

---

*Denna specifikation är under utveckling och kan ändras.*
