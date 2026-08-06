Alias: $SCT = http://snomed.info/sct
ValueSet: StockholmGenomicStudyTypeVS
Id: Stockholm-genomic-study-type-vs
Title: "Stockholm Genomic Study Type ValueSet"
Description: "Value set for genomic study types used in the Stockholm GDR implementation guide. Initial SNOMED CT bindings are included for common sequencing and genomics-analysis concepts and should be validated against the local SNOMED edition before production use."

* include codes from system StockholmGenomicStudyTypeCS
* include codes from system $SCT where concept descendent-of #363679005
* include codes from system $SCT where concept descendent-of #394743007
* include codes from system $SCT where concept descendent-of #708168004

* ^status = #draft
* ^version = "1.0.0"
* ^experimental = false
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health"
* ^publisher = "Karolinska University Hospital"

