Profile: StockholmGenomicLaboratoryProcess
Parent: Procedure
Id: stockholm-genomic-laboratory-process
Title: "Stockholm Genomic Laboratory Process"
Description: "Used to represent and hold together the laboratory process, including library preperation and the gene sequencing. Each GenomicStudy can include several laboratory processes, one for each sample connected to the genomic study.."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpse of this profile is to link and represent the laboratory phase of the genomic study together, which includes the library preparation and Nucleic Acid Sequencing."
* extension 3..*
* extension contains
    StockholmGenomicProcedureExtensionLibraryPreparation named genomic-library-preparation 1..1 and
    StockholmGenomicProcedureExtensionNucleicAcidSequencing named nucleic-acid-sequencing 1..1 and
    StockholmGenomicProcedureExtensionFocus named focus 1..1    
* extension[genomic-library-preparation] MS
* extension[nucleic-acid-sequencing] MS
* extension[focus] MS
* partOf only Reference(StockholmGenomicStudyProcedure or Procedure)
* status MS
* status from StockholmGenomicProcedureStatusVS (required) 
  * ^comment = "The following statuses can be used: in-progress, completed."
* instantiatesCanonical ..0 //This attribute is removed in future releases.
* instantiatesUri ..0 //This attribute is removed in future releases.
* partOf only Reference(StockholmGenomicStudyProcedure or Procedure)
* category.coding MS
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..1
  * code = #108252007 (exactly)
  * display 1..1
  * display = "Laboratory procedure (procedure)" (exactly)
* subject only Reference(Patient) MS
* performer 
  * actor MS
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the laborary process of the genomic analysis. It can be a different organisation than the one performing the genomic study analysis procedure." 
    * type = "Organization" (exactly)
    * identifier
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
  * onBehalfOf MS
    * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
    * type = "Organization" (exactly)
      * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
      * identifier
        * system 1..
        * value 1..
        * system 
        * ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. The system URL is currently local and invented."

    
