#!/usr/bin/env bash
# Test: Intake templates contain all sections that their corresponding
# workflow commands expect to consume.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Template Completeness Tests"

# --- idea-validation-intake.md ---
# The workflow's gap check expects: problem statement, target user,
# hypotheses, success criteria, and company context (from assumptions).

TPL="templates/idea-validation-intake.md"

assert_file_contains "$TPL" "## Idea Name" \
  "idea-validation template has '## Idea Name'"
assert_file_contains "$TPL" "## Problem Statement" \
  "idea-validation template has '## Problem Statement'"
assert_file_contains "$TPL" "## Target User" \
  "idea-validation template has '## Target User'"
assert_file_contains "$TPL" "## Proposed Solution" \
  "idea-validation template has '## Proposed Solution'"
assert_file_contains "$TPL" "## Hypotheses" \
  "idea-validation template has '## Hypotheses'"
assert_file_contains "$TPL" "## Success Criteria" \
  "idea-validation template has '## Success Criteria'"
assert_file_contains "$TPL" "## Known Risks" \
  "idea-validation template has '## Known Risks'"
assert_file_contains "$TPL" "## Constraints" \
  "idea-validation template has '## Constraints'"

# --- monetization-intake.md ---
# The workflow's gap check expects: price points/tiers, cost inputs,
# growth assumptions, clear question, comparison scenarios.

TPL="templates/monetization-intake.md"

assert_file_contains "$TPL" "## Initiative Name" \
  "monetization template has '## Initiative Name'"
assert_file_contains "$TPL" "## Pricing Questions" \
  "monetization template has '## Pricing Questions'"
assert_file_contains "$TPL" "## Current Pricing" \
  "monetization template has '## Current Pricing'"
assert_file_contains "$TPL" "## Pricing Assumptions" \
  "monetization template has '## Pricing Assumptions'"
assert_file_contains "$TPL" "## Cost Inputs" \
  "monetization template has '## Cost Inputs'"
assert_file_contains "$TPL" "## Growth Assumptions" \
  "monetization template has '## Growth Assumptions'"
assert_file_contains "$TPL" "## Scenarios to Model" \
  "monetization template has '## Scenarios to Model'"
assert_file_contains "$TPL" "## Time Horizon" \
  "monetization template has '## Time Horizon'"

# --- data-analysis-intake.md ---
# The workflow's gap check expects: answerable question, needed fields,
# clear definitions, sufficient date range, data quality awareness.

TPL="templates/data-analysis-intake.md"

assert_file_contains "$TPL" "## Analysis Name" \
  "data-analysis template has '## Analysis Name'"
assert_file_contains "$TPL" "## Question to Answer" \
  "data-analysis template has '## Question to Answer'"
assert_file_contains "$TPL" "## Why This Matters" \
  "data-analysis template has '## Why This Matters'"
assert_file_contains "$TPL" "## Data Sources" \
  "data-analysis template has '## Data Sources'"
assert_file_contains "$TPL" "## Data Notes" \
  "data-analysis template has '## Data Notes'"
assert_file_contains "$TPL" "## Hypotheses" \
  "data-analysis template has '## Hypotheses'"
assert_file_contains "$TPL" "## Scope and Boundaries" \
  "data-analysis template has '## Scope and Boundaries'"

print_summary
