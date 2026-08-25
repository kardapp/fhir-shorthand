Instance: StockholmGenomicProcedureNucleicAcidSequencingExample
InstanceOf: StockholmGenomicProcedureNucleicAcidSequencing
Usage: #example
Title: "Stockholm Nucleic Acid Sequencing example"
Description: "Example nucleic acid sequencing procedure."

* status = #completed
* category.coding[0].system = "http://snomed.info/sct"
* category.coding[0].code = #117040002
* category.coding[0].display = "Nucleic acid sequencing (procedure)"
* subject = Reference(StockholmGenomicPatientExample)
* usedReference = Reference(BioinformaticsPipelineDevice-Example)
* partOf = Reference(StockholmGenomicProcedureLaboratoryProcessExample)
* extension[nucleic-acid-sequencing-result].valueReference = Reference(StockholmGenomicDataFileExample)
* extension[nucleic-acid-sequencing-number-of-reads].valueInteger = 100000
* extension[nucleic-acid-sequencing-read-cycle].extension[cycle-count].valueInteger = 151
* extension[nucleic-acid-sequencing-read-cycle].extension[read-type].valueCodeableConcept.coding.system = "https://pub.regionstockholm.se/fhir/gdr/CodeSystem/stockholm-genomic-read-type-cs"
* extension[nucleic-acid-sequencing-read-cycle].extension[read-type].valueCodeableConcept.coding.code = #PE
* extension[nucleic-acid-sequencing-read-cycle].extension[read-type].valueCodeableConcept.coding.display = "Paired-end read"
* extension[nucleic-acid-sequencing-read-cycle].extension[read-type].valueCodeableConcept.text = "Paired-end read"
* extension[focus].valueReference = Reference(StockholmGenomicSpecimenExample)
