Instance: StockholmGenomicSpecimenExample
InstanceOf: StockholmGenomicSpecimen
Usage: #example
Title: "Stockholm Genomic Specimen example"
Description: "Example specimen used in a genomic study."

* identifier[0].system = "urn:oid:1.2.3.4.6"
* identifier[0].value = "SPEC-1001"
* identifier[0].type = $v2-0203#PLAC
* identifier[0].type.coding.display = "Placer Identifier" (exactly)
* subject = Reference(StockholmGenomicPatientExample)
