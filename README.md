# fhir-shorthand

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/kardapp/fhir-shorthand)

Repo for health-informaticians to develop workflows with FHIR Shorthand instead of Forge FHIR

## Getting Started

### Using GitHub Codespaces

Click the badge above to open this repository in GitHub Codespaces. The development environment comes pre-configured with:

- **FHIR Shorthand VSCode Extension** (`FHIR-Shorthand.vscode-fsh`) - Provides syntax highlighting and language support for FSH files
- **FSH SUSHI** - Automatically installed globally via npm

### Manual Setup

If you prefer to work locally, follow these steps:

1. Clone this repository
2. Install Node.js (version 18 or higher recommended)
3. Install FSH SUSHI globally:
   ```bash
   npm install -g fsh-sushi
   ```
4. Install the [FHIR Shorthand VSCode extension](https://marketplace.visualstudio.com/items?itemName=FHIR-Shorthand.vscode-fsh) from the Visual Studio Code Marketplace

## About FHIR Shorthand

FHIR Shorthand (FSH) is a domain-specific language for defining FHIR artifacts involved in creation of FHIR Implementation Guides (IG). The goal of FSH is to allow Implementation Guide developers to author FHIR profiles, extensions, and implementation guides more efficiently and intuitively.

# Arbetsätt: FHIR-profilering med GitHub, VS Code, FSH/SUSHI, Forge & Simplifier

## 1. Versionshantering och samarbete (GitHub & VS Code)
- All kod och konfiguration (FSH-filer, sushi-config.yaml, mm) lagras i ett gemensamt GitHub-repo.
- Vi arbetar i VS Code, där vi redigerar FSH-filer och hanterar versioner via Git-integrationen.
- Ändringar comittas och pushas regelbundet till GitHub för spårbarhet och samarbete.

## 2. Modellering och konvertering (Forge & Simplifier → GoFSH)
- FHIR-resurser och profiler som har modellerats initialt i Forge och är publicerade till Simplifier.net kan laddas ner som JSON och placeras initialt i mappen `simplifier-json/` i projektet.
- För att konvertera till FSH-filer flyttas först json-filerna till mappen ‘GoFSH-input’
- Kommandot GoFSH används sedan för att konvertera dessa JSON-resurser till FSH-filer, som sparas i `input/fsh/` (eller underkataloger). 
- Konvertering av enskild fil kan göras genom att högerklicka på filen och välja FHIR to FSH.
- Annars kan kommandot GoFSH användas för att konvertera alla filer i en mapp. Det görs via följande kommando gofsh "GDR first release\GoFSH-input" -o "GDR first release\input\fsh"

## 3. FSH-utveckling och SUSHI
- FSH-filerna redigeras och vidareutvecklas i VS Code.
- SUSHI körs för att generera FHIR-resurser (JSON) från FSH-filerna. Dessa hamnar i `output/`-mappen.
- `sushi-config.yaml` används för att konfigurera IG:t och deklarera dependencies till externa IG:n.

## 4. Implementation Guide och validering (IG Publisher)
- IG Publisher används för att bygga och validera Implementation Guide (IG) baserat på `output/`-mappen.
- Eventuella fel eller varningar åtgärdas genom att justera FSH-filer eller konfiguration.

## 5. Best Practices och konflikthantering
- `simplifier-json` används endast för att packa upp zip-filer från simplifier. json-filerna flyttas sedan till ‘GoFSH-input’ där de konverteras till FSH-filer.
- `output/` innehåller alltid de resurser som genereras av SUSHI och används av IG Publisher.
- All utveckling sker i FSH-filer för spårbarhet och enkel versionshantering.
- Dependencies till externa IG:n deklareras i `sushi-config.yaml`.

## 6. Samarbete och kunskapsdelning
- All dokumentation, arbetsflöden och lärdomar sparas i README.md eller motsvarande dokument i repot.
- Regelbundna kodgranskningar och gemensamma genomgångar för att sprida kunskap i teamet.

---

> Denna README kan även kopieras till Confluence för vidare kunskapsdelning.

## IG Publisher: lokal körning och felsökning

### Vad som händer i kedjan
1. SUSHI läser FSH-filerna och genererar FHIR-resurser i `output/`.
2. IG Publisher läser `output/`, bygger HTML och validerar resurserna.
3. QA-rapporten skrivs till `output/qa.html` och huvudsidan till `output/index.html`.

### Så kör du IG Publisher lokalt
Gå till `GDRFirstRelease` och kör:

```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
$env:JAVA_TOOL_OPTIONS='-Dfile.encoding=UTF-8'
java -jar input-cache\publisher.jar -ig . -tx n/a
```

Det här är den lokala/offline-varianten. Flaggan `-tx n/a` gör att Publisher inte försöker nå terminologiservern `tx.fhir.org`.

### Var du öppnar resultatet
- `output/index.html` för själva IG:t
- `output/qa.html` för valideringsrapporten

### Felbild vi såg senast
- `package.tgz` misslyckades när paketet skulle konverteras till R4B.
- Rotorsaken var `Device.deviceName[0].type` i `fsh-generated/resources/Device-BioinformaticsPipelineDevice-Example.json`.
- Värdet `modelname` är inte giltigt för `DeviceNameType` i FHIR R4.
- Det gav även `Errors: 16`, `Warnings: 62` och `Broken Links: 4` i QA-rapporten.

### Vad som behöver göras
- Ändra `Device.deviceName[0].type` från `modelname` till ett giltigt `DeviceNameType`-värde.
- Kör IG Publisher igen lokalt.
- Kontrollera `output/qa.html` tills felräkningen gått ner och de trasiga länkarna är utredda.
