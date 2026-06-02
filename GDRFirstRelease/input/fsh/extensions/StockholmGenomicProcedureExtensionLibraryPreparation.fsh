Extension: StockholmGenomicProcedureExtensionLibraryPreparation
Id: StockholmGenomicProcedureExtensionLibraryPreparation
Description: "Extension"
Context: Procedure
* ^status = #draft
* value[x] only Reference(StockholmGenomicProcedureLibraryPreparation)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"