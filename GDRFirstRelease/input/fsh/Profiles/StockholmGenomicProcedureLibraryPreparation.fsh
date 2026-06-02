Profile: StockholmGenomicProcedureLibraryPreparation
Parent: Procedure
Id: StockholmGenomicProcedureLibraryPreparation
Title: "Stockholm Genomic Library Preparation"
Description: "A profile on the procedure resource. It is used to represent the library preperation procedure. It is part of the Laboratory process of the genemoic study performed and containes detaild on what was performed on the sample/specimen during this procedure."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* extension contains
    StockholmGenomicProcedureExtensionPanelName named panel-name 0..* and
    StockholmGenomicProcedureExtensionFocus named focus 0..*
* extension[panel-name] ^definition = "The name of the panel used during the library preperation"
  * ^isModifier = false
* extension[focus] ^definition = "focus is used to reference the specimen in focus of the procedure"
  * ^isModifier = false
* identifier ..0
* instantiatesCanonical ..0
* instantiatesUri ..0
* basedOn ..0
* partOf only Reference(Procedure or StockholmGenomicStudy)
* status = #completed (exactly)
* statusReason ..0
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #56245008 (exactly)
  * display 1..
  * display = "Specimen preparation (procedure)" (exactly)
* subject only Reference(StockholmPatientGenomics)
* encounter ..0
* recorder ..0
* asserter ..0
* performer ..1
  * actor only Reference(Organization)
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..
    * display = "GMCK" (exactly)
  * onBehalfOf.identifier
    * system 1..
    * system = "http://gmck.se/clarity-lims" (exactly)
    * value 1..
* location ..0
* reasonCode ..0
* reasonReference ..0
* bodySite ..0
* outcome ..0
* report ..0
* complication ..0
* complicationDetail ..0
* followUp ..0
* focalDevice ..0
* usedReference ..0
* usedCode ..0