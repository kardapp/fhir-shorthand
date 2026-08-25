Extension: StockholmGenomicNucleicAcidSequencingExtensionReadCycle
Id: stockholm-genomic-nas-read-cycle
Title: "Stockholm Genomic Nucleic Acid Sequencing Extension Read Cycle"
Description: "Complex extension for read cycle and read type in nucleic acid sequencing."
Context: Procedure
* ^status = #draft
* extension contains
    cycle-count 1..1 and
  read-type 1..1
* value[x] 0..0
* extension[cycle-count] MS
  * ^short = "Read cycle count"
  * ^definition = "Numeric read cycle count used in sequencing."
  * value[x] 1..
  * value[x] only integer
* extension[read-type] MS
  * ^short = "Read type"
  * ^definition = "Specifies whether the read is paired-end or single-end."
  * value[x] 1..
  * value[x] only CodeableConcept
  * value[x] from StockholmGenomicReadTypeVS (required)
