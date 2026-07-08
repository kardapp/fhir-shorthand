Instance: StockholmGenomicSpecimenExample
InstanceOf: StockholmGenomicSpecimen
Usage: #example
Title: "Stockholm Genomic Specimen example"
Description: "Example specimen used in a genomic study."

* identifier[requester-sample-identifier].system = "urn:oid:1.2.3.4.6"
* identifier[requester-sample-identifier].value = "SPEC-1001"
* identifier[requester-sample-identifier].type = $v2-0203#PLAC
* identifier[requester-sample-identifier].type.coding.display = "Placer Identifier" (exactly)
* subject = Reference(StockholmGenomicPatientExample)
