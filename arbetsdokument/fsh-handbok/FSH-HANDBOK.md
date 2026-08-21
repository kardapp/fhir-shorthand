# FSH-handbok for informatiker

Denna handbok ar skriven for dig som kan FHIR-begreppen, men ar ny inom de mer tekniska verktygen.

Du behover inte kunna programmering for att komma igang. Tanken ar att du steg for steg ska forsta:
- vad FSH ar,
- hur vi bygger profiler,
- hur SUSHI och IG Publisher fungerar,
- hur vi arbetar i GitHub och Jira,
- och hur Copilot kan hjalpa utan att ersatta din domankompetens.

---

## 1. Snabb orientering

### Vad ar skillnaden mellan FHIR och FSH?
- FHIR ar standarden och informationsmodellen.
- FSH ar ett skrivsatt for att beskriva FHIR-artefakter i text.
- SUSHI oversatter FSH till FHIR JSON.

For dig som informatiker:
- Tanka FSH som ett mer lasbart satt att uttrycka samma regler som annars ligger i stora JSON-filer.
- Du beskriver krav och struktur, verktygen skoter omvandlingen.

### Vad betyder alla tekniska ord i praktiken?
- VS Code: arbetsverktyget dar vi skriver och granskar filer.
- GitHub: versionshantering och samarbete (historik, brancher, PR).
- SUSHI: kompilatorn som skapar FHIR-resurser fran FSH.
- IG Publisher: validerar och bygger den fardiga guiden (HTML + QA).
- Jira: planering och spårbarhet mellan krav och leverans.
- Copilot: AI-stod for utkast, forklaringar och dokumentation.

---

## 2. Vart finns saker i repot?

I detta repo ar de viktigaste mapparna:
- `GDRFirstRelease/input/fsh/` - har skriver vi FSH.
- `GDRFirstRelease/sushi-config.yaml` - styr IG metadata och beroenden.
- `GDRFirstRelease/fsh-generated/` - auto-genererade filer fran SUSHI.
- `GDRFirstRelease/output/` - fardig byggd Implementation Guide.
- `GDRFirstRelease/output/qa.html` - kvalitet och valideringsresultat.
- `simplifier-json/` - nedladdade JSON-profiler fran externa verktyg.
- `arbetsdokument/` - stoddokumentation och arbetssatt.

Viktig princip:
- Vi utvecklar i FSH-filer, inte i genererad output.

---

## 3. Vad ar FSH i vardagen?

### En enkel bild
I stallet for att redigera hundratals rader JSON, skriver du korta regler som:
- vilka falt som maste finnas,
- vilka kodsystem som tillats,
- vilka referenser som ar giltiga.

### Exempel pa tankesatt
Om verksamheten sager:
- "Rapporten maste alltid ha patient och minst ett resultat."

Da uttrycker vi det i FSH med kardinaliteter och regler.

### Vanliga artefakter
- Profil: anpassar en basresurs till ert anvandningsfall.
- Extension: lagger till information som saknas i basresursen.
- ValueSet/CodeSystem: terminologi och kodning.
- Instance: exempeldata for test, demo och dokumentation.

---

## 4. Skriva en profil utan programmeringsbakgrund

### Hur du borjar
1. Utga fran ett tydligt verksamhetskrav.
2. Valt basresurs (t.ex. Patient, Observation, DiagnosticReport).
3. Lista obligatoriska uppgifter.
4. Lista kodade uppgifter och deras terminologi.
5. Lista relationer (referenser till andra resurser).

### Praktisk checklista
- Vilka falt ar obligatoriska?
- Vilka falt kan upprepas?
- Vilka kodlistor ska anvandas?
- Finns information som kravs men saknas i basresursen (behover extension)?
- Behovs en exempelinstans for att visa tankt anvandning?

### Vanliga nyborjarmisstag
- For vaga regler (for manga 0..*).
- Terminologi anges inte trots kodade falt.
- Profilkrav blandas med lokala exempel i samma resonemang.

---

## 5. SUSHI: oversattning från FSH till FHIR JSON

### Vad SUSHI gor
SUSHI laser alla FSH-filer och skapar tekniskt korrekta FHIR-resurser.

### Nar du ska kora SUSHI
- Efter varje meningsfull andring i FSH.
- Innan du tar vidare andringen till full QA i Publisher.

### Hur du tanker pa fel
Om SUSHI klagar:
- Se det som tidig feedback pa otydlighet eller syntaxproblem.
- Los problem ett i taget.
- Jämfor med verksamhetskrav sa att du inte "fixar" bort ett viktigt krav.

---

## 6. IG Publisher: kvalitet, validering och publicering

### Vad Publisher tillfor
- Korer djupare validering.
- Bygger IG-webbsidor.
- Producerar QA-rapporter med fel och varningar.

### Viktigaste resultatfiler
- `output/index.html`: sjalva guiden.
- `output/qa.html`: full kvalitetsrapport.
- `output/qa.min.html`: koncentrerad felvy.

### Hur du laser QA som informatiker
Borja uppifran:
1. Fel (errors) - blockerande eller hog risk.
2. Varningar (warnings) - kvalitetsrisker.
3. Broken links - dokumentationskvalitet.

Fraga dig alltid:
- Ar detta ett tekniskt brus, eller en faktisk informationskvalitetsrisk?

---

## 7. Terminologi och tx-servern

### Varfor det ibland strular
Publisher validerar ofta mot extern terminologiserver (`tx.fhir.org`). Nätverk, proxy eller tillfalliga driftproblem kan ge timeout.

### Praktisk hantering
- For snabb lokal iteration kan man tillfalligt kora utan terminologivalidering.
- Inför viktig leverans bor full validering koras igen.

Princip:
- Snabb lokalkorning for tempo.
- Full validering for kvalitetssakrad leverans.

---

## 8. FHIR to FSH och GoFSH

### Nar anvands detta?
Nar ni far in befintliga JSON-profiler som ska in i ert FSH-arbetssatt.

### Två arbetssatt
- FHIR to FSH i VS Code: bra for enstaka filer.
- GoFSH: bra for batch-konvertering av många filer.

### Viktigt efter konvertering
Konverterad FSH ar ofta ett forsta utkast. Ni behover:
- rensa,
- forenkla,
- och anpassa till era lokala krav och namnstandarder.

---

## 9. GitHub utan programmeringsbakgrund

### Grundide
GitHub ar er gemensamma historik och samarbetsyta.

Tre saker ar centrala:
- Branch: en arbetsgren for en uppgift.
- Commit: en sparad delandring med meddelande.
- Pull Request (PR): forslag att sla samman andringen.

### Varfor detta hjalper informatik
- Alla andringar blir spårbara.
- Man kan granska resonemang och regler innan merge.
- Man kan koppla andringen till verksamhetskrav och Jira-ticket.

### Vad ar en bra PR-beskrivning?
En tydlig PR-beskrivning innehaller:
1. Varfor andringen goras.
2. Vad som andrats.
3. Hur det verifierats (SUSHI/QA).
4. Eventuell risk eller avgransning.
5. Koppling till Jira.

---

## 10. Jira-koppling

### Mal
Skapa spårbarhet fran behov till leverans.

### Enkelt flode
1. Starta i en Jira-ticket.
2. Jobba i branch som tydligt kopplas till ticket.
3. Skriv commit-meddelanden med ticket-nyckel.
4. Länka ticket i PR.

Resultat:
- I Jira syns branch, commits och PR i development-panelen.

---

## 11. Copilot for informatiker

### Vad Copilot ar bra pa
- Skapa forsta utkast av profiler/extensions.
- Forklara felmeddelanden i enkel svenska.
- Hjalpa skriva PR-beskrivningar och dokumentation.
- Omvandla verksamhetskrav till tekniska punktlistor.

### Vad Copilot inte ersatter
- Domankompetens och informatikbeslut.
- Terminologiska avvagningar.
- Slutlig kvalitetssakring.

### Satt att fa bra svar
- Ge tydlig kontext: resurs, mal, obligatoriska falt, terminologi.
- Be om smadelar i taget.
- Be om forklaring till varje regel.
- Verifiera alltid med SUSHI och Publisher.

---

## 12. Dagligt arbetssatt: steg for steg

### Normal arbetsdag i forenkling
1. Ta en Jira-ticket och tydliggor krav.
2. Uppdatera eller skapa FSH i `input/fsh/`.
3. Kor SUSHI och los direkta fel.
4. Kor Publisher och las QA.
5. Skapa PR med tydlig beskrivning.
6. Ta emot review och justera.
7. Merge nar kvalitet och krav ar uppfyllda.

---

## 13. Onboardingplan for ny informatiker

### Vecka 1
- Installera verktyg med stod.
- Forsta repo-struktur och byggkedja.
- Kora forsta build och lasa QA.

### Vecka 2
- Gora en liten andring i befintlig profil.
- Oppna forsta PR.
- Få review och ga igenom feedbacken pedagogiskt.

### Vecka 3 till 4
- Hantera en ticket end-to-end.
- Motivera modellval utifran verksamhetskrav.
- Visa resultat i teamdemo.

---

## 14. Forslag till presentationsupplagg (45 min)

1. Varfor FSH i var miljo.
2. Byggkedjan: FSH -> SUSHI -> Publisher.
3. Ett konkret exempel fran krav till profil.
4. QA och terminologikvalitet.
5. GitHub + Jira + Copilot i vardagen.
6. Fragor.

### Demo som brukar fungera bra
- Visa en liten FSH-andring.
- Visa hur den slar i QA.
- Visa hur andringen dokumenteras i PR.

---

## 15. Vanliga fragor

### Maste jag kunna koda for att bidra?
Nej. Du behover framfor allt kunna krav, informationsmodell och terminologi. Tekniken lar du stegvis.

### Vad ar viktigast att lara forst?
- Hur profilkrav uttrycks tydligt.
- Hur QA lases och prioriteras.
- Hur du dokumenterar andringar i PR.

### Nar vet vi att en andring ar klar?
- Kravet ar uppfyllt.
- Build och QA ar genomforda.
- PR ar granskad och godkand.
- Spårbarhet till Jira finns.

---

## 16. Snabb ordlista

- FSH: textsprak for FHIR-artefakter.
- SUSHI: kompilatorn som gor FSH till JSON.
- IG Publisher: validering och webbgenerering.
- Profile: lokal anpassning av basresurs.
- Extension: tillagg utanfor basmodellen.
- ValueSet: tillatna koder.
- PR: forslag till sammanslagning av andring i GitHub.

---

## 17. Nasta steg for teamet

For att halla handboken levande:
- Uppdatera den efter varje storre processforandring.
- Lagg in riktiga exempel fran era vanligaste profiler.
- Samla FAQ efter onboarding och reviews.

Detta dokument ar avsett att vara er gemensamma, praktiska standard for arbetssattet.
