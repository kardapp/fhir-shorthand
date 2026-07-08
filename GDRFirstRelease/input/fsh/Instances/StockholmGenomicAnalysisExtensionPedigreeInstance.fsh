Instance: StockholmGenomicAnalysisExtensionPedigreeExample
InstanceOf: StockholmGenomicAnalysisExtensionPedigree
Usage: #example
Title: "Genomic Study Analysis Extension Pedigree example"
Description: "Example extension with pedigree input file and fixed pedigree format code."

* extension[file].valueReference = Reference(StockholmGenomicDataFileExample)
* extension[type].valueCodeableConcept.coding.system = "https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-study-data-format-cs"
* extension[type].valueCodeableConcept.coding.code = #PED
* extension[type].valueCodeableConcept.coding.display = "pedigree"
