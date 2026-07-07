Instance: StockholmGenomicRelatedPersonExample
InstanceOf: StockholmGenomicRelatedPerson
Usage: #example
Title: "Stockholm Genomic Related Person example"
Description: "Example related person for genomic study workflows."

* identifier[0].system = "urn:oid:1.2.3.4.7"
* identifier[0].value = "RP-1001"
* patient = Reference(StockholmGenomicPatientExample)
* relationship.coding[0].system = "http://terminology.hl7.org/CodeSystem/v3-RoleCode"
* relationship.coding[0].code = #MTH
* relationship.coding[0].display = "mother"
