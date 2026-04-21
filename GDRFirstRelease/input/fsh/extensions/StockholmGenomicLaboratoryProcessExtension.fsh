Alias: $StockholmLaboratoryProcess = https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmLaboratoryProcess

Extension: StockholmGenomicLaboratoryProcessExtension 
Id: StockholmGenomicLaboratoryProcessExtension
Description: "Extension"
Context: Procedure
* ^url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicLaboratoryProcessExtension"
* ^status = #draft
* url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicLaboratoryProcessExtension" (exactly)
* value[x] 1..
* value[x] only Reference($StockholmLaboratoryProcess or Procedure)
* value[x] ^comment = "Should reference a Stockholm Laboratory Procedure if available, but any Procedure is allowed."
