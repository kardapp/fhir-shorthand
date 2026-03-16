Alias: $KarolinskaGenomicLaboratoryProcessExtension = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicLaboratoryProcessExtension
Alias: $KarolinskaPatientGenomics = https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaPatientGenomics

Profile: KarolinskaGenomicsProcedureGenomicStudy
Parent: GenomicStudy
Id: karolinska-genomic-study
Title: "Karolinska Genomic Study"
Description: "The core resource of the Genomic study which holds the genomic study and related profiles together. Its the main procedure resource to represent a Genomic Study.The genomic case includes both laboratory process(es) aswell as the data analysis which are both referenced from this profile."
* ^url = "https://pub.regionstockholm.se/fhir/StructureDefinition/KarolinskaGenomicStudy"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* //^purpose = ""
* extension contains $KarolinskaGenomicLaboratoryProcessExtension named genomic-laboratory-process 0..* MS
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
  * system = "http://mdk.regionstockholm.se/starlims/kliniskgenetik/id" (exactly)
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
  * system = "http://mdk.regionstockholm.se/gmck/clarity-lims/id" (exactly)
  * value 1..
* instantiatesCanonical ..0
  * ^requirements = "Removed for this MVP."
* instantiatesUri ..0
  * ^requirements = "Removed for this MVP"
* basedOn ^comment = "Placeholder for future use. \r\nCan be used to point to a referral (serviceRequest instance), or to hold a logical reference (Referral ID) to link the case to the referral(s) and referral data."
  * ^requirements = "Not used in MVP but is kept as a placeholder to show the possibility to connect this Genomic Study to a service request."
* status = #completed (exactly)
  * ^comment = "The following statuses can be used to represent the status of the procedure: \r\npreparation\r\nin-progress\r\nnot-done\r\non-hold\r\nstopped\r\ncompleted\r\nentered-in-error\r\nunknown"
  * ^requirements = "We only use completed in MVP - The use case of the GDR is to store completed analyses. Not to store analysis thats still in progress etc."
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #405824009 (exactly)
  * display 1..
  * display = "Genetic test (procedure)" (exactly)
* code ^definition = "The specific procedure that is performed. Use text if the exact nature of the procedure cannot be coded (e.g. \"Panel Sequencing\", Whole Genome Sequencing, Whole Exome Sequencing etc.)."
  * ^comment = "Should be used to represent the type of Genomic study performed. Preferably a code from a defined value set should be used. If not applivable the text element can be used."
  * ^requirements = "Used to specify the type of analysis. WGS, Exome, Panel etc.\r\nShould use snomed CT"
* subject only Reference($KarolinskaPatientGenomics)
  * ^comment = "Should be used to point to the Karolinska Patient resource. We do not want to create a seperate patient-resource."
* encounter ..0
  * ^requirements = "Could be used to connect the analysis to the encounter in which the analysis was ordered. Karolinska PAS-ID and at which unit and at which time the encounter occurred."
* performed[x] ^requirements = "dateTime of when the case was started."
* asserter ..0
  * ^definition = "Individual who is making the procedure statement. https"
* performer
  * actor only Reference(Organization)
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..
    * display 1..
  * onBehalfOf 1..
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..
    * display 1..
* reasonCode ..0
* reasonReference ..0
  * ^requirements = "Not used in MVP - But in future can be used to categorize the ptotential diagnosis as the reason to perform the service."