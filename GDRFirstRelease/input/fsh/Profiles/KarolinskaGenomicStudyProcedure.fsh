
Alias: $KarolinskaGenomicLaboratoryProcessExtension = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension
Alias: $KarolinskaPatientGenomics = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaPatientGenomics
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203

Profile: KarolinskaGenomicStudyProcedure
Parent: GenomicStudy
Id: karolinska-genomic-study-procedure
Title: "Karolinska Genomic Study"
Description: "The core resource of the Genomic study which holds the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* ^url = "https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicStudyProcedure"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "To store the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* extension contains $KarolinskaGenomicLaboratoryProcessExtension named genomic-laboratory-process 0..* MS
* extension[genomic-laboratory-process] ^isModifier = false
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
  * ^requirements = "Not used in MVP but is kept as a placeholder to show the possibility to connect this Genomic Study to a service request."
* status from KarolinskaGenomicProcedureStatusVS (required) MS
  * ^comment = "The following statuses can be used: in-progress, completed."
* code from KarolinskaGenomicStudyTypeVS (required) MS
  * ^comment = "Should be used to represent the type of Genomic study performed. Koder bör tas från KarolinskaGenomicStudyTypeVS (placeholder)."
  * ^requirements = "Used to specify the type of analysis. WGS, Exome, Panel etc" 
  * ^definition = "The specific procedure that is performed. Use text if the exact nature of the procedure cannot be coded (e.g. \"Panel Sequencing\", Whole Genome Sequencing, Whole Exome Sequencing etc.)."
* subject only Reference(Patient) MS
 * ^requirements = "Should be used to point to the Karolinska Patient resource(KarolinskaGenomicPatient)"
  * ^comment = "Should be used to point to the Karolinska Patient resource(KarolinskaGenomicPatient) in this release. In future releases, it can point to the Region Stockholm Patient resource."
* encounter ..1
  * ^comment = "Could be used to connect the analysis to the encounter(vårdkontakt) in which the analysis was ordered. Karolinska PAS-ID/kontaktID and at which unit and at which time the encounter occurred."
* performed[x] MS 
  *^requirements = "dateTime of when the case was started."
* asserter ..1
  * ^definition = "No need identified for GDR. Placeholder for future use"
* performer
  * actor MS
    * ^definition = "The performer is the organization that is responsible for the procedure. In this case, the laboratory that performs the genomic analysis." 
    * type = "Organization" (exactly)
    * identifier
    * ^requirements = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "Currently, a local system URL (e.g. http://gmck.se/clarity-lims) is used as the identifier for the laboratory. When HSA-ID/kombika is available, urn:oid:1.2.752.29.4.71 should be used."
    * display ^comment = "Can be set automatically to the laboratory's organization when possible. Otherwise, it may be left blank."
  * onBehalfOf MS
    * type = "Organization" (exactly)
    * identifier
    * ^requirements = "Identifier must be used as long as a reference to an organisation resource is not possible"
      * system 1..1
      * value 1..1
      * system ^comment = "The requester is assigned a serial number (cust001 and upwards) which is specified as text. A system URL representing the requester should be used"
    * display ^comment = "Can be used if a display name of the requester organisation is available"