Instance: StockholmGenomicProcedureExtensionFocusExample
InstanceOf: StockholmGenomicProcedureExtensionFocus
Usage: #inline
Title: "Stockholm Genomic Procedure Focus Extension example"
Description: "Example extension linking a procedure to a genomic specimen."

* id = "stockholm-genomic-procedure-extension-focus-example"
* url = Canonical(StockholmGenomicProcedureExtensionFocus)

* valueReference = Reference(StockholmGenomicSpecimenExample)
* valueReference.type = "Specimen"
* valueReference.display = "Stockholm Genomic Specimen example"
