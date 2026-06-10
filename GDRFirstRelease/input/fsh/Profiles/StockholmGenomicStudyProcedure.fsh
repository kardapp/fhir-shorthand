
Alias: $StockholmGenomicProcedureLaboratoryProcessExtension = https://pub.regionstockholm.se/fhir/StructureDefinition/StockholmGenomicProcedureLaboratoryProcessExtension
Alias: $StockholmPatientGenomics = https://pub.regionstockholm.se/fhir/StructureDefinition/StockholmPatientGenomics
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Profile: StockholmGenomicStudyProcedure
Parent: GenomicStudy
Id: Stockholm-genomic-study-procedure
Title: "Stockholm Genomic Study"
Description: "The core resource of the Genomic study which holds the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "To store the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* extension contains StockholmGenomicProcedureLaboratoryProcessExtension named genomic-laboratory-process 0..*
* extension[genomic-laboratory-process] MS
// Slicing identifier på type.coding.code för att särskilja olika identifierare
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding.code"
* identifier ^slicing.rules = #closed
* identifier ^requirements = "Two identifiers are used to identify the case, one assigned by the requester and one assigned by the laboratory. The identifier can be used for both the requester and the laboratory as a search parameter"
* identifier contains
    requester-case-identifier 0..1 MS and
    laboratory-case-identifier 0..1 MS
* identifier[requester-case-identifier].type = $v2-0203#PLAC
* identifier[requester-case-identifier].type.coding.display = "Placer Identifier" (exactly)
* identifier[requester-case-identifier] ^definition = "Business identifiers assigned to this procedure by the requester"
* identifier[laboratory-case-identifier].type = $v2-0203#FILL
* identifier[laboratory-case-identifier].type.coding.display = "Filler Identifier" (exactly)
* identifier[laboratory-case-identifier] ^definition = "Business identifiers assigned to this procedure by the performer/laboratory"
* instantiatesCanonical ..0
  * ^requirements = "No identified need for GDR" 
* instantiatesUri ..0
  * ^requirements = "No identified need for GDR"
* basedOn ^comment = "Placeholder for future use. Can be used to point to a referral (serviceRequest instance), or to hold a logical reference (Referral ID) to link the case to the referral(s) and referral data."
  * ^requirements = "No current need identified for GDR. Placeholder for future use."
* status MS
* status from ValueSet(StockholmGenomicProcedureStatusVS) (required) 
  * ^comment = "The following statuses can be used: in-progress, completed."
* code MS
* code from ValueSet(StockholmGenomicStudyTypeVS) (required)
  * ^comment = "Should be used to represent the type of Genomic study performed. Koder bör tas från StockholmGenomicStudyTypeVS (placeholder)."
  * ^requirements = "Used to specify the type of analysis. WGS, Exome, Panel etc" 
  * ^definition = "The specific procedure that is performed. Use text if the exact nature of the procedure cannot be coded (e.g. \"Panel Sequencing\", Whole Genome Sequencing, Whole Exome Sequencing etc.)."
* subject MS
* subject only Reference(Patient)
  * ^requirements = "A Genomic Study must be linked to a Patient resource"
  * ^comment = "Should be used to point to the proband patient. Should be used to point to the patient resource in Stockholm demographic server if possible."
* encounter ..1
  * ^comment = "Could be used to connect the analysis to the encounter(vårdkontakt) in which the analysis was ordered. Stockholm PAS-ID/kontaktID and at which unit and at which time the encounter occurred."
* performed[x] MS 
  * ^requirements = "It must be possible to record and read when the procedure was performed. This can be done with either a dateTime or a Period depending on the use case and the level of detail available."
* performer
  * actor MS
    * ^requirements = "The Genomic Study procedure must be linked to the organization that performed the analysis, typically a laboratory. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the genomic analysis." 
    * type = "Organization" (exactly)
    * identifier
    * ^comment = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
    * display ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * ^requirements = "The Genomic Study procedure should be linked to the organization that requested the analysis, typically another diagnostic unit. This can be done with a reference to an Organization resource or with an identifier for the organization if a reference is not possible."
    * ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
    * ^comment = "onBehalfOf should be used to point to the requester of the genomic analysis, as long as no structured referral is available. If there is a reference to a serviceRequest, then the requester should be described in the serviceRequest instead."
    * type = "Organization" (exactly)
    * identifier
      * ^comment = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. A system URL representing the requester should be used"
    * display ^comment = "Can be used if a display name of the requester organisation is available"
