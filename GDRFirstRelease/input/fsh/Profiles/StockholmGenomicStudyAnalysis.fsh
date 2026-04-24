Alias: $StockholmGenomicDataFile = https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicDataFile
Alias: $StockholmGenomicStudyAnalysisVersion = https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicStudyAnalysisVersion
Alias: $StockholmGenomicAnalysisPedigreeExtension = https://Stockholmfhirserver/fhir/StructureDefinition/StockholmGenomicAnalysisPedigreeExtension
Alias
Profile: StockholmGenomicStudyAnalysis
Parent: GenomicStudyAnalysis
Id: StockholmGenomicStudyAnalysis
Title: "Stockholm Genomic Study Analysis"
Description: "Part of the GenomicStudy and used to represent the data analysis performed in the study. A Genomic Study containes of a genomic study analysis. This profile has bbeen created to store the resource data about the data analysis aswell as pointing to all the important files used and created in this procedure."
* ^url = "https://Stockholmfhirserver.org/fhir/StructureDefinition/StockholmGenomicStudyAnalysis"
* ^status = #draft
* extension[regions].extension[studied].value[x] only CodeableConcept or Reference($StockholmGenomicDataFile)
* extension[device].valueReference only Reference($StockholmGenomicDevice) MS
  * ^comment = "Genomic Study Analysis Device - Kan användas istället för attributen titel och version som nu används för titeln/namnet på den bioinformatiska pipeline som körs samt versionen av den."
* extension[protocol-performed] ..0
* extension[genomic-source-class] ..0
* extension contains
    $StockholmGenomicStudyAnalysisVersion named version 0..* and
    $StockholmGenomicAnalysisPedigreeExtension named pedigree 0..*
* extension[version] ^isModifier = false
* extension[pedigree] ^isModifier = false
* identifier ..0
* instantiatesCanonical ..0
* instantiatesUri ..0
* partOf only Reference(Procedure or StockholmGenomicStudy)
* status = #completed (exactly)
  * ^comment = "The following statuses can be used to represent the status of the procedure: \r\npreparation | in-progress | not-done | on-hold | stopped | completed | entered-in-error | unknown"
* category.coding
  * system 1..
  * system = "http://snomed.info/sct" (exactly)
  * code 1..
  * code = #118117001 (exactly)
  * display 1..
  * display = "Gene mutation analysis (procedure)" (exactly)
* code.coding ..0
* subject only Reference(StockholmPatientGenomics)
* performer
  * actor only Reference(Organization)
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..
    * display 1..
    * display = "GMCK" (exactly)
  * onBehalfOf
    * type = "Organization" (exactly)
    * identifier
      * system 1..
      * system = "http://gmck.se/clarity-lims" (exactly)
      * value 1..