# TODO – Stockholm Genomic Data Repository IG

---

## 🔴 Högt prioritet

### Jobba med valideringsvarningar (från ISSUES-TODO-LIST.md)
- [ ] CodeSystem metadata: lägg till `experimental`, `caseSensitive`, `title`, `description` i 3 CodeSystems (~30 min) - Done
- [ ] ValueSet metadata: lägg till `experimental` i 3 ValueSets (~15 min) - Done
- [ ] Specimen ValueSet-bindningar: lås versioner (v2-0487, v2-0916, v2-0371, v2-0493 → `|3.0.0`) (~10 min) - Done
- Se [ISSUES-TODO-LIST.md](ISSUES-TODO-LIST.md) för fullständig lista done

**Så gör du:**
1. Öppna varje FSH-fil från ISSUES-TODO-LIST
2. Lägg till metadata enligt instruktionerna i listans tabell
3. Kör `./_genonce.bat` för att bygga och verifiera varningarna försvinner
4. Commit och push ändringar done

---

## 🟡 Profilering & modellering

### Skapa Instances (exempelresurser)
- [ ] Skapa FSH Instance för varje profil och extension som saknar exempel
- [ ] Se ISSUES-TODO-LIST.md "Grupp 3" för fullständig lista (12 profiler/extensions saknar exempel)
- Instances används för att validera profiler och visa användningsexempel i IG:n

**Så gör du:**
1. Skapa ny fil: `input/fsh/Instances/Example[ProfileName].fsh`
2. Startstativ:
   ```fsh
   Instance: Example[ProfileName]
   InstanceOf: [ProfileId]
   Title: "Example of [Profile Name]"
   Description: "Example instance showing typical usage."
   * [element1] = [value]
   ```
3. Fyll i relevant exempeldata
4. Kör `./_genonce.bat` – varningen "no examples" bör försvinna
5. Commit och push

### Undersök Bundle
- [ ] Ska vi profilera en Bundle-resurs för att skriva data till GDR?
- [ ] Om ja: skapa `StockholmGenomicBundle` Profile (Parent: Bundle)
- [ ] Vilken bundle-typ? `transaction`, `batch` eller `collection`?
- [ ] Ska vi skapa en Instance av bundeln som exempeldata?
- [ ] Dokumentera Bundle-scenariot i IG:n (index.md eller separat sida)

**Så gör du:**
1. **Undersök användfallet:** Hur skickas data till GDR? En resurs i taget eller flera resurser tillsammans?
2. **Om flera i taget:** Skapa ny fil `input/fsh/profiles/StockholmGenomicBundle.fsh`
3. Definiera:
   ```fsh
   Profile: StockholmGenomicBundle
   Parent: Bundle
   * type = #transaction
   * entry 1..* MS
   ```
4. Skapa exempel-Instance
5. Dokumentera i `index.md`
6. Testa med `./_genonce.bat`

### CapabilityStatement
- [ ] Undersök om CapabilityStatement skapas automatiskt av IG Publisher
  - *OBS: IG Publisher genererar INTE CapabilityStatement automatiskt – den måste skapas manuellt som en FSH Instance*
- [ ] Definiera vilka operationer GDR-servern stödjer (search, read, create, update)
- [ ] Skapa `Instance: GDRCapabilityStatement` av typen `CapabilityStatement`
- [ ] Ange vilka profiler som stöds per resurstyp

**Så gör du:**
1. Skapa ny fil: `input/fsh/Instances/GDRCapabilityStatement.fsh`
2. Definiera operationer per resurstyp (read, search, create, etc.)
3. Referera profiler med `supportedProfile`
4. Testa och commit

### Sökparametrar
- [x] Se över vilka sökanrop GDR ska stödja per resurstyp
- [x] Identifiera vilka FHIR-sökparametrar som är relevanta (t.ex. `Patient?identifier=`, `Specimen?subject=`)
- [x] Skapa eventuellt egna SearchParameter-resurser i FSH om standardparametrar inte räcker (ej nödvändigt i denna version)
- [x] Dokumentera sökparametrar i CapabilityStatement (hänger ihop med CapabilityStatement-uppgiften)

**Så gör du:**
1. **Gå igenom varje resurstyp och identifiera relevanta sökparametrar**
2. **Lägg till i CapabilityStatement-Instance** under varje resurstyp
3. **Skapa egna om nödvändigt** (skapar nya FSH SearchParameter-resurser)
4. Dokumentera i `index.md` under "Search Parameters"
5. Commit och push

### SNOMED CT-begrepp
- [ ] Undersök vilka SNOMED CT-koder som är relevanta för genomik
- [ ] Kontrollera om befintliga ValueSets bör inkludera SNOMED CT-bindningar
- [ ] Kolla om genomics-reporting IG redan definierar SNOMED-mappningar vi kan använda
- [ ] Jobba vidare med att identifiera och kartlägga relevanta SNOMED CT-begrepp för GDR-domänen
- [ ] Skapa eller uppdatera ValueSets med SNOMED CT-inkluderingar där det är lämpligt

**Så gör du:**
1. **Undersök aktuella ValueSets:** Öppna varje ValueSet-fil i `input/fsh/valuesets/`
2. **Kolla SNOMED CT-mappningar:** Besök https://browser.ihtsdotools.org/ för att söka relevanta koder
3. **Uppdatera ValueSet med SNOMED CT-inkluidering** där lämpligt
4. Dokumentera mappningen i ValueSet-kommentar
5. Testa med `./_genonce.bat`

---

## 🟡 Dokumentation & beskrivningar

### Mer beskrivningar i profiler
- [ ] Lägg till `Description` på profil-nivå för alla profiler som har kortfattad/saknad beskrivning
- [ ] Lägg till element-nivå `^short` och `^definition` på viktiga element
- [ ] Skapa beskrivning på IG-nivå (index.md) som beskriver GDR-arkitekturen i stort
  - Vad är GDR? Varför finns det? Hur hänger resurserna ihop?

**Så gör du:**
1. **Per profil-fil:**
   ```fsh
   Profile: StockholmGenomicSpecimen
   Description: "Profile to store comprehensive genomic specimen data..."
   * identifier ^short = "Specimen identifiers"
   * identifier ^definition = "Business identifiers assigned to specimen."
   ```
2. **I index.md:** Lägg till "About GDR"-avsnitt med vad GDR är och dess syfte
3. **Arkitekturdiagram:** (valfritt) visa hur resurserna hänger ihop
4. Commit och push

### Snyggare IG-webbsajt
- [ ] Fixa numreringslista som visas felaktigt på startsidan (index.md)
- [ ] Undersök hur bilder kan läggas till i IG (stöd för bilder i `input/images/`)
- [ ] Eventuellt: skapa ett arkitekturdiagram som visar hur resurserna hänger ihop

**Så gör du:**
1. **Numreringslista-problem:** Öppna `input/pagecontent/index.md`
   - Verifiera att listor är korrekt formaterade (tom rad före lista)
   - Testa lokalt: preview i VS Code markdown-viewer
2. **Bilder:** Skapa mapp `input/images/`, lägg till PNG/SVG-filer
   - Referera i markdown: `![GDR Architecture](./images/gdr-architecture.png)`
3. **Arkitekturdiagram:** Skapa med draw.io eller ASCII-art
   - Visa: Patient → Specimen → Procedure → GenomicReport
4. Bygga och verifiera med `./_genonce.bat`

---

## 🟢 Infrastruktur & publicering

### Publicera IG på pub.regionstockholm.se/fhir/gdr
- [ ] Undersök hosting-alternativ för IG-publicering
  - GitHub Pages (enklast – publicera `output/` via GitHub Actions)
  - Azure Static Web Apps
  - IIS/Apache på befintlig infrastruktur
- [ ] Konfigurera DNS/subdomän: `pub.regionstockholm.se/fhir/gdr`
- [ ] Sätt upp CI/CD: automatiskt bygge + publicering vid push till `main`
- [ ] Kontrollera att `canonical` i sushi-config.yaml matchar den publika URL:en

**Så gör du:**
1. **Diskutera med IT-avdelning:** Vilken hosting vill ni använda? GitHub Pages rekommenderas
2. **GitHub Pages:** Aktivera i repo-settings → Pages → Source: gh-pages
3. **GitHub Actions workflow:** Skapa `.github/workflows/publish.yml` som bygger och pushar `output/` till gh-pages
4. **DNS:** IT mäpper `pub.regionstockholm.se/fhir/gdr` → GitHub Pages URL
5. **Verifiera:** Besök URL:en och kontrollera att IG läses in

### Skapa release-paket (version 1.0)
- [ ] Bestäm versionsstrategi (semantic versioning: `1.0.0`)
- [ ] Uppdatera `version` i sushi-config.yaml: `1.0.0`
- [ ] Uppdatera `status` från `draft` till `active`
- [ ] Säkerställa att alla profiler har `^status = #active` och korrekt `^version`
- [ ] Skapa git-tag: `git tag v1.0.0`
- [ ] Publicera FHIR-paketet till FHIR Package Registry (packages.fhir.org)?
  - Kräver registrering och publiceringsprocess via HL7

**Så gör du:**
1. **Uppdatera sushi-config.yaml:**
   ```yaml
   version: 1.0.0
   status: active  # från draft
   ```
2. **Uppdatera alla profiler/extensions (search & replace i VS Code):**
   ```fsh
   * ^version = "1.0.0"
   * ^status = #active  # från #draft
   ```
3. **Testa:** `./_genonce.bat`
4. **Skapa git-tag:**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```
5. **GitHub Release:** Releases → "Create new release" → v1.0.0

---

## ⚪ Lägre prioritet / utredning

### Teknikskuld
- [ ] Uppgradera `hl7.fhir.us.core` från 3.1.0 (2019) till senaste version (se ISSUES-TODO-LIST.md Grupp 8)
- [ ] Uppgradera SUSHI från 3.19.0 till 3.20.0: `npm install -g fsh-sushi`
- [ ] Undersök `fhir.base.template` security notification (se byggets varning)

---

*Uppdaterad: 2026-07-03*
