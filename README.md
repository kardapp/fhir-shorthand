# fhir-shorthand

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/kardapp/fhir-shorthand)

Repo for health-informaticians to develop workflows with FHIR Shorthand instead of Forge FHIR

---

## Om FHIR Shorthand

FHIR Shorthand (FSH) är ett domänspecifikt språk för att definiera FHIR-artefakter i Implementation Guides. Målet är att göra det enklare och mer strukturerat att arbeta med FHIR-profiler, extensions och IG:n jämfört med att redigera JSON direkt.

---

## Förutsättningar – program som måste installeras

Dessa verktyg behövs för att kunna arbeta med FSH och köra IG Publisher lokalt.

| Program | Varför det behövs |
|---|---|
| **Node.js + npm** | Krävs för att installera och köra SUSHI. |
| **SUSHI** | Kompilerar `.fsh`-filer till FHIR JSON-resurser. Körs automatiskt av IG Publisher som ett försteg. |
| **Java JDK 17+** | IG Publisher (`publisher.jar`) är en Java-applikation. Vi använder Eclipse Adoptium (Temurin). |
| **Ruby** | Jekyll är skrivet i Ruby och kräver Ruby-miljön. |
| **Jekyll** | IG Publisher använder Jekyll för att bygga de statiska HTML-sidorna i `output/`. |

### Installationsordning (Windows)
1. Installera [Node.js](https://nodejs.org/) (version 18 eller högre).
2. Installera SUSHI: `npm install -g fsh-sushi`
3. Installera [Eclipse Adoptium JDK](https://adoptium.net/) (version 17 eller högre).
4. Installera [Ruby+Devkit](https://rubyinstaller.org/downloads/) via RubyInstaller för Windows.
5. Installera Jekyll: `gem install jekyll bundler`
6. Ladda ner `publisher.jar` via skriptet `_updatePublisher.bat` i `GDRFirstRelease/`.
7. Installera [FHIR Shorthand VS Code-extension](https://marketplace.visualstudio.com/items?itemName=FHIR-Shorthand.vscode-fsh).

> **Alternativ:** Öppna repot i GitHub Codespaces (knappen högst upp) – Node.js och SUSHI är förkonfigurerade där.

---

## Arbetsflöde

### 1. Versionshantering (GitHub & VS Code)
- All kod och konfiguration (FSH-filer, `sushi-config.yaml` m.m.) lagras i detta GitHub-repo.
- Ändringar committas och pushas regelbundet för spårbarhet och samarbete.

### 2. Modellering och konvertering (Forge/Simplifier → GoFSH → FSH)
- Profiler från Forge/Simplifier laddas ner som JSON och läggs i `simplifier-json/`.
- JSON-filerna flyttas till `GoFSH-input/` och konverteras till FSH:
  ```bash
  gofsh "GDRFirstRelease/GoFSH-input" -o "GDRFirstRelease/input/fsh"
  ```
- Enskild fil: högerklicka i VS Code → *FHIR to FSH*.

### 3. FSH-utveckling och SUSHI
- FSH-filer redigeras i VS Code under `input/fsh/`.
- `sushi-config.yaml` konfigurerar IG:t och deklarerar beroenden till externa IG:n.
- SUSHI körs automatiskt av IG Publisher, men kan även köras manuellt: `sushi .`

### 4. Bygga och validera (IG Publisher)
Se nästa avsnitt.

### 5. Best practices
- `simplifier-json/` används bara för nedladdade originalfiler – konvertera alltid vidare till FSH.
- All aktiv utveckling sker i FSH-filer, aldrig direkt i `fsh-generated/`.
- Dependencies deklareras i `sushi-config.yaml`.

---

## IG Publisher – körning och felsökning

### Vad som händer i kedjan
1. **SUSHI** läser FSH-filerna och genererar FHIR-resurser (JSON) i `fsh-generated/`.
2. **IG Publisher** tar resurserna, validerar dem och bygger HTML via Jekyll.
3. Resultat hamnar i `output/` – IG:t på `index.html`, felen i `qa.html`.

### Köra IG Publisher

**Rekommenderat (med terminologivalidering, kräver internet):**
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
c
```

**Lokal iteration (snabbare, utan terminologivalidering):**
```powershell
java -jar input-cache\publisher.jar -ig . -tx n/a
```

> Alternativt: kör `.\_genonce.bat` direkt – det skriptet väljer automatiskt rätt läge baserat på om du är online eller offline. Bygget tar ca 10–12 minuter.

### Titta på resultatet
```
output\index.html      ← själva IG:t
output\qa.html         ← fullständig QA-rapport (fel, varningar, trasiga länkar)
output\qa.min.html     ← bara felen (renare vy)
```
Längst upp i `qa.html` visas sammanfattningen: `errors = X, warn = X, broken links = X`.

### Om `-tx n/a` – när och varför

Flaggan gör att Publisher *hoppar över* terminologivalidering mot `tx.fhir.org`.

| Situation | Rekommendation |
|---|---|
| Snabb lokal iteration / felsökning | `-tx n/a` är OK |
| `tx.fhir.org` tajmar ut (se nedan) | `-tx n/a` som nödlösning |
| Lokal build med full validering | Utan flaggan |
| CI/CD-pipeline / driftsättning | **Aldrig `-tx n/a`** |

**Varför fick vi timeout-fel i juni 2026?**  
`.\\_genonce.bat` detekterade att vi var online och körde Publisher utan `-tx n/a`. Publisher försökte då ansluta till `tx.fhir.org` men fick inget svar och kraschade helt:
```
Error fetching the server's capability statement: Read timed out
Publishing Content Failed: Kan inte ansluta till terminologiserver vid http://tx.fhir.org
```
`-tx n/a` var en nödlösning för att överhuvudtaget få ett bygge och QA-rapport. Möjliga orsaker: tillfälligt problem hos `tx.fhir.org`, eller nätverksbegränsningar (proxy/brandvägg) i Region Stockholms miljö.

**Om `tx.fhir.org` fortsätter att tajma ut** – kör en lokal terminologiserver:
```bash
docker run -p 8080:8080 hl7fhir/fhir-terminology-server
java -jar input-cache\publisher.jar -ig . -tx http://localhost:8080/fhir
```

**Varning: "Unable to start a terminology cache ... caching disabled"**  
Om du ser detta meddelande i loggen:
```
Unable to start a terminology cache on https://tx.fhir.org/r4 via $cache-control
(Error: $cache-control requires a 'mode' of 'start' or 'end' (got 'START_CACHE'))
caching disabled for this server
```
Det är **inte ett blockerande fel** – bygget slutförs ändå och terminologivalidering körs. Det betyder att `publisher.jar` är inaktuell och skickar fel API-parameter till `tx.fhir.org`. Konsekvens: terminologicache inaktiveras, bygget blir lite långsammare.  
**Fix:** Uppdatera Publisher till senaste versionen:
```powershell
.\_updatePublisher.bat
```

---

## Samarbete och kunskapsdelning
- Dokumentation, arbetsflöden och lärdomar sparas i denna README eller i `docs/`.
- Fellistor och to-do sparas i `GDRFirstRelease/docs/TODO.md`.
- Regelbundna kodgranskningar för att sprida kunskap i teamet.

> Denna README kan kopieras till Confluence för vidare kunskapsdelning.


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

### Förutsättningar – program som måste vara installerade

| Program | Varför det behövs |
|---|---|
| **Java JDK 17+** | IG Publisher (`publisher.jar`) är en Java-applikation och kräver JRE/JDK för att köras. Vi använder Eclipse Adoptium (Temurin). |
| **Ruby** | Jekyll (se nedan) är skrivet i Ruby och kräver Ruby-miljön. |
| **Jekyll** | IG Publisher delegerar HTML-generering till Jekyll som processar Liquid-templates och bygger de statiska HTML-sidorna i `output/`. |
| **Node.js + npm** | Krävs för att köra SUSHI, som kompilerar FSH-filer till FHIR JSON-resurser innan IG Publisher körs. |
| **SUSHI** | Körs automatiskt av IG Publisher som ett försteg. Kompilerar `.fsh`-filer i `input/fsh/` till JSON-resurser. Installeras globalt via npm: `npm install -g fsh-sushi` |

#### Installationsordning (Windows)
1. Installera [Eclipse Adoptium JDK](https://adoptium.net/) (version 17 eller högre).
2. Installera [Ruby+Devkit](https://rubyinstaller.org/downloads/) via RubyInstaller för Windows.
3. Installera Jekyll via Ruby gems: `gem install jekyll bundler`
4. Installera [Node.js](https://nodejs.org/) (version 18 eller högre).
5. Installera SUSHI: `npm install -g fsh-sushi`
6. Ladda ner `publisher.jar` med hjälp av skriptet `_updatePublisher.bat` i `GDRFirstRelease/`.

### Vad som händer i kedjan
1. SUSHI läser FSH-filerna och genererar FHIR-resurser i `output/`.
2. IG Publisher läser `output/`, bygger HTML och validerar resurserna.
3. QA-rapporten skrivs till `output/qa.html` och huvudsidan till `output/index.html`.

### Så kör du IG Publisher lokalt

**Med terminologivalidering (rekommenderat, kräver internet):**
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
java -jar input-cache\publisher.jar -ig .
```

**Utan terminologivalidering (snabbare, för lokal iteration):**
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
java -jar input-cache\publisher.jar -ig . -tx n/a
```

Alternativt kan du köra `.\_genonce.bat` direkt – det skriptet sätter automatiskt `-tx n/a` om du är offline, men kör utan flaggan om du är online.

### Viktigt: när ska du använda `-tx n/a`?

| Situation | Rekommendation | Kommentar |
|---|---|---|
| Snabb lokal iteration, felsökning | `-tx n/a` OK | Terminologivalidering hoppas över – koder valideras ej mot ValueSets |
| tx.fhir.org tajmar ut / krasch | `-tx n/a` som nödlösning | Gör att du åtminstone får ett bygge – men kör utan flaggan när det fungerar |
| Lokal build med full validering | Utan flaggan | Kräver internetaccess mot `tx.fhir.org` |
| CI/CD-pipeline, driftsättning | **Utan flaggan** | **Ska aldrig köras med `-tx n/a`** |

**Varför är `-tx n/a` ett problem för driftsättning?**  
Terminologiservern validerar att koder faktiskt finns i de ValueSets de refererar till. Utan den kan fel koder smita igenom – t.ex. `modelname`-felet vi såg hittades *trots* att vi körde med `-tx n/a`, men hade kunnat ge ett tydligare fel om terminologiservern bekräftat att koden saknas.

**Om `tx.fhir.org` fortsätter att tajma ut:**  
Kör en lokal terminologiserver via Docker:
```bash
docker run -p 8080:8080 hl7fhir/fhir-terminology-server
java -jar input-cache\publisher.jar -ig . -tx http://localhost:8080/fhir
```

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

## Hur du kör IG Publisher och tittar på resultatet

### 1. Kör bygget
Öppna en terminal i VS Code och kör:
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
java -jar input-cache\publisher.jar -ig . -tx n/a
```
> `-tx n/a` = körs offline, utan att kontakta terminologiservern (tx.fhir.org). Tar ca 10–12 minuter.

### 2. Titta på resultatet (IG:t)
När bygget är klart, öppna i webbläsaren:
```
GDRFirstRelease\output\index.html
```
Eller i VS Code: högerklicka på filen → *Open with Live Server* eller *Reveal in File Explorer* och dubbelklicka.

### 3. Se felen (QA-rapport)
Öppna felfilen i webbläsaren:
```
GDRFirstRelease\output\qa.html       ← fullständig rapport med alla fel, varningar och trasiga länkar
GDRFirstRelease\output\qa.min.html   ← bara felen (renare vy)
```
Längst upp i rapporten visas en sammanfattning: `errors = X, warn = X, broken links = X`.
