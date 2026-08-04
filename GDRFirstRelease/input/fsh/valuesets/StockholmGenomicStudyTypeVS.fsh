Alias: $SCT = http://snomed.info/sct
ValueSet: StockholmGenomicStudyTypeVS
Id: Stockholm-genomic-study-type-vs
Title: "Stockholm Genomic Study Type ValueSet"
Description: "Value set for genomic study types used in the Stockholm GDR implementation guide. Initial SNOMED CT bindings are included for common sequencing and genomics-analysis concepts and should be validated against the local SNOMED edition before production use."

* include codes from system StockholmGenomicStudyTypeCS
* include codes from system $SCT where concept = #461571000124105
* include codes from system $SCT where concept = #62751000146102
* include codes from system $SCT where concept = #1460761000168104

* ^status = #draft
* ^version = "1.0.0"
* ^experimental = false
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health"
* ^publisher = "Karolinska University Hospital"

