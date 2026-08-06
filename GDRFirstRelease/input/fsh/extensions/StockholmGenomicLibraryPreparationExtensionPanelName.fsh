Extension: StockholmGenomicLibraryPreparationExtensionPanelName
Id: stockholm-genomic-library-preparation-extension-panel-name
Title: "Stockholm Genomic Library Preparation Extension Panel Name"
Description: "Extension that captures the panel name used during library preparation."
Context: Procedure
* ^status = #draft
* value[x] 1..
* value[x] only string
  * ^definition = "The name of the panel used in the library preparation."