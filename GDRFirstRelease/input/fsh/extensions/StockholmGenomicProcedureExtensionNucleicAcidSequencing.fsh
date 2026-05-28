Extension: StockholmGenomicProcedureExtensionNucleicAcidSequencing
Id: stockholm-genomic-procedure-extension-nucleic-acid-sequencing
Description: "Extension"
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only Reference(StockholmGenomicProcedureNucleicAcidSequencing)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"