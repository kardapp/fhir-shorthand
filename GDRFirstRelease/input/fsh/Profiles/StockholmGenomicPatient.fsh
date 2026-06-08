Alias: $PatientSEVendorLite = https://commonprofiles.care/fhir/StructureDefinition/PatientSEVendorLite

Profile: StockholmGenomicPatient
Parent: $PatientSEVendorLite
Id: stockholm-genomic-patient
Title: "Stockholm Genomic Patient"
Description: "The patient profile is created to represent the patient and hold the identifier of the patient. It is referenced from several other resources within the genomic study domain to create a relation between procedures performed, specimen, the result files to the patient it belongs or relates to."
* ^status = #draft
* ^purpose = "TBD"
* link only Reference(StockholmGenomicRelatedPerson) MS