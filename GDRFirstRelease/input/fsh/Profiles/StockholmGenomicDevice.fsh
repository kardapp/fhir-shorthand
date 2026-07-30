Profile: StockholmGenomicDevice 
Parent: Device
Description: "Profile for devices and software systems used in genomic workflows, including sequencing platforms and bioinformatics pipelines referenced by procedures and analyses."
Id: stockholm-genomic-device
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this devvice profile is to store structured information about devices used to perform the Genomic Test"
* ^title = "Stockholm Device"

* identifier 0..* MS
  * ^short = "Business identifiers for the device or software"
  * ^definition = "Identifiers that uniquely identify a physical device or analytical system in the local ecosystem."
* udiCarrier 0..* MS
* status 0..1
  * ^short = "Operational device status"
  * ^definition = "Indicates whether the device is active, inactive, or entered in error at the time of use."
* status from StockholmGenomicDeviceStatusVS (required)
* manufacturer 0..1 MS
* serialNumber 0..1 MS
* deviceName 0..* MS
* type 0..1 MS
  * ^short = "Classified device type used in genomics"
  * ^definition = "Coded device type describing the platform, instrument, or software category used in the workflow."
* type from StockholmGenomicDeviceTypeVS (required)
* version 0..* MS
* extension contains StockholmGenomicExtensionDeviceDocumentation named documentation 0..*
* extension[documentation] MS
  * ^short = "Documentation links for the device"
  * ^definition = "Optional references or identifiers to supporting device documentation used for interpretation and traceability."



