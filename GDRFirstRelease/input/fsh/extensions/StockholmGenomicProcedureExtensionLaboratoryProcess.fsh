Extension: StockholmGenomicProcedureExtensionLaboratoryProcess 
Id: stockholm-genomic-procedure-extension-laboratory-process
Description: "Extension"
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only Reference(StockholmLaboratoryProcess or Procedure)
* value[x] ^comment = "Should reference a Stockholm Laboratory Procedure if available, but any Procedure is allowed."
