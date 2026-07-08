Instance: StockholmGenomicExtensionSpecimenExample
InstanceOf: StockholmGenomicExtensionSpecimen
Usage: #inline
Title: "Stockholm Genomic Extension Specimen example"
Description: "Example extension referencing a specimen resource."

* id = "stockholm-genomic-extension-specimen-example"
* url = Canonical(StockholmGenomicExtensionSpecimen)

* valueReference = Reference(StockholmGenomicSpecimenExample)
* valueReference.type = "Specimen"
* valueReference.display = "Stockholm Genomic Specimen example"
