Alias: $KarolinskaGenomicLaboratoryProcessExtension = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension
Alias: $KarolinskaPatientGenomics = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaPatientGenomics

Profile: KarolinskaGenomicProcedureGenomicStudy
Parent: GenomicStudy
Id: karolinska-genomic-procedure-genomic-study
Title: "Karolinska Genomic Study"
Description: "The core resource of the Genomic study which holds the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* ^url = "https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicProcedureGenomicStudy"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "To store the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* extension contains KarolinskaGenomicLaboratoryProcessExt named genomic-laboratory-process 0..* MS
* extension[genomic-laboratory-process] ^isModifier = false
* identifier ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "type.coding.code"
  * ^slicing.rules = #closed
* identifier contains
    requester-case-identifier 0..1 and
    laboratory-case-identifier 0..1
  * value ^requirements = "Used for CaseID"
* identifier[requester-case-identifier] ^definition = "Business identifiers assigned to this procedure by the requester"
  * type 1..
    * coding 1..1
      * system 1..
      * system = "http://terminology.hl7.org/CodeSystem/v2-0203" (exactly)
      * code 1..
      * code = #PLAC (exactly)
        * ^definition = "An identifier for a request where the identifier is issued by the person or service making the request."
      * display 1..
      * display = "Placer Identifier" (exactly)
  * system 1..
  * system ^comment = "The system URI SHOULD be a globally unique and stable URI identifying the assigning authority (e.g. the LIS system or organization). If possible, use an official OID or a resolvable HTTPS URI. If unknown, use a local URI and document its meaning."
  * value 1..
* identifier[laboratory-case-identifier] ^definition = "Business identifiers assigned to this procedure by the performer/laboratory"
  * type 1..
    * coding 1..1
      * system 1..
      * system = "http://terminology.hl7.org/CodeSystem/v2-0203" (exactly)
      * code 1..
      * code = #FILL (exactly)
        * ^definition = "An identifier for a request where the identifier is issued by the person, or service, that produces the observations or fulfills the request."
      * display 1..
      * display = "Filler Identifier" (exactly)
  * system 1..
  * system ^comment = "The system URI SHOULD identify the assigning authority (e.g. the LIS or laboratory). Preferably use an official OID or a resolvable HTTPS URI. If not available, use a local URI and document its scope and meaning."
  * value 1..
* instantiatesCanonical ..0
  * ^requirements = "Removed for this MVP."
* instantiatesUri ..0
  * ^requirements = "Removed for this MVP"
* basedOn ^comment = "Placeholder for future use. Can be used to point to a referral (serviceRequest instance), or to hold a logical reference (Referral ID) to link the case to the referral(s) and referral data."
  * ^requirements = "Not used in MVP but is kept as a placeholder to show the possibility to connect this Genomic Study to a service request."
* status from KarolinskaGenomicStudyStatusVS (required) MS
  * ^comment = "The following statuses can be used: in-progress, completed."
* code from KarolinskaGenomicStudyTypeVS (preferred)
* code ^definition = "The specific procedure that is performed. Use text if the exact nature of the procedure cannot be coded (e.g. \"Panel Sequencing\", Whole Genome Sequencing, Whole Exome Sequencing etc.)."
  * ^comment = "Should be used to represent the type of Genomic study performed. Koder bör tas från KarolinskaGenomicStudyTypeVS (placeholder, byt till SnomedCT när möjligt). Om kod saknas kan text användas."
  * ^requirements = "Used to specify the type of analysis. WGS, Exome, Panel etc.\r\nShould use snomed CT när möjligt."
* subject only Reference($KarolinskaPatientGenomics) MS
  * ^comment = "Should be used to point to the Karolinska Patient resource. We do not want to create a seperate patient-resource."
* encounter ..1
  * ^comment = "Could be used to connect the analysis to the encounter in which the analysis was ordered. Karolinska PAS-ID and at which unit and at which time the encounter occurred."
* performed[x] ^requirements = "dateTime of when the case was started."
* asserter ..0
  * ^definition = "Individual who is making the procedure statement. https"
* performer
  * actor MS
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the genomic analysis." 
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * value 1..
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
    * display 1..
    * ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * value 1..
      * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. The system URL is currently local and invented."
    * display 1..
* reasonCode ..0
* reasonReference ..0
  * ^requirements = "Not used in MVP - But in future can be used to categorize the ptotential diagnosis as the reason to perform the service."