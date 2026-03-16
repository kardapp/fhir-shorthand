Instance: NanoporeSequencingPlatform-Example
InstanceOf: KarolinskaDevice
Usage: #example
Title: "Nanopore sequencing platform - example"
Description: "Example Device instance representing a nanopore-based gene sequencing platform used for genomic analysis in a clinical setting."

* status = http://hl7.org/fhir/device-status#active

* manufacturer = "Oxford Nanopore Technologies"
* serialNumber = "ONT-GRIDION-012345"

* deviceName[0].name = "GridION Mk1"
* deviceName[0].type = #model-name

* type.coding[0].system = Canonical(DeviceTypeCS)
* type.coding[0].code = #sequencing-platform
* type.coding[0].display = "Gene sequencing platform"

* version[0].value = "Instrument software v23.05.6"

* extension[deviceDocumentation].valueUri = "https://nanoporetech.com/"

