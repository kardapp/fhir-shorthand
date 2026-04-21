ValueSet: StockholmGenomicStudyTypeVS
Id: Stockholm-genomic-study-type-vs
Title: "Stockholm Genomic Study Type ValueSet"
Description: "Placeholder ValueSet för olika typer av genomiska analyser. Ska på sikt ersättas med SnomedCT-koder."
* ^url = "https://pub.regionstockholm.se/fhir/ValueSet/Stockholm-genomic-study-type-vs"
* ^status = #draft
* ^version = "1.0.0"
* ^experimental = true
* ^publisher = "Stockholm University Hospital"
* include codes from system "http://snomed.info/sct" where concept is one of:
    * WGS // Whole Genome Sequencing
    * WES // Whole Exome Sequencing
    * Panel // Panel Sequencing
    * WTS // Whole Transcriptome Sequencing
    * CMA // Clinical Micro Array
    * Methylation array
    * OGM // Optical Genome Mapping
// OBS! Byt ut ovanstående till riktiga SNOMED CT-koder när de finns tillgängliga.
