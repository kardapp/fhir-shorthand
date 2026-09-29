Instance: StockholmGenomicBundleExample
InstanceOf: StockholmGenomicBundle
Usage: #example
Title: "Stockholm Genomic Submission Bundle example"
Description: "Example transaction bundle for submitting a genomic case to GDR."

* type = #transaction

* entry[stockholmGenomicPatient].fullUrl = "https://example.org/fhir/Patient/StockholmGenomicPatientExample"
* entry[stockholmGenomicPatient].resource = StockholmGenomicPatientExample
* entry[stockholmGenomicPatient].request.method = #POST
* entry[stockholmGenomicPatient].request.url = "Patient"

* entry[stockholmGenomicSpecimen].fullUrl = "https://example.org/fhir/Specimen/StockholmGenomicSpecimenExample"
* entry[stockholmGenomicSpecimen].resource = StockholmGenomicSpecimenExample
* entry[stockholmGenomicSpecimen].request.method = #POST
* entry[stockholmGenomicSpecimen].request.url = "Specimen"

* entry[stockholmGenomicStudyProcedure].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicStudyProcedureExample"
* entry[stockholmGenomicStudyProcedure].resource = StockholmGenomicStudyProcedureExample
* entry[stockholmGenomicStudyProcedure].request.method = #POST
* entry[stockholmGenomicStudyProcedure].request.url = "Procedure"

* entry[stockholmGenomicProcedureLaboratoryProcess].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureLaboratoryProcessExample"
* entry[stockholmGenomicProcedureLaboratoryProcess].resource = StockholmGenomicProcedureLaboratoryProcessExample
* entry[stockholmGenomicProcedureLaboratoryProcess].request.method = #POST
* entry[stockholmGenomicProcedureLaboratoryProcess].request.url = "Procedure"

* entry[stockholmGenomicProcedureLibraryPreparation].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureLibraryPreparationExample"
* entry[stockholmGenomicProcedureLibraryPreparation].resource = StockholmGenomicProcedureLibraryPreparationExample
* entry[stockholmGenomicProcedureLibraryPreparation].request.method = #POST
* entry[stockholmGenomicProcedureLibraryPreparation].request.url = "Procedure"

* entry[stockholmGenomicProcedureNucleicAcidSequencing].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicProcedureNucleicAcidSequencingExample"
* entry[stockholmGenomicProcedureNucleicAcidSequencing].resource = StockholmGenomicProcedureNucleicAcidSequencingExample
* entry[stockholmGenomicProcedureNucleicAcidSequencing].request.method = #POST
* entry[stockholmGenomicProcedureNucleicAcidSequencing].request.url = "Procedure"

* entry[stockholmGenomicStudyAnalysisProcedure].fullUrl = "https://example.org/fhir/Procedure/StockholmGenomicStudyAnalysisProcedureExample"
* entry[stockholmGenomicStudyAnalysisProcedure].resource = StockholmGenomicStudyAnalysisProcedureExample
* entry[stockholmGenomicStudyAnalysisProcedure].request.method = #POST
* entry[stockholmGenomicStudyAnalysisProcedure].request.url = "Procedure"

* entry[stockholmGenomicDataFile].fullUrl = "https://example.org/fhir/DocumentReference/StockholmGenomicDataFileExample"
* entry[stockholmGenomicDataFile].resource = StockholmGenomicDataFileExample
* entry[stockholmGenomicDataFile].request.method = #POST
* entry[stockholmGenomicDataFile].request.url = "DocumentReference"
