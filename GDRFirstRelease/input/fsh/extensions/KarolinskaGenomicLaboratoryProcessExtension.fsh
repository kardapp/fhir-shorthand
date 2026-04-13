Alias: $KarolinskaLaboratoryProcess = https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaLaboratoryProcess

Extension: KarolinskaGenomicLaboratoryProcessExtension 
Id: KarolinskaGenomicLaboratoryProcessExtension
Description: "Extension"
Context: Procedure
* ^url = "https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension"
* ^status = #draft
* url = "https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension" (exactly)
* value[x] 1..
* value[x] only Reference($KarolinskaLaboratoryProcess or Procedure)
* value[x] ^comment = "Should reference a Karolinska Laboratory Procedure if available, but any Procedure is allowed."