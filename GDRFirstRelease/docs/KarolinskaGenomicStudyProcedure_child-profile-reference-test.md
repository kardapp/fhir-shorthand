# Test: Referens till child-profil med egen URL

## Syfte
Denna testbeskrivning verifierar att en child-profil med egen URL (t.ex. KarolinskaGenomicStudyProcedure) kan användas i FHIR-referenser där targetProfile pekar på parent-profilen (t.ex. HL7 GenomicStudy), enligt FHIR-specifikationen.

## Bakgrund
- Child-profilen anger sin parent korrekt i FSH (Parent: GenomicStudy).
- Child-profilen har en egen, Karolinska-specifik URL.
- Reference-elementets targetProfile pekar på parent-profilens URL.

## Förväntat resultat
- Instanser av child-profilen ska validera korrekt mot reference-element med targetProfile satt till parent-profilens URL.
- Ingen explicit ändring av targetProfile krävs för att stödja child-profiler enligt FHIR-specifikationen.

## Motivering
FHIR tillåter att en reference pekar på en instans av en child-profil om denna är en constraint av parent-profilen som anges i targetProfile. Detta är enligt FHIR-reglerna och valideringen ska inte ge fel.

## Testfall
1. Skapa en instans av KarolinskaGenomicStudyProcedure.
2. Referera till denna instans från ett element med targetProfile = HL7 GenomicStudy.
3. Validera instansen mot ImplementationGuide och kontrollera att ingen valideringsvarning eller -fel uppstår.

---

# Test: Reference to child profile with custom URL

## Purpose
This test verifies that a child profile with its own URL (e.g. KarolinskaGenomicStudyProcedure) can be used in FHIR references where the targetProfile points to the parent profile (e.g. HL7 GenomicStudy), according to the FHIR specification.

## Background
- The child profile correctly specifies its parent in FSH (Parent: GenomicStudy).
- The child profile has its own Karolinska-specific URL.
- The reference element’s targetProfile points to the parent profile’s URL.

## Expected result
- Instances of the child profile should validate correctly against reference elements with targetProfile set to the parent profile’s URL.
- No explicit change to targetProfile is needed to support child profiles according to the FHIR specification.

## Motivation
FHIR allows a reference to point to an instance of a child profile if it is a constraint of the parent profile specified in targetProfile. This is according to FHIR rules and validation should not fail.

## Test steps
1. Create an instance of KarolinskaGenomicStudyProcedure.
2. Reference this instance from an element with targetProfile = HL7 GenomicStudy.
3. Validate the instance against the ImplementationGuide and ensure no validation warnings or errors occur.

---
