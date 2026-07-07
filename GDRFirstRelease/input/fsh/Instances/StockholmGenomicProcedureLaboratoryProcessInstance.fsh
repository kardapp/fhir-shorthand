Instance: StockholmGenomicProcedureLaboratoryProcessExample
InstanceOf: StockholmGenomicProcedureLaboratoryProcess
Usage: #example
Title: "Stockholm Genomic Laboratory Process example"
Description: "Example laboratory process procedure."

* status = #completed
* code.coding[0].system = "http://snomed.info/sct"
* code.coding[0].code = #108252007
* code.coding[0].display = "Laboratory procedure (procedure)"
* subject = Reference(StockholmGenomicPatientExample)
* extension[genomic-library-preparation].valueReference = Reference(StockholmGenomicProcedureLibraryPreparationExample)
* extension[nucleic-acid-sequencing].valueReference = Reference(StockholmGenomicProcedureNucleicAcidSequencingExample)
* extension[focus].valueReference = Reference(StockholmGenomicSpecimenExample)
