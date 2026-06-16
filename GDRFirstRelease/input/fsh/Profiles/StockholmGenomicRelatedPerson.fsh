Profile: StockholmGenomicRelatedPerson
Parent: RelatedPerson   
Id: stockholm-genomic-related-person
Title: "Stockholm Genomic Related Person"
Description: "The related person profile is used to represent the relationship between the proband and another biological relative. The profile is linked from subject.link of the patient resource data of the related person."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^requirements = "This profile is intended for biological family relationships only, because it is used in a genetic context. Use the related-person relationship type to represent biological relatives such as mother, father, sibling, etc."
* patient MS
* patient only Reference(Patient)
* patient ^definition = "The patient(proband) which the related person is related to. This is a required element and should always be populated when using this profile." 
* relationship 1..* MS
* relationship ^comment = "Use biological relationship types only, since this profile is for genetics."
* relationship from http://hl7.org/fhir/ValueSet/relatedperson-relationshiptype (required)
