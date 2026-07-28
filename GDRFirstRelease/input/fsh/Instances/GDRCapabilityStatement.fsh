Instance: GDRCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
Title: "GDR Capability Statement"
Description: "Server capability statement for the Stockholm Genomic Data Repository (GDR)."

* url = "https://pub.regionstockholm.se/fhir/gdr/CapabilityStatement/GDRCapabilityStatement"
* version = "0.0.1-alpha1"
* name = "GDRCapabilityStatement"
* status = #draft
* experimental = false
* date = "2026-07-28"
* publisher = "Karolinska University Hospital"
* kind = #instance
* software.name = "Stockholm Genomic Data Repository"
* software.version = "0.0.1-alpha1"
* implementation.description = "Capability statement for the GDR FHIR server."
* implementation.url = "https://pub.regionstockholm.se/fhir/gdr"
* fhirVersion = #4.0.1
* format[+] = #json
* format[+] = #xml

* rest[0].mode = #server
* rest[0].documentation = "The GDR server supports create, read, update and search interactions for genomic data resources."

* rest[0].resource[0].type = #Bundle
* rest[0].resource[0].supportedProfile[+] = Canonical(StockholmGenomicBundle)
* rest[0].resource[0].interaction[0].code = #create
* rest[0].resource[0].interaction[1].code = #read
* rest[0].resource[0].interaction[2].code = #update
* rest[0].resource[0].interaction[3].code = #search-type

* rest[0].resource[1].type = #Patient
* rest[0].resource[1].supportedProfile[+] = Canonical(StockholmGenomicPatient)
* rest[0].resource[1].interaction[0].code = #create
* rest[0].resource[1].interaction[1].code = #read
* rest[0].resource[1].interaction[2].code = #update
* rest[0].resource[1].interaction[3].code = #search-type

* rest[0].resource[2].type = #RelatedPerson
* rest[0].resource[2].supportedProfile[+] = Canonical(StockholmGenomicRelatedPerson)
* rest[0].resource[2].interaction[0].code = #create
* rest[0].resource[2].interaction[1].code = #read
* rest[0].resource[2].interaction[2].code = #update
* rest[0].resource[2].interaction[3].code = #search-type

* rest[0].resource[3].type = #Specimen
* rest[0].resource[3].supportedProfile[+] = Canonical(StockholmGenomicSpecimen)
* rest[0].resource[3].interaction[0].code = #create
* rest[0].resource[3].interaction[1].code = #read
* rest[0].resource[3].interaction[2].code = #update
* rest[0].resource[3].interaction[3].code = #search-type

* rest[0].resource[4].type = #Procedure
* rest[0].resource[4].supportedProfile[+] = Canonical(StockholmGenomicStudyProcedure)
* rest[0].resource[4].supportedProfile[+] = Canonical(StockholmGenomicProcedureLaboratoryProcess)
* rest[0].resource[4].supportedProfile[+] = Canonical(StockholmGenomicProcedureLibraryPreparation)
* rest[0].resource[4].supportedProfile[+] = Canonical(StockholmGenomicProcedureNucleicAcidSequencing)
* rest[0].resource[4].supportedProfile[+] = Canonical(StockholmGenomicStudyAnalysisProcedure)
* rest[0].resource[4].interaction[0].code = #create
* rest[0].resource[4].interaction[1].code = #read
* rest[0].resource[4].interaction[2].code = #update
* rest[0].resource[4].interaction[3].code = #search-type

* rest[0].resource[5].type = #DocumentReference
* rest[0].resource[5].supportedProfile[+] = Canonical(StockholmGenomicDataFile)
* rest[0].resource[5].interaction[0].code = #create
* rest[0].resource[5].interaction[1].code = #read
* rest[0].resource[5].interaction[2].code = #update
* rest[0].resource[5].interaction[3].code = #search-type

* rest[0].resource[6].type = #Device
* rest[0].resource[6].supportedProfile[+] = Canonical(StockholmGenomicDevice)
* rest[0].resource[6].interaction[0].code = #create
* rest[0].resource[6].interaction[1].code = #read
* rest[0].resource[6].interaction[2].code = #update
* rest[0].resource[6].interaction[3].code = #search-type
