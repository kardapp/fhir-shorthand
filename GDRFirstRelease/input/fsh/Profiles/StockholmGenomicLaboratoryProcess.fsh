Profile: StockholmGenomicLaboratoryProcess
Parent: Procedure
Id: StockholmGenomicLaboratoryProcess
Title: "Stockholm Genomic Laboratory Process"
Description: "Used to represent and hold together the laboratory process, including library preperation and the gene sequencing. Each GenomicStudy can include several laboratory processes, one for each sample connected to the genomic study.."
* ^url = "https://pub.regionstockholm.se/fhir/StructureDefinition/StockholmGenomicLaboratoryProcess"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* extension 3..*
* extension contains
    StockholmGenomicLibraryPreperationExtension named genomic-library-preperation 1..1 and
    StockholmGeneSequencingExtension named gene-sequencing 1..1 and
    StockholmFocusExtension named focus 1..1    
* instantiatesCanonical ..0
* instantiatesUri ..0
* partOf only Reference(StockholmGenomicStudy or Procedure)
* status = #completed (exactly)
  * ^comment = "The following statuses can be used to represent the status of the procedure: \r\npreparation | in-progress | not-done | on-hold | stopped | completed | entered-in-error | unknown"
* statusReason ..0
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #108252007 (exactly)
  * display 1..
  * display = "Laboratory procedure (procedure)" (exactly)
* code ..0
* subject only Reference(Patient)
* performer 
  * actor MS
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the genomic analysis." 
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * value 1..
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
    * display 1..
    * ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * type = "Organization" (exactly)
      * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
      * identifier
        * system 1..
        * value 1..
        * system 
        * ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. The system URL is currently local and invented."

    
