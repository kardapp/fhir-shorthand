Extension: StockholmGenomicAnalysisExtensionPedigree
Id: stockholm-genomic-analysis-extension-pedigree
Title: "Genomic Study Analysis Extension Pedigree"
Description: "Genomic Study Analysis Extension Pedigree"
Context: Procedure
* ^status = #draft
* . ^short = "Genomic Study Analysis Extension Pedigree"
  * ^definition = "Genomic Study Analysis Extension Pedigree"
* extension contains
    file 0..1 and
    type 0..1 and
    generatedBy 0..0
* extension[file] MS
  * ^short = "GenomicStudy.analysis.input.file"
  * value[x] only Reference(StockholmGenomicDataFile)
* extension[type] MS
  * ^short = "GenomicStudy.analysis.input.type"
  * value[x] 1..
  * value[x] only CodeableConcept
  * value[x] from StockholmGenomicStudyDataFormatVS (preferred)
    * coding 1..1
      * code 1..
      * code = #PED (exactly)
      * display 1..
      * display = "pedigree" (exactly)
