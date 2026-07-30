Profile: StockholmGenomicSpecimen
Parent: Specimen
Id: stockholm-genomic-specimen
Title: "Stockholm Genomic Specimen"
Description: "Profile to store the data about the specimen used in the genomic study. It is also used to relate both procedures and result files to a certain specimen."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to represent the specimen used in the genomic study. It is used to relate patients, procedures and result files to a certain specimen."
* extension contains StockholmGenomicSpecimenExtensionSource named specimen-source 0..*
* extension[specimen-source] MS
  * ^short = "Clinical source of the specimen"
  * ^definition = "Optional The specimen source - What type of specimen the sample is taken from. E.g tissue, blood etc"
* identifier 1..* MS
  * ^short = "Requester and laboratory specimen identifiers"
  * ^definition = "The identifier of the specimen. This is a required element and should always be populated when using this profile."
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding.code"
* identifier ^slicing.rules = #closed
* identifier ^requirements = "Two identifiers are used to identify the specimen, one assigned by the requester and one assigned by the laboratory. The identifier can be used for both the requester and the laboratory as a search parameter"
* identifier contains
    requester-sample-identifier 0..* and
    laboratory-sample-identifier 0..*
* identifier[requester-sample-identifier].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203" (exactly)
* identifier[requester-sample-identifier].type.coding.code = #PLAC (exactly)
* identifier[requester-sample-identifier].type.coding.display = "Placer Identifier" (exactly)
* identifier[requester-sample-identifier] ^mustSupport = true
* identifier[requester-sample-identifier] ^definition = "Business identifiers assigned to this procedure by the requester"
* identifier[laboratory-sample-identifier].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203" (exactly)
* identifier[laboratory-sample-identifier].type.coding.code = #FILL (exactly)
* identifier[laboratory-sample-identifier].type.coding.display = "Filler Identifier" (exactly)
* identifier[laboratory-sample-identifier] ^mustSupport = true
* identifier[laboratory-sample-identifier] ^definition = "Business identifiers assigned to this procedure by the performer/laboratory"
* type from http://terminology.hl7.org/ValueSet/v2-0487|3.0.0
* type ^short = "Specimen material/type"
* type ^definition = "Specifies the specimen type using HL7 V2 specimen type coding."
* status from http://hl7.org/fhir/ValueSet/specimen-status|4.0.1
* collection.bodySite from http://terminology.hl7.org/ValueSet/v2-0371|3.0.0
* collection.method from http://terminology.hl7.org/ValueSet/v2-0493|3.0.0
* subject 1.. MS
* subject only Reference(Patient)
* subject ^short = "Patient from whom specimen was collected"
* subject ^definition = "Links specimen to the patient/proband used throughout the genomic case."
