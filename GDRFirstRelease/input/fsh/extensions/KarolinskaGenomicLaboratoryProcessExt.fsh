Alias: $KarolinskaLaboratoryProcess = https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaLaboratoryProcess

Extension: KarolinskaGenomicLaboratoryProcessExt
Id: KarolinskaGenomicLaboratoryProcessExt
Description: "Extension"
Context: Procedure
* ^url = "https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension"
* ^status = #draft
* url = "https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension" (exactly)
* value[x] 1..
* value[x] only Reference($KarolinskaLaboratoryProcess)
  * ^definition = "Used to reference the genomic laboratory processes which is included in the Genomic case"