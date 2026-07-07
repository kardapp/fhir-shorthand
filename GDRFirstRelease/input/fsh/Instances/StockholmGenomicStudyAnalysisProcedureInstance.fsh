Instance: StockholmGenomicStudyAnalysisProcedureExample
InstanceOf: StockholmGenomicStudyAnalysisProcedure
Usage: #example
Title: "Stockholm Genomic Study Analysis example"
Description: "Example study analysis procedure."

* status = #completed
* subject = Reference(StockholmGenomicPatientExample)
* extension[analysis-pipeline].valueReference = Reference(BioinformaticsPipelineDevice-Example)
