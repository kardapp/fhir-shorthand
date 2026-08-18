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
java -jar input-cache\publisher.jar -ig .
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
`.\_genonce.bat` detekterade att vi var online och körde Publisher utan `-tx n/a`. Publisher försökte då ansluta till `tx.fhir.org` men fick inget svar och kraschade helt:
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
- Fellistor och to-do sparas i `arbetsdokument/TODO.md`.
- Regelbundna kodgranskningar för att sprida kunskap i teamet.

### Handbok för onboarding och presentation
- Samlad struktur för arbetssätt, FSH-grunder, verktyg och teamprocesser finns i `arbetsdokument/fsh-handbok/README.md`.

### Jira och FSH-arbetsflöde
- Se `GDRFirstRelease/docs/FSH-JIRA-WORKFLOW.md` för setup av Jira-synk mot GitHub och arbetssätt för branch/commit/PR kopplat till Jira.
- Guiden innehåller även ett praktiskt flöde för att lyfta uppgifter från `arbetsdokument/TODO.md` till Jira tickets och följa dem till merge.

> Denna README kan kopieras till Confluence för vidare kunskapsdelning.
