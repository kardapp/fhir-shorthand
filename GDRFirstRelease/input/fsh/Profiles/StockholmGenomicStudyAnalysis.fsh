Profile: StockholmGenomicStudyAnalysis
Parent: GenomicStudyAnalysis
Id: stockholm-genomic-study-analysis
Title: "Stockholm Genomic Study Analysis"
Description: "Part of the GenomicStudy and used to represent the data analysis performed in the study. A Genomic Study containes of a genomic study analysis. This profile has bbeen created to store the resource data about the data analysis aswell as pointing to all the important files used and created in this procedure."
* ^status = #draft
* ^version = "1.0.0-alpha.1"
* extension[regions] MS 
* extension[regions].extension[studied].valueReference only Reference(StockholmGenomicDataFile)
* extension[device] MS
* extension[device].extension[device].value[x] only Reference(StockholmGenomicDevice) 
* extension[input] MS
* extension[input].extension[type].value[x] from ValueSet(StockholmGenomicStudyDataFormatVS) 
* extension[output] MS
* extension[output].extension[type].value[x] from ValueSet(StockholmGenomicStudyDataFormatVS)
* extension contains $StockholmGenomicAnalysisPedigreeExtension named pedigree 0..* MS
  * ^comment = "Can be used to link to a pedigree document used as input for the analysis. The pedigree document should be represented as a GenomicDataFile resource. Can also be linked from the input element if preferred."
* instantiatesCanonical ..0
* instantiatesUri ..0
* partOf only Reference(Procedure or StockholmGenomicStudy)
* status MS
* status from ValueSet(StockholmGenomicProcedureStatusVS) (required) 
  * ^comment = "The following statuses can be used: in-progress, completed."
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #118117001 (exactly)
  * display 1..
  * display = "Gene mutation analysis (procedure)" (exactly)
* code.coding ..0
* subject MS
* subject only Reference(Patient) 
  * ^requirements = "A Genomic Study must be linked to a Patient resource. It must point to the same patient as the one linked from the Genomic Study procedure resource."
  * ^comment = "Should be used to point to the proband patient. Should be used to point to the patient resource in Stockholm demographic server if possible."
* performed MS 
  * ^requirements = "It must be possible to record and read when the procedure was performed. This can be done with either a dateTime or a Period depending on the use case and the level of detail available."
* performer
  * actor MS
    * ^requirements = "The Genomic Study procedure must be linked to the organization that performed the analysis, typically a laboratory. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the genomic analysis." 
    * type = "Organization" (exactly)
    * identifier
    * ^comment = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
    * display ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * ^requirements = "The Genomic Study procedure should be linked to the organization that requested the analysis, typically another diagnostic unit. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
    * ^comment = "onBehalfOf should be used to point to the requester of the genomic analysis, as long as no structured referral is available. If there is a reference to a serviceRequest, then the requester should be described in the serviceRequest instead."
    * type = "Organization" (exactly)
    * identifier
      * ^comment = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. A system URL representing the requester should be used"
    * display ^comment = "Can be used if a display name of the requester organisation is available"