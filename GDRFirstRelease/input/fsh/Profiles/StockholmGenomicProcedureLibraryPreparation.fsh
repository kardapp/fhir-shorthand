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
* extension[panel-name] MS
  * ^definition = "The name of the panel used during the library preperation"
* extension[focus] MS
  * ^definition = "focus is used to reference the specimen in focus of the procedure"
* partOf only Reference(Procedure or StockholmGenomicStudyProcedure) 
* status MS
* status from ValueSet(StockholmGenomicProcedureStatusVS) (required) 
  * ^comment = "The following statuses can be used: in-progress, completed."
* category.coding MS
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..1
  * code = #56245008 (exactly)
  * display 1..1
  * display = "Specimen preparation (procedure)" (exactly)
* subject only Reference($StockholmPatientGenomics)
* encounter ..0
* recorder ..0
* asserter ..0
* performer ..1
  * actor only Reference(Organization)
    * identifier
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
  * onBehalfOf MS
    * type = "Organization" (exactly)
      * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer laboratory procedure is used. If that is also empty, then the perfomer Genomic Study profile is used."
      * identifier
        * system 1..1
        * value 1..1
        * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. The system URL is currently local and invented."