Alias: $KarolinskaGenomicLibraryPreperationExtension = https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGenomicLibraryPreperationExtension
Alias: $KarolinskaGeneSequencingExtension = https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaGeneSequencingExtension
Alias: $KarolinskaFocusExtension = https://karolinskafhirserver/fhir/StructureDefinition/KarolinskaFocusExtension

Profile: KarolinskaGenomicLaboratoryProcess
Parent: Procedure
Id: KarolinskaGenomicLaboratoryProcess
Title: "Karolinska Genomic Laboratory Process"
Description: "Used to represent and hold together the laboratory process, including library preperation and the gene sequencing. Each GenomicStudy can include several laboratory processes, one for each sample connected to the genomic study.."
* ^url = "https://karolinskafhirserver.org/fhir/StructureDefinition/KarolinskaLaboratoryProcess"
* ^version = "1.0.0-alpha.1"
* ^status = #draft
* ^purpose = "The purpose of this profile is to be part of the MVP-GDR project with the goal to evaluate FHIR as a standard to meet our needs for genomic data.\r\nIt should therefore be known that the information model itself has been created for the purpose of performing this evaluation. The information model is therefore NOT ready for implementation in a production environment to store resource data."
* extension 3..
* extension contains
    $KarolinskaGenomicLibraryPreperationExtension named genomic-library-preperation 1..1 and
    $KarolinskaGeneSequencingExtension named gene-sequencing 1..1 and
    $KarolinskaFocusExtension named focus 1..1
* extension[genomic-library-preperation] ^isModifier = false
* extension[gene-sequencing] ^isModifier = false
* extension[focus] ^isModifier = false
* identifier ..0
* instantiatesCanonical ..0
* instantiatesUri ..0
* basedOn ..0
* partOf only Reference(KarolinskaGenomicStudy or Procedure)
* status = #completed (exactly)
  * ^comment = "The following statuses can be used to represent the status of the procedure: \r\npreparation | in-progress | not-done | on-hold | stopped | completed | entered-in-error | unknown"
* statusReason ..0
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #108252007 (exactly)
  * display 1..
  * display = "Laboratory procedure (procedure)" (exactly)
* code ..0
* subject only Reference(KarolinskaPatientGenomics)
* encounter ..0
* recorder ..0
* asserter ..0
* performer
  * actor only Reference(Organization)
    * ^definition = "The practitioner who was involved in the procedure. Note that if this element is empty, the perfomer Genomic Study profile is used."
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..
    * display 1..
    * display = "GMCK" (exactly)
  * onBehalfOf ^definition = "The organization the device or practitioner was acting on behalf of. Note that if this element is empty, the perfomer Genomic Study profile is used."
    * identifier
      * system 1..
      * value 1..
* location ..0
* reasonCode ..0
* reasonReference ..0
* bodySite ..0
* outcome ..0
* report ..0
* complication ..0
* complicationDetail ..0
* followUp ..0
* focalDevice ..0
* usedReference ..0
* usedCode ..0