# 02 - Skriva profiler och andra artefakter i FSH

## Grundsyntax
Vanliga byggblock i FSH:
- `Profile`, `Extension`, `Instance`, `ValueSet`, `CodeSystem`, `Invariant`.
- `Parent` för vilken basresurs artefakten bygger på.
- `*` för att uttrycka regler på element.

## Exempel: profil
```fsh
Profile: StockholmGenomicReport
Parent: DiagnosticReport
Id: stockholm-genomic-report
Title: "Stockholm Genomic Report"
Description: "Profil för genomisk diagnostikrapport"

* status 1..1
* code 1..1
* subject 1..1
* result 1..*
```

## Exempel: extension
```fsh
Extension: StockholmFocusExtension
Id: stockholm-focus-extension
Title: "Stockholm Focus Extension"
Description: "Anger fokus för den genomiska analysen"

* value[x] only string
* valueString 1..1
```

## Exempel: binda terminologi
```fsh
* code from http://hl7.org/fhir/ValueSet/observation-codes (preferred)
```

## Exempel: referenser
```fsh
* subject only Reference(Patient)
* performer only Reference(Practitioner or Organization)
```

## Namngivningsprinciper (förslag)
- Håll `Id` stabilt och maskinläsbart (små bokstäver, bindestreck).
- Håll `Title` människoläsbart.
- Beskriv syfte tydligt i `Description`.
- Följ en konsekvent prefix-strategi, t.ex. `Stockholm...`.

## Vanliga misstag
- För breda kardinaliteter (`0..*`) där domänen egentligen kräver tydligare krav.
- Terminologi saknar bindning trots att fältet är kodstyrt.
- Otydlig skillnad mellan profil-krav och lokala exempel.

## Checklista för ny artefakt
- Finns tydligt syfte och målgrupp?
- Är element som måste finnas satta till `1..1` eller motsvarande?
- Är relevanta fält bundna till ValueSet?
- Är referenser begränsade till rätt profiler/resurser?
- Finns minst en representativ `Instance` för verifiering?
