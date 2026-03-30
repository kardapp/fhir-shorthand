// This is a simple example of a FSH file.
// This file can be renamed, and additional FSH files can be added.
// SUSHI will look for definitions in any file using the .fsh ending.
Profile: KarolinskaDevice 
Parent: Device
Description: "A profile of the Device resource."
Id: karolinska-device

// Title: "Karolinska Device"
//Description: "Device profile with strict element suppression except key fields."

// Close down all elements (0..0)
// * * 0..0   // applies to the whole structure
// Re-enable allowed elements with correct cardinality + rules

* identifier 0..* MS

* udiCarrier 0..* MS

* status 0..1
* status from DeviceStatusVS (required)

* manufacturer 0..1 MS

* serialNumber 0..1 MS

* deviceName 0..* MS

* type 0..1
* type from DeviceTypeVS (required)

* version 0..* MS

* extension contains DeviceDocumentation named deviceDocumentation 0..* MS



