Extension: StockholmGenomicProcedureExtensionNucleicAcidSequencing
Id: stockholm-genomic-procedure-extension-nucleic-acid-sequencing
Title: "Stockholm Genomic Procedure Extension Nucleic Acid Sequencing"
Description: "Extension that references the nucleic acid sequencing activity associated with a genomic procedure."
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only Reference(StockholmGenomicProcedureNucleicAcidSequencing)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"