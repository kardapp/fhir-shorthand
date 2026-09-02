Profile: StockholmGenomicRelatedPerson
Parent: RelatedPerson   
Id: stockholm-genomic-related-person
Title: "Stockholm Genomic Related Person"
Description: "The related person profile is used to represent the relationship between the proband and another biological relative. The profile is linked from Patient.link on the proband patient record, and the RelatedPerson resource itself points back to the patient and describes the relationship to the other person."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* patient MS
* patient only Reference(Patient)
* patient ^short = "Proband patient linked to the relative"
* patient ^definition = "The patient (proband) which the related person is related to. This is a required element and should always be populated when using this profile." 
* relationship 1..* MS
* relationship ^short = "Biological relationship to the proband"
* relationship ^comment = "Use biological relationship types only, since this profile is for genetics."
* relationship ^definition = "Describes the biological relationship between the related person and the proband in genomic context."
* relationship from http://hl7.org/fhir/ValueSet/relatedperson-relationshiptype (required)
