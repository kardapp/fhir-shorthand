Alias: $SCT = http://snomed.info/sct
ValueSet: StockholmGenomicStudyTypeVS
Id: Stockholm-genomic-study-type-vs
Title: "Stockholm Genomic Study Type ValueSet"
Description: "Placeholder ValueSet för olika typer av genomiska analyser. Ska på sikt ersättas med SnomedCT-koder."

* ^url = "https://pub.regionstockholm.se/fhir/ValueSet/StockholmGenomicStudyTypeVS"
* include codes from system StockholmGenomicStudyTypeCS
* ^status = #draft
* ^version = "1.0.0"
* ^experimental = true
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health"
* ^publisher = "Karolinska University Hospital"
// * include codes from system "http://snomed.info/sct" where concept is one of:
// * $SCT#12345-1 "Whole Genome Sequencing (procedure)"
// * $SCT#12345-2 "Whole Exome Sequencing (procedure)"
// * $SCT#12345-3 "Panel Sequencing (procedure)"
// * $SCT#12345-4 "Whole Transcriptome Sequencing (procedure)"
// * $SCT#12345-5 "Clinical Micro Array (procedure)"
// * $SCT#12345-6 "Methylation array (procedure)"
// * $SCT#12345-7 "Optical Genome Mapping (procedure)"
// OBS! Byt ut ovanstående till riktiga SNOMED CT-koder när de finns tillgängliga.

