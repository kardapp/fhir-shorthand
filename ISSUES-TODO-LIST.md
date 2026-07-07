# Stockholm Genomic Data Repository IG - Åtgärdslista

**Byggtatus:** ✅ 16 errors → 1 error (94% minskning)  
**Aktuella problem:** 1 kritiskt error + 52 varningar + 64 info-meddelanden

---

## 🔴 KRITISKA PROBLEM (FÖR FHIR-SERVRAR)

### 1. **Duplicate Anchor IDs i Procedure profil** 
- **Status:** ERROR
- **Filtyp:** HTML-dokumentation (påverkar ej FHIR-servrar)
- **Problem:** `StructureDefinition-stockholm-genomic-study-analysis-procedure` genererar 1606 identiska ankare
- **Effekt:** 2 interna dokumentationslänkar kan inte lösas
- **Allvarlighetsgrad:** LÅG - endast dokumentation, inte FHIR-validering
- **Åtgärd:** Kan accepteras för MVP. Åtgärdas genom att förenkla profilen eller skapa manuell HTML.

---

## ⚠️ VARNINGAR ATT ÅTGÄRDA (52 stycken)

### **GRUPP 1: CodeSystem - Saknade obligatoriska metadata**  
**Filtyp:** FSH  
**Profil-krav:** ShareableCodeSystem  

| File | Saknas | Åtgärd |
|------|--------|--------|
| StockholmGenomicDeviceTypeCS.fsh | `experimental`, `caseSensitive` | Lägg till: `* ^experimental = false` och `* ^caseSensitive = false` |
| StockholmGenomicStudyDataFormatCS.fsh | `experimental`, `caseSensitive` | Samma som ovan |
| StockholmGenomicStudyTypeCS.fsh | `title`, `experimental`, `description`, `caseSensitive` | Lägg till alla fyra metadata-fält |

**Varför:** FHIR-standard kräver denna metadata för publicerade kodsystem  
**Prioritet:** HÖG

---

### **GRUPP 2: ValueSet - Saknade metadata**  
**Filtyp:** FSH  
**Profil-krav:** ShareableValueSet  

| File | Saknas | Åtgärd |
|------|--------|--------|
| StockholmGenomicDeviceStatusVS.fsh | `experimental` | `* ^experimental = false` |
| StockholmGenomicDeviceTypeVS.fsh | `experimental` | `* ^experimental = false` |
| StockholmGenomicStudyDataFormatVS.fsh | `experimental` | `* ^experimental = false` |

**Prioritet:** HÖG

---

### **GRUPP 3: Saknade exempel för Profiles & Extensions (14 varningar)**  
**Åtgärd:** Skapa FSH Instance för var och en eller lägg till i IG-dokumentation  

**Profiler utan exempel:**
- stockholm-genomic-data-file
- stockholm-genomic-patient
- stockholm-genomic-procedure-laboratory-process
- stockholm-genomic-procedure-library-preparation
- stockholm-genomic-procedure-nucleic-acid-sequencing
- stockholm-genomic-specimen
- stockholm-genomic-study-analysis-procedure
- Stockholm-genomic-study-procedure

**Extensions utan exempel:**
- stockholm-genomic-analysis-extension-pedigree
- stockholm-genomic-datafile-extension-specimen
- stockholm-genomic-library-preparation-extension-panel-name
- stockholm-genomic-nas-number-of-reads
- stockholm-genomic-nucleic-acid-sequencing-extension-result
- stockholm-genomic-procedure-extension-focus
- stockholm-genomic-procedure-extension-laboratory-process
- stockholm-genomic-procedure-extension-nucleic-acid-sequencing
- stockholm-genomic-specimen-extension-source
- stockholm-genomic-study-analysis-extension-analysis-pipeline
- StockholmGenomicExtensionSpecimen
- StockholmGenomicProcedureExtensionLibraryPreparation

**Prioritet:** MEDEL (bra för IG-dokumentation, inte kritiskt)

---

### **GRUPP 4: Externa URL:er utan definition (2 varningar)**  
**Filtyp:** Instanser  
**Problem:** Device-extensioner refererar till externa URL:er som inte kan valideras  

| Instans | URL | Åtgärd |
|---------|-----|--------|
| BioinformaticsPipelineDevice-Example | `https://myadlm.org/cln/articles/2020/march/...` | Ersätt med faktisk referens eller ta bort |
| NanoporeSequencingPlatform-Example | `https://nanoporetech.com/` | Ersätt med faktisk profil-referens |

**Prioritet:** LÅGA (test-instanser)

---

### **GRUPP 5: Specimen profil - ValueSet bindning version**  
**Filtyp:** StructureDefinition-stockholm-genomic-specimen.fsh  
**Problem:** 4 externa terminologi ValueSet-bindningar behöver version specificerad  

| Binding | Aktuell URL | Åtgärd |
|---------|-------------|--------|
| Specimen.type | `http://terminology.hl7.org/ValueSet/v2-0487` | Ändra till `http://terminology.hl7.org/ValueSet/v2-0487\|3.0.0` |
| Specimen.status | `http://terminology.hl7.org/ValueSet/v2-0916` | Ändra till `http://terminology.hl7.org/ValueSet/v2-0916\|3.0.0` |
| Specimen.collection.bodySite | `http://terminology.hl7.org/ValueSet/v2-0371` | Ändra till `http://terminology.hl7.org/ValueSet/v2-0371\|3.0.0` |
| Specimen.collection.method | `http://terminology.hl7.org/ValueSet/v2-0493` | Ändra till `http://terminology.hl7.org/ValueSet/v2-0493\|3.0.0` |

**Prioritet:** MEDEL

---

### **GRUPP 6: Specimen profil - Slice must-support inkonsistens**  
**Filtyp:** StructureDefinition-stockholm-genomic-specimen.fsh  
**Problem:** 2 identifier slices inte markerade som must-support  

**Åtgärd:** I FSH, lägg till för båda slices:
```
* identifier[requester-sample-identifier] ^mustSupport = true
* identifier[laboratory-sample-identifier] ^mustSupport = true
```

**Prioritet:** LÅGA

---

### **GRUPP 7: Extension context review**  
**Filtyp:** StockholmGenomicExtensionDeviceDocumentation.fsh  
**Problem:** Extensionen har kontext `Element` vilket betyder den kan användas var som helst  

**Åtgärd:** 
- **Granska** om detta är avsiktligt
- Om begränsat till vissa resurser, ändra `Context:` till specifika typer (t.ex. `Procedure`, `Specimen`)

**Prioritet:** LÅGA (om avsiktligt, kan ignoreras)

---

### **GRUPP 8: ImplementationGuide - Gammal dependency**  
**Filtyp:** sushi-config.yaml  
**Problem:** `hl7.fhir.us.core#3.1.0` från 2019, ny version 9.0.0 finns  

**Åtgärd:** 
```yaml
dependencies:
  hl7.fhir.us.core: 9.0.0  # uppdatera från 3.1.0
```

**Prioritet:** LÅGA (funktionellt okej nu, men teknikrisk i framtiden)

---

### **GRUPP 9: ValueSet binding experiment-status mismatch (2 varningar)**  
**Filtyp:** StructureDefinition-Stockholm-genomic-study-procedure.fsh  
**Problem:** Procedur-profilen binder till experimentell ValueSet men själva profilen är inte experimentell  

**Åtgärd:** 
- Antingen: Markera profilen som experimentell: `* ^status = #experimental`
- Eller: Markera ValueSet som draft/stable: `* ^experimental = false` i ValueSet-defn

**Prioritet:** LÅGA

---

## 📝 INFORMATIONS-MEDDELANDEN (64 stycken - kan ignoreras)

Dessa är bara valideringsinformation, inte problem:
- ✓ "Validera resurs mot profil" - bara bekräftelse
- ✓ "Could usefully have OID" - rekommendation, inte obligatoriskt
- ✓ "Reference to draft CodeSystem" - information om beroende
- ✓ "Deprecated extension" - info om äldre API

**Åtgärd:** Ingen - dessa är informatöra meddelanden

---

## 🗓️ REKOMMENDERAD PRIORITERING

### **Sprint 1 - MÅSTE GÖRAS**
- [ ] CodeSystem metadata (grupp 1): **3 CodeSystems** - ~30 min
- [ ] ValueSet metadata (grupp 2): **3 ValueSets** - ~15 min
- [ ] Specimen ValueSet binding versioner (grupp 5): **4 bindningar** - ~10 min

### **Sprint 2 - BÖR GÖRAS** 
- [ ] Specimen slice must-support (grupp 6): ~5 min
- [ ] Extension context review (grupp 7): ~10 min
- [ ] IG dependency uppdatering (grupp 8): ~5 min
- [ ] ValueSet experiment-status (grupp 9): ~5 min

### **Sprint 3 - NÅ GÖRAS**
- [ ] Saknade exempel (grupp 3): **12 instanser** - valfritt för MVP, ~2-3 timmar om alla görs
- [ ] Externa URL:er i testinstanser (grupp 4): ~5 min

### **ACCEPTERAR FÖR MVP**
- ⚠️ Duplicate anchor ID error - bara HTML-dokumentation, påverkar inte FHIR-servrar

---

## 📊 SAMMANFATTNING

| Kategori | Antal | Allvarlighet | Tid att åtgärda |
|----------|-------|-------------|-----------------|
| CodeSystem metadata | 3 | HÖG | 30 min |
| ValueSet metadata | 3 | HÖG | 15 min |
| ValueSet bindning version | 4 | MEDEL | 10 min |
| Saknade exempel | 12 | LÅGA | 2-3 h |
| Externa URL:er | 2 | LÅGA | 5 min |
| Specimen slices | 2 | LÅGA | 5 min |
| Extension context | 1 | LÅGA | 10 min |
| Dependency update | 1 | LÅGA | 5 min |
| Experiment-status | 2 | LÅGA | 5 min |
| **TOTALT** | **30** | - | **~3-4 h** |

---

## 🎯 NÄSTA STEG

1. **Omedelbar åtgärd (HÖG prioritet):** CodeSystem & ValueSet metadata - ca 1 timme total
2. **Samma dag:** Specimen/binding fixes - ca 20 min
3. **Nästa vecka:** Exempel (valfritt) & övriga småfix
4. **ACCEPTERA:** Duplicate anchor ID for MVP (bara HTML-issue, ingen FHIR-inverkan)

**Frågor?** Kontakta utvecklaren för kodexempel på varje åtgärd.
