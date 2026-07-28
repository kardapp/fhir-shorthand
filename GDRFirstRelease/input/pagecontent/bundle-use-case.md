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

## Example

An example bundle is included as `StockholmGenomicBundleExample` and demonstrates a single transaction containing patient, specimen, procedures, and data file metadata.

## Server expectation

The Bundle is intended to be posted to the Bundle endpoint:

`POST [base]/Bundle`

with `Bundle.type = transaction` and per-entry `request.method`/`request.url` populated.
