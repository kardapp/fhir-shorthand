Instance: BioinformaticsPipelineDevice-Example
InstanceOf: StockholmGenomicDevice
Usage: #example
Title: "Bioinformatic pipeline device - example"
Description: "Example Device instance representing a bioinformatic analysis pipeline used for genomic variant calling."

* status = http://hl7.org/fhir/device-status#active

* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[0].value = "urn:uuid:1b6b25f0-1a1f-4b66-9c3e-9df2a9c6d0a1"

* manufacturer = "Laboratory - Bioinformatics"
* serialNumber = "BIOINF-PIPELINE-0001"

* deviceName[0].name = "GDR Bioinformatic Variant Calling Pipeline"
* deviceName[0].type = #model-name

* type.coding[0].system = Canonical(StockholmGenomicDeviceTypeCS)
* type.coding[0].code = #bioinformatic-pipeline
* type.coding[0].display = "Bioinformatic pipeline"
* type.text = "Bioinformatic pipeline"

* version[0].value = "v2.3.1"
* extension[documentation].valueUri = "urn:placeholder:device-documentation:bioinformatics-pipeline"

