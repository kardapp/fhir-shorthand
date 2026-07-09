Instance: StockholmGenomicSpecimenExample
InstanceOf: StockholmGenomicSpecimen
Usage: #example
Title: "Stockholm Genomic Specimen example"
Description: "Example specimen used in a genomic study."

* identifier[requester-sample-identifier].system = "urn:oid:1.2.3.4.6"
* identifier[requester-sample-identifier].value = "SPEC-1001"
* identifier[requester-sample-identifier].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[requester-sample-identifier].type.coding.code = #PLAC
* identifier[requester-sample-identifier].type.coding.display = "Placer Identifier" (exactly)
* identifier[laboratory-sample-identifier].system = "urn:oid:1.2.3.4.6"
* identifier[laboratory-sample-identifier].value = "LAB-2001"
* identifier[laboratory-sample-identifier].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[laboratory-sample-identifier].type.coding.code = #FILL
* identifier[laboratory-sample-identifier].type.coding.display = "Filler Identifier" (exactly)
* subject = Reference(StockholmGenomicPatientExample)
