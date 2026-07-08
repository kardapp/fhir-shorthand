Instance: StockholmGenomicAnalysisExtensionPedigreeExample
InstanceOf: StockholmGenomicAnalysisExtensionPedigree
Usage: #inline
Title: "Genomic Study Analysis Extension Pedigree example"
Description: "Example extension with pedigree input file and fixed pedigree format code."

* id = "stockholm-genomic-analysis-extension-pedigree-example"
* url = Canonical(StockholmGenomicAnalysisExtensionPedigree)

* extension[file].valueReference = Reference(StockholmGenomicDataFileExample)
* extension[file].valueReference.type = "DocumentReference"
* extension[file].valueReference.display = "Stockholm Genomic Data File example"
* extension[type].valueCodeableConcept.coding.system = "https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-study-data-format-cs"
* extension[type].valueCodeableConcept.coding.code = #PED
* extension[type].valueCodeableConcept.coding.display = "pedigree"
* extension[type].valueCodeableConcept.text = "pedigree"
