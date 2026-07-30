Profile: StockholmGenomicPatient
Parent: Patient
Id: stockholm-genomic-patient
Title: "Stockholm Genomic Patient"
Description: "Minimal Patient profile for genomic studies. Exposes only the key elements required: identifier, gender, birthDate and deceased."
* ^status = #draft
* ^purpose = "Minimal patient profile for genomic studies"
* identifier MS
  * ^short = "Patient identifiers used in genomic workflows"
  * ^definition = "Identifiers required to safely link genomic case resources to the correct patient context."
* gender MS
  * ^short = "Administrative gender"
  * ^definition = "Administrative gender recorded for the patient according to FHIR core semantics."
* birthDate MS
  * ^short = "Date of birth"
  * ^definition = "Birth date used for patient identification and genomic interpretation context."
* deceased[x] MS
  * ^short = "Deceased indicator or date"
  * ^definition = "States whether the patient is deceased, optionally with date/time where available."