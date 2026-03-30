ValueSet: KarolinskaGenomicStudyStatusVS
Id: karolinska-genomic-study-status-vs
Title: "Karolinska Genomic Study Status ValueSet"
Description: "Begränsar status till endast 'completed' och 'in-progress' för Karolinska Genomic Study."
* ^url = "https://pub.regionstockholm.se/fhir/ValueSet/karolinska-genomic-study-status-vs"
* ^status = #active
* ^version = "1.0.0"
* ^experimental = false
* ^publisher = "Karolinska University Hospital"
* ^compose.include.system = "http://hl7.org/fhir/event-status"
* ^compose.include.concept[0].code = #completed
* ^compose.include.concept[1].code = #in-progress
