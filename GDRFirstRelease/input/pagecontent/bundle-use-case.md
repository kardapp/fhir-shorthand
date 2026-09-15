# Bundle Submission To GDR

## Why a Bundle profile is needed

GDR ingestion commonly requires several related resources to be submitted together for one genomic case.
A dedicated Bundle profile ensures the submission format is consistent and reusable across implementations.

## Recommended Bundle type

Use `transaction` as the default submission type.

- `transaction` provides atomic behavior (all-or-nothing), which is preferred for case integrity.
- `batch` allows partial success and can leave the case in an inconsistent state.
- `collection` is good for packaging or transport, but not for server-side create/update semantics.

## Defined profile

- Profile: `StockholmGenomicBundle`
- Parent: `Bundle`
- Fixed type: `transaction`
- Entry requirements: each entry must include `fullUrl`, `resource`, and `request` details.
- Internal references are created using temporary `fullUrl` values such as `urn:uuid:...` because resource IDs are not known until the server accepts the transaction.
- Each entry must also define `request.method` and `request.url` so the server knows whether to create, update, or replace the resource and where to process it.

This design allows a genomic case to be submitted as one coherent transaction even though the final server-generated identities are only assigned during processing.

## Example

An example bundle is included as `StockholmGenomicBundleExample` and demonstrates a single transaction containing patient, specimen, procedures, and data file metadata.

A common pattern is to use a temporary identifier in `fullUrl` for the patient and then reference it from specimen, procedures, and analysis resources before the server has assigned the final patient ID.

## Server expectation

The Bundle is intended to be posted to the Bundle endpoint:

`POST [base]/Bundle`

with `Bundle.type = transaction` and per-entry `request.method`/`request.url` populated.

The server processes all entries atomically, which means the genomic case is created as a single logical submission and is not considered complete unless all required entries are accepted.
