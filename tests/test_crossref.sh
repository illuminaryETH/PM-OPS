#!/usr/bin/env bash
# Test: Cross-reference integrity.
# Verifies that file paths referenced inside command definitions and
# templates actually exist on disk.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Cross-Reference Integrity Tests"

ASSUMPTIONS=(
  "assumptions/company-context.md"
  "assumptions/target-market.md"
  "assumptions/competitive-landscape.md"
  "assumptions/constraints-and-resources.md"
)

# --- Each workflow command references all 4 assumption files ---

for cmd in idea-validation monetization data-analysis; do
  CMD_FILE=".claude/commands/${cmd}.md"
  for assumption in "${ASSUMPTIONS[@]}"; do
    assert_file_contains "$CMD_FILE" "$assumption" \
      "${cmd} command references ${assumption}"
  done
done

# --- Each workflow command references its correct intake directory ---

assert_file_contains ".claude/commands/idea-validation.md" \
  "workflows/idea-validation/intake/" \
  "idea-validation command references its intake dir"

assert_file_contains ".claude/commands/monetization.md" \
  "workflows/monetization/intake/" \
  "monetization command references its intake dir"

assert_file_contains ".claude/commands/data-analysis.md" \
  "workflows/data-analysis/intake/" \
  "data-analysis command references its intake dir"

# --- pm-status references all runs and intake directories ---

for wf in idea-validation monetization data-analysis; do
  assert_file_contains ".claude/commands/pm-status.md" \
    "workflows/${wf}/runs/" \
    "pm-status references ${wf}/runs/"

  assert_file_contains ".claude/commands/pm-status.md" \
    "workflows/${wf}/intake/" \
    "pm-status references ${wf}/intake/"
done

# --- Templates point to correct intake paths in their copy instructions ---

assert_file_contains "templates/idea-validation-intake.md" \
  "workflows/idea-validation/intake/" \
  "idea-validation template copy instructions reference correct intake path"

assert_file_contains "templates/monetization-intake.md" \
  "workflows/monetization/intake/" \
  "monetization template copy instructions reference correct intake path"

assert_file_contains "templates/data-analysis-intake.md" \
  "workflows/data-analysis/intake/" \
  "data-analysis template copy instructions reference correct intake path"

print_summary
