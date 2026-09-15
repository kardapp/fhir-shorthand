#!/usr/bin/env bash
#
# Extracts the QA summary ("errors = X, warn = Y, broken links = Z") produced by
# the HL7 IG Publisher and exposes it as step outputs plus a job summary.
#
# Usage: qa-summary.sh <output-dir> [publisher-log]
#
# Outputs (via $GITHUB_OUTPUT when running in Actions):
#   errors, warnings, notes, broken_links, summary
set -euo pipefail

output_dir="${1:-output}"
publisher_log="${2:-}"

qa_html="$output_dir/qa.html"

summary_line=""

# The summary line is rendered near the top of qa.html and also echoed to the
# publisher console log, so try both sources.
for candidate in "$qa_html" "$publisher_log"; do
  [ -n "$candidate" ] && [ -f "$candidate" ] || continue
  summary_line=$(
    tr -d '\000' < "$candidate" \
      | grep -aoiE 'errors? *[:=] *[0-9]+[^<>]{0,120}' \
      | head -1 \
      || true
  )
  [ -n "$summary_line" ] && break
done

# Pull a single "<label> = <number>" pair out of the summary line.
field() {
  local pattern="$1"
  printf '%s' "$summary_line" \
    | grep -oiE "${pattern} *[:=] *[0-9]+" \
    | grep -oE '[0-9]+' \
    | head -1 \
    || true
}

errors=$(field 'errors?')
warnings=$(field '(warnings?|warn)')
notes=$(field '(notes?|info)')
broken_links=$(field 'broken.links')

: "${errors:=unknown}"
: "${warnings:=unknown}"
: "${notes:=unknown}"
: "${broken_links:=unknown}"

if [ -z "$summary_line" ]; then
  summary_line="QA summary not found (no qa.html and no summary line in the publisher log)"
fi

echo "QA summary: $summary_line"
echo "errors=$errors warnings=$warnings notes=$notes broken_links=$broken_links"

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  {
    echo "errors=$errors"
    echo "warnings=$warnings"
    echo "notes=$notes"
    echo "broken_links=$broken_links"
    echo "summary=$summary_line"
  } >> "$GITHUB_OUTPUT"
fi

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "### IG Publisher QA"
    echo
    echo "| Metric | Count |"
    echo "| --- | --- |"
    echo "| Errors | $errors |"
    echo "| Warnings | $warnings |"
    echo "| Notes / info | $notes |"
    echo "| Broken links | $broken_links |"
    echo
    echo "Full report: \`qa.html\` in the build artifact (errors only: \`qa.min.html\`)."
  } >> "$GITHUB_STEP_SUMMARY"
fi
