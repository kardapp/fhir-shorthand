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
* identifier.system 1..1
* identifier.value 1..1
* identifier.type MS
* gender MS
  * ^short = "Administrative gender"
  * ^definition = "Administrative gender recorded for the patient according to FHIR core semantics."
* birthDate MS
  * ^short = "Date of birth"
  * ^definition = "Birth date used for patient identification and genomic interpretation context."
* deceased[x] MS
  * ^short = "Deceased indicator or date"
  * ^definition = "States whether the patient is deceased, optionally with date/time where available."
* link MS
  * ^short = "Reference to a RelatedPerson describing another person/patient"
  * ^definition = "Used to link the patient to a RelatedPerson resource that describes the relationship to another person/patient. The RelatedPerson resource itself points back to the patient and defines the nature of the relationship."
* link.other only Reference(RelatedPerson)
  * ^short = "Related person resource for the other person/patient"
  * ^definition = "The RelatedPerson resource representing the other person/patient and the relationship to the proband patient."