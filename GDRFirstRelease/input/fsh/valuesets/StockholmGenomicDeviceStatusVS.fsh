ValueSet: StockholmGenomicDeviceStatusVS
Id: stockholm-genomic-device-status-vs
Title: "Stockholm Allowed Device Statuses"
* ^url = "https://pub.regionstockholm.se/fhir/ValueSet/StockholmGenomicDeviceStatusVS"
Description: "Restricts Device.status to active or inactive."
* include http://hl7.org/fhir/device-status#active
* include http://hl7.org/fhir/device-status#inactive
