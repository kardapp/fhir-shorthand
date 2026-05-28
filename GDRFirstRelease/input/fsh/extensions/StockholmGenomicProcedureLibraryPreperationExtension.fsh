Extension: StockholmGenomicProcedureExtensionLibraryPreperation
Id: StockholmGenomicProcedureExtensionLibraryPreperation
Description: "Extension"
Context: Procedure
* ^status = #draft
* value[x] only Reference(StockholmGenomicProcedureLibraryPreperation)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"