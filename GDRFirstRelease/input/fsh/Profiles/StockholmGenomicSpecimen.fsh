Profile: StockholmGenomicSpecimen
Parent: Specimen
Id: stockholm-genomic-specimen
Description: "Profile to store the data about the specimen used in the genomic study. It is also used to relate both procedures and result files to a certain specimen."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to represent the specimen used in the genomic study. It is used to relate patients, procedures and result files to a certain specimen."
* extension contains StockholmGenomicSpecimenExtensionSource named specimen-source 0..*
* extension[specimen-source] MS
  * ^definition = "Optional The specimen source - What type of specimen the sample is taken from. E.g tissue, blood etc"
* identifier 1..* MS
  * ^definition = "The identifier of the specimen. This is a required element and should always be populated when using this profile."
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding.code"
* identifier ^slicing.rules = #closed
* identifier ^requirements = "Two identifiers are used to identify the specimen, one assigned by the requester and one assigned by the laboratory. The identifier can be used for both the requester and the laboratory as a search parameter"
* identifier contains
    requester-sample-identifier 0..* and
    laboratory-sample-identifier 0..*
* identifier[requester-sample-identifier].type = $v2-0203#PLAC
* identifier[requester-sample-identifier].type.coding.display = "Placer Identifier" (exactly)
* identifier[requester-sample-identifier] ^definition = "Business identifiers assigned to this procedure by the requester"
* identifier[laboratory-sample-identifier].type = $v2-0203#FILL
* identifier[laboratory-sample-identifier].type.coding.display = "Filler Identifier" (exactly)
* identifier[laboratory-sample-identifier] ^definition = "Business identifiers assigned to this procedure by the performer/laboratory"
* subject 1.. MS
* subject only Reference(Patient)
