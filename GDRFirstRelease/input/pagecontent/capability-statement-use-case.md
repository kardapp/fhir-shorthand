# CapabilityStatement In GDR

## Is CapabilityStatement generated automatically?

No. IG Publisher does not generate a production-ready server CapabilityStatement automatically.
For GDR, the CapabilityStatement is authored manually as an FSH `Instance`.

## What it is

`CapabilityStatement` is the server contract that describes what the GDR FHIR endpoint supports.
It tells clients which interactions are available and which profiles are expected per resource type.

## What it does

The GDR capability statement documents support for:

- interactions: `create`, `read`, `update`, `search-type`
- resource types relevant for genomic workflows
- supported profiles for each resource type

This gives implementers a single machine-readable source for integration behavior.

## Defined artifact

- Instance: `GDRCapabilityStatement`
- Type: `CapabilityStatement`
- Scope: server mode (`rest.mode = server`)

## Why this matters

Without a curated CapabilityStatement, client teams must infer behavior from profile files and examples.
The manual instance makes the supported API behavior explicit and easier to test and consume.
