Alias: $DeviceStatus = http://hl7.org/fhir/device-status

ValueSet: StockholmGenomicDeviceStatusVS
Id: stockholm-genomic-device-status-vs
Title: "Stockholm Allowed Device Statuses"
Description: "Restricts Device.status to active or inactive."

* include $DeviceStatus#active
* include $DeviceStatus#inactive