Profile: StockholmGenomicDataFile
Parent: DocumentReference
Id: stockholm-genomic-data-file
Title: "Stockholm Genomic Data File"
Description: "Profile for metadata and links to genomic data files included in a case. This resource is referenced from sequencing and analysis workflows to connect produced or consumed files to the clinical context."
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* implicitRules ..0
* language ..0
* contained ..0
* extension contains StockholmGenomicExtensionSpecimen named specimen 0..*
* extension[specimen] MS
//* extension[specimen].extension[type].valueReference only Reference(StockholmGenomicSpecimen)
* masterIdentifier ..0
* identifier ..0
* status = #current (exactly)
  * ^definition = "The status of this document reference. Fixed value to 'current' in GDR MVP."
* subject only Reference(Patient) 
  * ^short = "Patient that the file content is about"
  * ^definition = "Subject links the data file metadata to the patient/proband context for the genomic case."
* securityLabel ..0
* content 
  * ^short = "File metadata and retrievable location"
  * ^definition = "Content describes the actual file using attachment metadata such as type, URL, title, and creation time."
  * attachment
    * contentType MS
    * url 1..1 MS
      * ^short = "Resolvable file location"
      * ^definition = "URL points to the file location where the referenced genomic data can be retrieved."
    * title 1..1 MS
    * creation MS
* context.related only Reference(Procedure)
  * type = "Procedure" (exactly)
* context.related ^short = "Related procedure context"
* context.related ^definition = "Links this file to one or more procedure resources that produced or used it."