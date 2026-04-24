
Extension: StockholmGenomicProcedureLaboratoryProcessExtension 
Id: StockholmGenomicProcedureLaboratoryProcessExtension
Description: "Extension"
Context: Procedure
* ^url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicProcedureLaboratoryProcessExtension"
* ^status = #draft
* url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicProcedureLaboratoryProcessExtension" (exactly)
* value[x] 1..
* value[x] only Reference($StockholmLaboratoryProcess or Procedure)
* value[x] ^comment = "Should reference a Stockholm Laboratory Procedure if available, but any Procedure is allowed."
