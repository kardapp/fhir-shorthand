Instance: StockholmGenomicNucleicAcidSequencingExtensionResultExample
InstanceOf: StockholmGenomicNucleicAcidSequencingExtensionResult
Usage: #inline
Title: "Stockholm Genomic Procedure Nucleic Acid Sequencing Result extension example"
Description: "Example extension referencing a genomic data file result."

* id = "sg-nas-result-ext-example"
* url = Canonical(StockholmGenomicNucleicAcidSequencingExtensionResult)

* valueReference = Reference(StockholmGenomicDataFileExample)
* valueReference.type = "DocumentReference"
* valueReference.display = "Stockholm Genomic Data File example"
