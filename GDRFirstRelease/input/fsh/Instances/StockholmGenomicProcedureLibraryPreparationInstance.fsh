Instance: StockholmGenomicProcedureLibraryPreparationExample
InstanceOf: StockholmGenomicProcedureLibraryPreparation
Usage: #example
Title: "Stockholm Genomic Library Preparation example"
Description: "Example library preparation procedure."

* status = #completed
* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #56245008
* code.coding[0].display = "Specimen preparation (procedure)"
* subject = Reference(StockholmGenomicPatientExample)
* usedReference = Reference(BioinformaticsPipelineDevice-Example)
* partOf = Reference(StockholmGenomicProcedureLaboratoryProcessExample)
* extension[panel-name].valueString = "Test panel"
* extension[focus].valueReference = Reference(StockholmGenomicSpecimenExample)
