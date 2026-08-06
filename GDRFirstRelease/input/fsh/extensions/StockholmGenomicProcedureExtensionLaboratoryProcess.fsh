Extension: StockholmGenomicProcedureExtensionLaboratoryProcess 
Id: stockholm-genomic-procedure-extension-laboratory-process
Title: "Stockholm Genomic Procedure Extension Laboratory Process"
Description: "Extension that references the laboratory process associated with a genomic procedure."
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only Reference(Procedure)
