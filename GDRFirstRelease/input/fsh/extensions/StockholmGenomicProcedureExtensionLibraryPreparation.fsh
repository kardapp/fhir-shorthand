Extension: StockholmGenomicProcedureExtensionLibraryPreparation
Id: StockholmGenomicProcedureExtensionLibraryPreparation
Title: "Stockholm Genomic Procedure Extension Library Preparation"
Description: "Extension that references the library preparation activity associated with a genomic procedure."
Context: Procedure
* ^status = #draft
* value[x] only Reference(StockholmGenomicProcedureLibraryPreparation)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"