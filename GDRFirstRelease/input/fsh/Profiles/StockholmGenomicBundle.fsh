Profile: StockholmGenomicBundle
Parent: Bundle
Id: stockholm-genomic-bundle
Title: "Stockholm Genomic Submission Bundle"
Description: "Transaction bundle used to submit a coherent genomic case to GDR in a single atomic request."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "Support atomic submission of related genomic resources for one case, including patient, specimen, procedures, and data file metadata."
* type = #transaction (exactly)
  * ^short = "Atomic genomic case submission bundle type"
  * ^definition = "The bundle type is fixed to transaction so all included resources for one genomic case are processed atomically."
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
