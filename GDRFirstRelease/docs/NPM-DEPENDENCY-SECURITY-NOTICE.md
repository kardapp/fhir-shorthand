# Potential Exploit: NPM Package Dependencies

This note explains the warning related to:
https://www.fhir.org/guides/security-notices/2026-03-npm-dependencies.html

## Why this warning appeared

Our build output reported that the IG depended on `fhir.base.template`.
That template is deprecated and highlighted in the HL7 security notice.

In this repository, the old template was configured in `ig.ini`.

## What a FHIR package is

FHIR packages use the NPM package format (`package.tgz` with metadata), but they are usually not JavaScript libraries.
They mostly contain:

- FHIR profiles, extensions, value sets, code systems
- Implementation Guide content and metadata
- Terminology and specification artifacts
- Templates used by IG Publisher

So "NPM package" here means "NPM container format", not necessarily "Node.js runtime code".

## What the exploit is

The reported exploit concerns using the standard `npm` client to install FHIR packages.
If `npm` resolves dependencies on npmjs.com and finds a malicious package with a matching name, install-time scripts can run on the developer machine.

Important: this is mainly a risk when using `npm install` for FHIR packages.

## How this affects our project

- Our normal build flow uses IG Publisher and SUSHI, not `npm install` to fetch FHIR packages.
- That lowers exploit exposure in day-to-day IG builds.
- However, we were still using a deprecated base template (`fhir.base.template`), which increases security and future-compatibility risk.

## What we changed

We migrated template configuration in `ig.ini` from:

- `fhir.base.template#0.8.1`

to:

- `fhir2.base.template#current`

This aligns with guidance in the HL7 notice for IG authors.

## How to minimize or eliminate risk going forward

1. Do not use `npm install` to install FHIR packages.
2. Prefer FHIR-native tooling for package resolution:
   - IG Publisher
   - FHIR Validator
   - Firely Terminal
3. Keep IG Publisher updated to current releases.
4. Use modern template packages (`fhir2.base.template`) instead of deprecated `fhir.base.template`.
5. If `npm` must be used in a FHIR-only workflow, set `ignore-scripts=true` in an isolated `.npmrc` profile.

## If npm must be used (not preferred)

Example for a dedicated FHIR-only shell/profile:

- Windows user profile file: `%USERPROFILE%\.npmrc`
- Add:

```ini
ignore-scripts=true
```

Warning: this can break some regular JavaScript package installs that require build scripts. Keep this isolated from general JS development workflows.

## Operational checklist for this repository

- [x] Migrated template to `fhir2.base.template`
- [ ] Update IG Publisher regularly (`_updatePublisher.bat`)
- [ ] Keep running full IG build and review `output/qa.html`
- [ ] Avoid introducing `npm install` for FHIR package retrieval

## Notes

The previous local build failures we observed (cache locks and corrupted local package cache) were environment issues and separate from this security notice.
