Profile: StockholmGenomicDevice 
Parent: Device
Description: "A profile of the Device resource."
Id: stockholm-genomic-device
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this devvice profile is to store structured information about devices used to perform the Genomic Test"
* ^title = "Stockholm Device"

* identifier 0..* MS
* udiCarrier 0..* MS
* status 0..1
* status from StockholmGenomicDeviceStatusVS (required)
* manufacturer 0..1 MS
* serialNumber 0..1 MS
* deviceName 0..* MS
* type 0..1 MS
* type from StockholmGenomicDeviceTypeVS (required)
* version 0..* MS
* extension contains StockholmGenomicExtensionDeviceDocumentation named documentation 0..*
* extension[documentation] MS



