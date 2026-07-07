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
* extension[focus].valueReference = Reference(StockholmGenomicSpecimenExample)
