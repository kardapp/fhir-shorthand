Profile: StockholmGenomicBundle
Parent: Bundle
Id: stockholm-genomic-bundle
Title: "Stockholm Genomic Submission Bundle"
Description: "Transaction bundle used to submit a coherent genomic case to GDR in a single atomic request."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "Support atomic submission of related genomic resources for one case, including patient, specimen, procedures, and data file metadata."
* type = #transaction (exactly)
* entry 1..* MS
* entry.fullUrl 1..1 MS
* entry.resource 1..1 MS
* entry.request 1..1 MS
* entry.request.method 1..1 MS
* entry.request.url 1..1 MS
