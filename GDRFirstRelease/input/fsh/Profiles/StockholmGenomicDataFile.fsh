Profile: StockholmGenomicDataFile
Parent: genomic-data-file
Id: stockholm-genomic-data-file
Title: "Stockholm Genomic Data File"
Description: "Profile to store metadata about and point to the files included in the genomic study, This resource is referneced both from the StockholmGeneSequencing resource aswell as the StockholmGenomicStudyAnalysis."
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* implicitRules ..0
* language ..0
* contained ..0
* extension contains StockholmSpecimenExtension named specimen 0..*
* extension[specimen] MS
* extension[specimen].extension[type].valueReference only Reference(StockholmGenomicSpecimen)
* masterIdentifier ..0
* identifier ..0
* status = #current (exactly)
  * ^definition = "The status of this document reference. Fixed value to 'current' in GDR MVP."
* subject only Reference(Patient) 
* securityLabel ..0
* content 
  * attachment
    * contentType MS
    * url 1..1 MS
    * title 1..1 MS
    * creation MS
* context.related only Reference(Procedure)
  * type = "Procedure" (exactly)