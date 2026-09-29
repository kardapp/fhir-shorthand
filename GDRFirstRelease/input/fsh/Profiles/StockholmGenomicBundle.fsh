Profile: StockholmGenomicBundle
Parent: Bundle
Id: stockholm-genomic-bundle
Title: "Stockholm Genomic Submission Bundle"
Description: "Transaction bundle used to submit a coherent genomic case to GDR in a single atomic request. Each entry represents one resource in the same genomic case, and internal references are established using temporary fullUrl values (for example urn:uuid:...) before the server assigns final resource IDs. The bundle is processed as a single atomic transaction, so all included resources are created or updated together according to the per-entry request.method and request.url."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "Support atomic submission of related genomic resources for one case, including patient, specimen, procedures, device references, related persons, and data file metadata."
* type = #transaction (exactly)
  * ^short = "Atomic genomic case submission bundle type"
  * ^definition = "The bundle type is fixed to transaction so all included resources for one genomic case are processed atomically."
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Entries are sliced by the profile of the contained resource."
* entry contains
    stockholmGenomicStudyProcedure 1..1 and
    stockholmGenomicPatient 1..1 and
    stockholmGenomicSpecimen 1..1 and
    stockholmGenomicProcedureLaboratoryProcess 1..* and
    stockholmGenomicProcedureLibraryPreparation 1..* and
    stockholmGenomicProcedureNucleicAcidSequencing 1..* and
    stockholmGenomicStudyAnalysisProcedure 1..1 and
    stockholmGenomicDataFile 0..* and
    stockholmGenomicDevice 0..* and
    stockholmGenomicRelatedPerson 0..*
* entry[stockholmGenomicStudyProcedure].resource only StockholmGenomicStudyProcedure
* entry[stockholmGenomicPatient].resource only StockholmGenomicPatient
* entry[stockholmGenomicSpecimen].resource only StockholmGenomicSpecimen
* entry[stockholmGenomicProcedureLaboratoryProcess].resource only StockholmGenomicProcedureLaboratoryProcess
* entry[stockholmGenomicProcedureLibraryPreparation].resource only StockholmGenomicProcedureLibraryPreparation
* entry[stockholmGenomicProcedureNucleicAcidSequencing].resource only StockholmGenomicProcedureNucleicAcidSequencing
* entry[stockholmGenomicStudyAnalysisProcedure].resource only StockholmGenomicStudyAnalysisProcedure
* entry[stockholmGenomicDataFile].resource only StockholmGenomicDataFile
* entry[stockholmGenomicDevice].resource only StockholmGenomicDevice
* entry[stockholmGenomicRelatedPerson].resource only StockholmGenomicRelatedPerson
* entry 1..* MS
  * ^short = "Entries that together describe one genomic case"
  * ^definition = "Each entry contributes one resource in the submitted genomic case and is required for coherent case ingestion in GDR."
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1 MS
* entry.request.url 1..1 MS
  * ^short = "Target relative URL for transaction processing"
  * ^definition = "Entry request URL identifies the endpoint path for create/update processing of that resource in the transaction bundle."
