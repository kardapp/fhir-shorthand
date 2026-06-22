ValueSet: StockholmGenomicProcedureStatusVS
Id: Stockholm-genomic-procedure-status-vs
Title: "Stockholm Genomic Procedure Status ValueSet"
Description: "Begränsar status till endast 'completed' och 'in-progress' för Stockholm Genomic Procedure."

* ^status = #active
* ^version = "1.0.0"
* ^experimental = false
* ^publisher = "Stockholm University Hospital"
* ^compose.include.system = "http://hl7.org/fhir/event-status"
* ^compose.include.concept[0].code = #completed
* ^compose.include.concept[1].code = #in-progress
