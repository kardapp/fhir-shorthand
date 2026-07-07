Instance: StockholmGenomicStudyProcedureExample
InstanceOf: StockholmGenomicStudyProcedure
Usage: #example
Title: "Stockholm Genomic Study example"
Description: "Example genomic study procedure."

* status = #completed
* code.coding[0].system = Canonical(StockholmGenomicStudyTypeCS)
* code.coding[0].code = #wgs
* code.coding[0].display = "Whole Genome Sequencing"
* subject = Reference(StockholmGenomicPatientExample)
* extension[genomic-laboratory-process].valueReference = Reference(StockholmGenomicProcedureLaboratoryProcessExample)
