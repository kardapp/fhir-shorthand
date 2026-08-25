Instance: StockholmGenomicNucleicAcidSequencingExtensionReadCycleExample
InstanceOf: StockholmGenomicNucleicAcidSequencingExtensionReadCycle
Usage: #inline
Title: "Stockholm Genomic NAS Read Cycle extension example"
Description: "Example extension specifying read cycle count and read type."

* id = "stockholm-genomic-nas-read-cycle-example"
* url = Canonical(StockholmGenomicNucleicAcidSequencingExtensionReadCycle)

* extension[cycle-count].valueInteger = 151
* extension[read-type].valueCodeableConcept.coding.system = "https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-read-type-cs"
* extension[read-type].valueCodeableConcept.coding.code = #PE
* extension[read-type].valueCodeableConcept.coding.display = "Paired-end read"
* extension[read-type].valueCodeableConcept.text = "Paired-end read"
