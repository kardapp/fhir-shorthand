Profile: StockholmGenomicProcedureLibraryPreparation
Parent: Procedure
Id: stockholm-genomic-procedure-library-preparation
Title: "Stockholm Genomic Library Preparation"
Description: "A profile on the procedure resource. It is used to represent the library preperation procedure. It is part of the Laboratory process of the genemoic study performed and containes detaild on what was performed on the sample/specimen during this procedure."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose is to represent the library preperation procedure, which is part of the laboratory process of the genomic study. It contains details on what was performed on the sample/specimen during this procedure."
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
* subject only Reference(Patient)
* subject MS
* performer
  * actor MS
    * ^requirements = "The procedure must be linked to the organization that performed the analysis, typically a laboratory. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the library preparation." 
    * type = "Organization" (exactly)
    * identifier
    * ^comment = "Identifier must be used when a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, e.g. urn:oid:1.2.752.29.4.71 should be used."
    * display ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * ^requirements = "The procedure should be linked to the organization that requested the analysis, typically another diagnostic unit. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer of the laboratory process is used."
    * ^comment = "onBehalfOf should be used to point to the requester of the library preparation, as long as no structured referral is available. If there is a reference to a serviceRequest, then the requester should be described in the serviceRequest instead."
    * type = "Organization" (exactly)
    * identifier
      * ^comment = "Identifier must be used when a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. A system URL representing the requester should be used"
    * display ^comment = "Can be used if a display name of the requester organisation is available"