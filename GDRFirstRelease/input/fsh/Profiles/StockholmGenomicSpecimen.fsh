Profile: StockholmGenomicSpecimen
Parent: Specimen
Id: stockholm-genomic-specimen
Description: "Profile to store the data about the specimen used in the genomic study. It is also used to relate both procedures and result files to a certain specimen."
// * ^url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicSpecimen"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* extension contains StockholmSpecimenSource named specimen-source 0..*
* extension[specimen-source] ^definition = "Optional The specimen source - What typw of specimen the sample is taken from. E.g tissue, blood etc"
  * ^isModifier = false
* identifier 1..
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "type.coding.code"
  * ^slicing.rules = #open
* identifier contains
    requester-sample-identifier 0..* and
    laboratory-sample-identifier 0..*
* identifier[requester-sample-identifier].type 1..
  * coding 1..1
    * code 1..
    * code = #requester-sample-identifier (exactly)
* identifier[laboratory-sample-identifier].type 1..
  * coding 1..1
    * code 1..
    * code = #laboratory-sample-identifier (exactly)
* accessionIdentifier ..0
* status ..0
* subject 1..
* subject only Reference(StockholmPatientGenomics)
  * ^short = "Where the specimen came from. This may be from patient(s), from a location (e.g., the source of an environmental sample), or a sampling of a substance or a device."
  * display ..0
* request ..0
* collection ..0
* processing ..0
  * procedure ..0
* container ..0
* condition ..0
* note ..0