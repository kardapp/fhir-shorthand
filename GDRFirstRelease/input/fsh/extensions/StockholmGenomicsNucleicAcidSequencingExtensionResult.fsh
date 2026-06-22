Alias: $genomic-data-file = http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/genomic-data-file

Extension: StockholmGeneSequencingResult
Id: StockholmGeneSequencingResult
Title: "Stockholm Gene Sequencing Result"
Context: Procedure
* ^url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGeneSequencingResultOld"
* ^status = #draft
* url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGeneSequencingResultOld" (exactly)
* value[x] only Reference($genomic-data-file)