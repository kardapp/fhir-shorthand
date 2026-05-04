Extension: StockholmGenomicLaboratoryProcessExtensionGeneSequencing
Id: StockholmGenomicLaboratoryProcessExtensionGeneSequencing
Description: "Extension"
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only Reference(StockholmGenomicProcedureGeneSequencing)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"