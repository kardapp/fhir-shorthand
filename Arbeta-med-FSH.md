# Arbeta med FSH – FHIR Shorthand

## Innehåll
1. [Varför FHIR Shorthand?](#varför-fhir-shorthand)
2. [Överblick – verktyg och flöde](#överblick--verktyg-och-flöde)
3. [FSH-syntax – de tre delarna](#fsh-syntax--de-tre-delarna)
4. [GoFSH – från JSON till FSH](#gofsh--från-json-till-fsh)
5. [SUSHI – från FSH till FHIR JSON](#sushi--från-fsh-till-fhir-json)
6. [IG Publisher – från FHIR JSON till webbpublicering](#ig-publisher--från-fhir-json-till-webbpublicering)
7. [Konfigurationsfiler](#konfigurationsfiler)
8. [Paket och beroenden (Packages)](#paket-och-beroenden-packages)
9. [Installationsöversikt – program som krävs](#installationsöversikt--program-som-krävs)
10. [Mappstruktur](#mappstruktur)

---

## Varför FHIR Shorthand?

FHIR-profiler och -extensions definieras normalt som stora JSON-filer (StructureDefinitions) som är svårlästa och svåra att underhålla. En enda profil kan ha hundratals rader JSON.

**FHIR Shorthand (FSH)** är ett domänspecifikt språk som låter oss skriva samma profiler i ett mycket mer läsbart format:

**Utan FSH – StructureDefinition JSON (svårläst, ~200 rader):**
```json
{
  "resourceType": "StructureDefinition",
  "id": "stockholm-genomic-specimen",
  "url": "https://pub.regionstockholm.se/fhir/gdr/StructureDefinition/stockholm-genomic-specimen",
  "name": "StockholmGenomicSpecimen",
  "status": "draft",
  "differential": {
    "element": [
      {
        "id": "Specimen.identifier",
        "path": "Specimen.identifier",
        "min": 1,
        "mustSupport": true
      }
      ...
    ]
  }
}
```

**Med FSH – läsbart och underhållbart (~10 rader):**
```
Profile: StockholmGenomicSpecimen
Parent: Specimen
Id: stockholm-genomic-specimen
Description: "Profile to store data about the specimen used in the genomic study."
* identifier 1..* MS
```

**Fördelar med FSH:**
- ✅ Mycket kortare och lättare att läsa
- ✅ Versionshantering i git fungerar bra (text vs JSON-blobs)
- ✅ Enkel att granska i kod-review
- ✅ Kompileras automatiskt till korrekt FHIR JSON via SUSHI
- ✅ Industristandard – används av HL7 och många nationella IGs

---

## Överblick – verktyg och flöde

```
┌─────────────────────────────────────────────────────────────────┐
│                       ARBETSFLÖDE                               │
│                                                                 │
│  Befintliga JSON       FSH-filer           FHIR JSON            │
│  StructureDef     →   (källkod)      →    (autogenererat)  →   │
│  (Simplifier)     GoFSH              SUSHI                     │
│                                                                 │
│                    FHIR JSON + markdown                         │
│                         ↓                                       │
│                    IG Publisher                                  │
│                         ↓                                       │
│               HTML-webbsajt (Implementation Guide)              │
└─────────────────────────────────────────────────────────────────┘
```

| Verktyg | Roll | Körs |
|---------|------|------|
| **VS Code** | Editor för FSH-filer | Alltid |
| **GoFSH** | Konverterar befintlig JSON → FSH (engångskörning) | En gång vid migrering |
| **SUSHI** | Kompilerar FSH → FHIR JSON | Ingår i IG Publisher |
| **IG Publisher** | Bygger hela Implementation Guide-webbsajten | Vid varje bygge |
| **Git/GitHub** | Versionshantering av FSH-källkod | Alltid |

---

## FSH-syntax – de tre delarna

En FSH-definition består alltid av tre delar: **Deklaration**, **Metadata** och **Regler**.

### Del 1: Deklaration

Deklarationen talar om vilken typ av FHIR-resurs vi skapar. Första raden i varje definition.

| Deklaration | Skapar |
|-------------|--------|
| `Profile:` | En begränsning av en befintlig FHIR-resurs |
| `Extension:` | En FHIR Extension |
| `CodeSystem:` | Ett kodsystem med egna koder |
| `ValueSet:` | En samling koder (från ett eller flera kodsystem) |
| `Instance:` | En konkret exempelresurs |
| `Alias:` | En förkortning för en lång URL |

**Exempel:**
```fsh
Profile: StockholmGenomicSpecimen
Extension: StockholmGenomicProcedureExtensionLaboratoryProcess
CodeSystem: StockholmGenomicDeviceTypeCS
ValueSet: StockholmGenomicDeviceTypeVS
```

---

### Del 2: Metadata

Metadata är nyckel-värde-par som beskriver resursen. Skrivs direkt under deklarationen, utan `*`.

| Nyckelord | Beskrivning |
|-----------|-------------|
| `Id:` | Tekniskt ID, används i URL:en |
| `Parent:` | Vilken FHIR-resurs profilen utgår från |
| `Title:` | Visningsnamn i IG |
| `Description:` | Beskrivande text |
| `Context:` | Var en Extension får användas |
| `InstanceOf:` | Vilken profil en Instance följer |

**Exempel – Profile:**
```fsh
Profile: StockholmGenomicSpecimen
Parent: Specimen
Id: stockholm-genomic-specimen
Title: "Stockholm Genomic Specimen"
Description: "Profile to store data about the specimen used in the genomic study."
```

**Exempel – Extension:**
```fsh
Extension: StockholmGenomicProcedureExtensionLaboratoryProcess
Id: stockholm-genomic-procedure-extension-laboratory-process
Description: "Extension for linking a Procedure to a laboratory process step."
Context: Procedure
```

**Exempel – CodeSystem:**
```fsh
CodeSystem: StockholmGenomicDeviceTypeCS
Id: stockholm-genomic-device-type-cs
Title: "Stockholm Genomic Device Type CodeSystem"
Description: "Custom code system representing genomic device types."
```

---

### Del 3: Regler

Regler börjar alltid med `*` och modifierar element i resursen. Det är här den faktiska profileringen sker.

#### Kardinalitetsregler – hur många gånger ett element får förekomma
```fsh
* identifier 1..*     // minst 1, obegränsat många
* status 1..1         // exakt 1 (obligatoriskt)
* note 0..0           // förbjudet (0 till 0)
* value[x] 1..        // minst 1, max obegränsat
```

#### Must Support – element som implementatörer MÅSTE stödja
```fsh
* identifier MS
* subject 1..1 MS
```

#### Bindningsregler – kopplar ett element till ett ValueSet
```fsh
* status from StockholmGenomicProcedureStatusVS (required)
* code from http://loinc.org/vs/LL3044-6 (preferred)
```

#### Typbegränsningsregler – begränsar vilken typ ett element kan vara
```fsh
* value[x] only Reference(Procedure)
* subject only Reference(Patient)
```

#### Tilldelningsregler – sätter ett fast värde
```fsh
* identifier[requester-sample-identifier].type = $v2-0203#PLAC
* identifier[requester-sample-identifier].type.coding.display = "Placer Identifier" (exactly)
```

#### Caret-regler – sätter metadata på element (^-notation)
```fsh
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^experimental = false
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding.code"
* identifier ^slicing.rules = #closed
```

#### Extension-regler – lägger till en extension
```fsh
* extension contains StockholmGenomicSpecimenExtensionSource named specimen-source 0..*
* extension[specimen-source] MS
```

#### Koddefinitioner i CodeSystem
```fsh
* #library-prep-kit "Library preparation kit"
* #sequencing-platform "Gene sequencing platform"
* #bioinformatic-pipeline "Bioinformatic pipeline"
```

---

### Aliases – förkortningar för långa URL:er

Aliases definieras i en separat fil (`aliases.fsh`) och kan användas i alla andra FSH-filer:

```fsh
// aliases.fsh
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $StockholmGenomicDevice = https://pub.regionstockholm.se/fhir/gdr/StructureDefinition/stockholm-genomic-device
```

Används sedan så här:
```fsh
* identifier[requester-sample-identifier].type = $v2-0203#PLAC
* extension contains $StockholmGenomicDevice named device 0..1
```

---

## GoFSH – från JSON till FSH

**GoFSH** (Go FHIR Shorthand) är ett verktyg för att **konvertera befintliga FHIR JSON StructureDefinitions till FSH-format**. Det används primärt en gång när man migrerar ett befintligt projekt till FSH-workflow.

### Installation
```bash
npm install -g gofsh
```

### Körning
```bash
# Konvertera alla JSON-filer i en mapp till FSH
gofsh path/till/json-filer/ --out path/till/fsh-output/

# Specificera FHIR-version
gofsh path/till/json-filer/ --fhir-version 4.0.1
```

### Viktigt att veta om GoFSH-output

GoFSH genererar ofta kod som behöver rensas upp:

❌ **Problem: Hardcodade `^url`-värden** (ska tas bort)
```fsh
// GENERERAT AV GoFSH - SKA INTE BEHÅLLAS
* ^url = "https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-device-type-cs"
```

✅ **Korrekt: Låt SUSHI generera URL automatiskt från sushi-config.yaml**
```fsh
// Ta bort ^url-raden - SUSHI skapar den korrekt från canonical-basen
CodeSystem: StockholmGenomicDeviceTypeCS
Id: stockholm-genomic-device-type-cs
```

SUSHI sätter automatiskt: `{canonical}/{resourceType}/{Id}` → `https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-device-type-cs`

---

## SUSHI – från FSH till FHIR JSON

**SUSHI** (SUSHI Unshortens SHorthand Inputs) är kompilatorn som omvandlar FSH-filer till FHIR-kompatibla JSON-resurser.

### Installation
```bash
npm install -g fsh-sushi
```

### Körning (fristående)
```bash
# Kör i projektmappen
sushi .

# Kontrollera version
sushi --version
```

### Automatisk körning via IG Publisher
SUSHI körs automatiskt som ett steg i `_genonce.bat` – du behöver inte köra det separat.

### Vad SUSHI gör
1. Läser alla `.fsh`-filer i `input/fsh/`
2. Kompilerar till FHIR JSON StructureDefinitions
3. Skriver resultatet till `fsh-generated/resources/`
4. Genererar `ImplementationGuide-[id].json`

### SUSHI-resultat (exempel)
```
========================= SUSHI RESULTS ===========================
| Profiles  | Extensions | Logicals  | Resources |
|-----------|------------|-----------|-----------|
|    10     |     13     |     0     |     0     |
| ValueSets | CodeSystems|  Instances|           |
|-----------|------------|-----------|-----------|
|     5     |     3      |     2     |           |

0 Errors    0 Warnings
===================================================================
```

---

## IG Publisher – från FHIR JSON till webbpublicering

**IG Publisher** är HL7s officiella verktyg för att bygga en komplett Implementation Guide (IG) – en webbpublicerbar dokumentation av alla profiler, extensions, kodsystem och värdemängder.

### Vad IG Publisher gör (i ordning)
1. Kör SUSHI (FSH → JSON)
2. Validerar alla FHIR-resurser mot terminologiserver (tx.fhir.org)
3. Genererar HTML via Jekyll
4. Kontrollerar alla HTML-länkar
5. Skapar ett publicerbart zip-paket

### Köra ett bygge
```batch
# Kör från GDRFirstRelease-mappen i VS Code terminal
.\_genonce.bat
```

### Förstå byggtiden
Bygget tar ~10-15 minuter pga:
- SUSHI-kompilering (~35 sek)
- Terminologivalidering mot tx.fhir.org (~1-2 min)
- Jekyll HTML-generering (~90 sek)
- Länkkontroll av 1000+ HTML-filer (~30 sek)

### Tolka slutresultatet
```
Errors: 1, Warnings: 85, Info: 30, Broken Links: 2
```

| Typ | Påverkar FHIR-servrar? | Påverkar publicering? |
|-----|----------------------|-----------------------|
| **Error** | Ja – kritiskt | Ja |
| **Warning** | Nej | Delvis (best practice) |
| **Info** | Nej | Nej |
| **Broken Links** | Nej | Bara HTML-dokumentation |

---

## Konfigurationsfiler

### `sushi-config.yaml` – projektets huvudkonfiguration

Den viktigaste filen i projektet. Styr SUSHI och IG Publisher.

```yaml
id: RegionStockholm
canonical: https://pub.regionstockholm.se/fhir/gdr   # Bas-URL för alla resurser
name: RegionStockholmGDR
title: Stockholm Genomic Data Repository Implementation Guide
description: FHIR Implementation Guide for Stockholm Genomic Diagnostic Reporting
status: draft
version: 0.0.1-alpha1
fhirVersion: 4.0.1

publisher:
  name: Karolinska University Hospital
  url: https://www.karolinskahospital.com/

dependencies:
  hl7.fhir.us.core: 3.1.0
  hl7.fhir.uv.genomics-reporting: 3.0.0

menu:
  Home: index.html
  Artifacts: artifacts.html
```

**Canonical URL är kritisk:** SUSHI auto-genererar URL:en för varje resurs som:
`{canonical}/{resourceType}/{Id}`  
T.ex. → `https://pub.regionstockholm.se/fhir/gdr/StructureDefinition/stockholm-genomic-specimen`

### `ig.ini` – IG Publisher-konfiguration
```ini
[IG]
ig = fsh-generated/resources/ImplementationGuide-RegionStockholm.json
template = fhir.base.template#0.8.0
```

### `input/pagecontent/index.md` – IG:ns startsida
Markdown-fil som genereras till IG:ns hemsida. Bra ställe för introduktion, kontaktinformation och navigation.

### `.gitignore` – vad som inte versionshanterats
```
/output          # Autogenererade HTML-filer (regenereras vid varje bygge)
/temp            # Temporära byggfiler
/fsh-generated   # SUSHI-output (regenereras)
/input-cache     # FHIR-paketcache
/template        # Template-filer (laddas ner automatiskt)
```

---

## Paket och beroenden (Packages)

FHIR-paket fungerar som npm-paket eller NuGet – de innehåller profiler, kodsystem och resurser från externa IGs som vi kan ärva från.

### Hur de specificeras
I `sushi-config.yaml`:
```yaml
dependencies:
  hl7.fhir.uv.genomics-reporting: 3.0.0   # Genomics Reporting IG
  hl7.fhir.us.core: 3.1.0                 # US Core (basprofiler)
```

### Var de lagras
Paket cachas lokalt i `~/.fhir/packages/` (t.ex. `C:\Users\[namn]\.fhir\packages\`).  
De laddas ner automatiskt vid första bygget om de inte finns.

### Package Registry
Alla publika FHIR-paket finns på: https://registry.fhir.org

### Paket vi använder
| Paket | Version | Innehåll |
|-------|---------|---------|
| `hl7.fhir.uv.genomics-reporting` | 3.0.0 | Genomikrelaterade profiler (GenomicStudy, GenomicReport, etc.) |
| `hl7.fhir.us.core` | 3.1.0 | Basresurser (Patient, Practitioner, etc.) |
| `hl7.fhir.r4.core` | 4.0.1 | FHIR R4 kärna (laddas automatiskt) |
| `hl7.terminology.r4` | 7.2.0 | HL7 terminologi (LOINC, SNOMED mappningar) |
| `fhir.base.template` | 0.8.0 | HTML-template för IG Publisher |

---

## Installationsöversikt – program som krävs

Alla program nedan behöver vara installerade **innan** man kan köra ett bygge.

### 1. Java JDK (obligatorisk)
Krävs för att köra IG Publisher (`publisher.jar`).

```bash
# Kontrollera installation
java --version
# Ska visa: openjdk 17 eller senare (vi kör 25.0.3)
```

**Installera:** https://adoptium.net/ (Eclipse Adoptium – rekommenderas)  
**Alternativ (Windows):** `choco install temurin`

---

### 2. Node.js & npm (obligatorisk)
Krävs för att köra SUSHI.

```bash
# Kontrollera installation
node --version
npm --version
```

**Installera:** https://nodejs.org/ (välj LTS-versionen)

---

### 3. SUSHI (obligatorisk)
FSH-kompilatorn.

```bash
# Installera
npm install -g fsh-sushi

# Kontrollera version
sushi --version
```

---

### 4. Ruby (obligatorisk)
Krävs för Jekyll som genererar HTML.

```bash
# Kontrollera installation
ruby --version
gem --version
```

**Installera Windows:** https://rubyinstaller.org/ (välj "With DevKit")  
**Installera macOS:** `brew install ruby`  
**Installera Linux:** `sudo apt-get install ruby-full`

---

### 5. Jekyll (obligatorisk)
Körs av IG Publisher för att generera HTML från markdown.

```bash
# Installera (körs efter Ruby är installerat)
gem install jekyll

# Kontrollera version
jekyll --version
```

---

### 6. Git (obligatorisk)
Versionshantering.

```bash
# Kontrollera installation
git --version
```

**Installera:** https://git-scm.com/

---

### 7. VS Code (rekommenderas starkt)
Editor med stöd för FSH-syntax.

**Rekommenderade VS Code-tillägg:**
- **FHIR Shorthand** (`joelolofsson.fsh`) – syntax highlighting för FSH
- **GitHub Copilot** – AI-stöd för att skriva FSH
- **GitLens** – förbättrad git-integration

---

### Snabbkontroll – är allt installerat?
Kör detta i VS Code-terminalen:

```bash
java --version
node --version
sushi --version
ruby --version
jekyll --version
git --version
```

Alla kommandon ska returnera ett versionsnummer utan fel.

---

## Mappstruktur

```
fhir-shorthand/
└── GDRFirstRelease/           ← Rot för IG Publisher
    ├── sushi-config.yaml      ← Huvudkonfiguration (VIKTIG)
    ├── ig.ini                 ← IG Publisher-konfiguration
    ├── _genonce.bat           ← Starta bygget (Windows)
    ├── _genonce.sh            ← Starta bygget (Mac/Linux)
    │
    ├── input/                 ← ALLT KÄLLKOD (versionshantera detta)
    │   ├── fsh/               ← FSH-filer
    │   │   ├── aliases/       ← aliases.fsh (URL-förkortningar)
    │   │   ├── profiles/      ← Profiler (.fsh)
    │   │   ├── extensions/    ← Extensions (.fsh)
    │   │   ├── codesystems/   ← CodeSystems (.fsh)
    │   │   ├── valuesets/     ← ValueSets (.fsh)
    │   │   └── Instances/     ← Exempelresurser (.fsh)
    │   └── pagecontent/       ← Markdown-sidor för IG-webbsajten
    │       └── index.md       ← Startsida
    │
    ├── fsh-generated/         ← AUTOGENERERAT av SUSHI (gitignored)
    │   └── resources/         ← FHIR JSON StructureDefinitions
    │
    ├── output/                ← AUTOGENERERAT av IG Publisher (gitignored)
    │   └── *.html             ← Färdig webbsajt redo för publicering
    │
    ├── temp/                  ← Temporärt bygge (gitignored)
    ├── input-cache/           ← FHIR-paketcache (gitignored)
    └── template/              ← HTML-template (gitignored, laddas ner)
```

**Tumregel:** Versionshantera bara `input/` och konfigurationsfilerna. Allt annat genereras automatiskt.

---

*Dokument skapat 2026-07-03 | Region Stockholm / Karolinska University Hospital*
