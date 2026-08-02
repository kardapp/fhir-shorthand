# Work Summary (From 7 July 2026)

This file summarizes the work completed from 7 July 2026 onward.

## Work Items- Refer to To do list and issues to do.

  - Added example instances for genomic extensions, including pedigree, specimen, and analysis pipeline.
  - Updated genomic extension instances to use inline usage and added identifiers.
  - Enhanced publisher update workflow with a local update script to avoid overwriting .bat/.sh files during IG generation.
  - Updated index page numbering behavior for correct HTML display.
  - Fixed warnings in instances.
  - Enhanced genomic specimen profiles with additional identifiers and coding updates.
  - Resolved previous profile validation errors (from earlier generated errors to 0 errors for that set).
  - Updated IG generation instructions.
  - Updated study analysis profile constraints (including code/cardinality changes and cleanup of child coding attributes).
  - Updated documentation URIs for bioinformatics pipeline and nanopore sequencing platform instances.
  - Updated ValueSet experimental status and incremented hl7.fhir.us.core dependency version.
  - Added Bundle profile and Bundle example for genomic submissions.
  - Updated related index and documentation pages.
  - Added CapabilityStatement use-case documentation.
  - Added GDRCapabilityStatement instance.
  - Added Search Parameters documentation and updated TODO checklist for GDRCapabilityStatement.
  - Fixed SearchParameter canonical definition URLs in GDRCapabilityStatement (Patient/Procedure/DocumentReference related definitions).
  - Enhanced genomic profile documentation with clearer profile-level descriptions and element-level short/definition text.
  - Translated index.md sections to English.
  - Normalized indentation/formatting in profile files.
  - Re-ran IG builds and validations in offline terminology mode.

## Current Publishing Issue

genonce.bat is not working and we have to skip the terminology server by writing cmd /c "(echo.|_genonce.bat -tx n/a)" previously it worked but now we need to fix this issue.
