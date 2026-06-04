Profile: StockholmGenomicProcedureNucleicAcidSequencing
Parent: Procedure
Id: stockholm-genomic-procedure-nucleic-acid-sequencing
Title: "Stockholm Nucleic Acid Sequencing"
Description: "A profile on the procedure resource. It is used to represent the Nucleic Acid Sequencing procedure. It is part of the Laboratory process of the genomic study performed and contains detailed information on what was performed, and which tools and platform were used during this procedure."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* extension contains
    StockholmGenomicProcedureExtensionNucleicAcidSequencingResult named nucleic-acid-sequencing-result 0..* and
    StockholmGenomicProcedureExtensionNucleicAcidSequencingNumberOfReads named nucleic-acid-sequencing-number-of-reads 0..1 and
    StockholmGenomicProcedureExtensionFocus named focus 0..*
* extension[nucleic-acid-sequencing-result] MS
  * value[x] only Reference(StockholmGenomicDocumentReference)
* extension[nucleic-acid-sequencing-number-of-reads] MS
  * ^definition = "Quality parameter. The number of reads of each sequence in the genome."
  * ^isModifier = false
* extension[focus] MS
  * ^definition = "focus is used to reference the specimen in focus of the procedure"
  * ^isModifier = false
* partOf only Reference(Procedure or StockholmGenomicStudyProcedure)
* status MS
* status from ValueSet(StockholmGenomicProcedureStatusVS) (required) 
  * ^comment = "The following statuses can be used: in-progress, completed."
* category 1..1
  * coding 1..1
    * system 1..1
    * system = "http://snomed.info/sct" (exactly)
    * code 1..1
    * code = #117040002 (exactly)
    * display 1..1
    * display = "Nucleic acid sequencing (procedure)" (exactly)
* subject only Reference(Patient) 
* subject MS
* performer 0..1 MS
  * actor only Reference(Organization)
    * display = "GMCK" (exactly)