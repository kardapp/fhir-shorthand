Instance: StockholmGenomicBundleExample
InstanceOf: StockholmGenomicBundle
Usage: #example
Title: "Stockholm Genomic Submission Bundle example"
Description: "Example transaction bundle for submitting a genomic case to GDR."

* type = #transaction

* entry[0].fullUrl = "https://example.org/fhir/Patient/StockholmGenomicPatientExample"
* entry[0].resource = StockholmGenomicPatientExample
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

* entry[1].fullUrl = "https://example.org/fhir/Specimen/StockholmGenomicSpecimenExample"
* entry[1].resource = StockholmGenomicSpecimenExample
* entry[1].request.method = #POST
* entry[1].request.url = "Specimen"

* entry[2].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicStudyProcedureExample"
* entry[2].resource = StockholmGenomicStudyProcedureExample
* entry[2].request.method = #POST
* entry[2].request.url = "Procedure"

* entry[3].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureLaboratoryProcessExample"
* entry[3].resource = StockholmGenomicProcedureLaboratoryProcessExample
* entry[3].request.method = #POST
* entry[3].request.url = "Procedure"

* entry[4].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureLibraryPreparationExample"
* entry[4].resource = StockholmGenomicProcedureLibraryPreparationExample
* entry[4].request.method = #POST
* entry[4].request.url = "Procedure"

* entry[5].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureNucleicAcidSequencingExample"
* entry[5].resource = StockholmGenomicProcedureNucleicAcidSequencingExample
* entry[5].request.method = #POST
* entry[5].request.url = "Procedure"

* entry[6].fullUrl = "https://example.org/fhir/DocumentReference/StockholmGenomicDataFileExample"
* entry[6].resource = StockholmGenomicDataFileExample
* entry[6].request.method = #POST
* entry[6].request.url = "DocumentReference"
