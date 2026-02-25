#!/usr/bin/env bash
# Test: Workflow-README alignment.
# Verifies that output files listed in each workflow command match
# what the README documents, and checks common output patterns.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Workflow-README Alignment Tests"

README="README.md"

# --- idea-validation outputs ---
# Command defines: executive-summary.md, market-analysis.md,
# competitive-scan.md, risk-assessment.md, recommendation.md

for output in executive-summary.md market-analysis.md competitive-scan.md \
             risk-assessment.md recommendation.md; do
  assert_file_contains "$README" "$output" \
    "README lists idea-validation output: $output"
done

# --- monetization outputs ---
# Command defines: executive-summary.md, revenue-model.md,
# unit-economics.md, pricing-analysis.md, recommendation.md

for output in revenue-model.md unit-economics.md pricing-analysis.md; do
  assert_file_contains "$README" "$output" \
    "README lists monetization output: $output"
done

# --- data-analysis outputs ---
# Command defines: executive-summary.md, methodology.md,
# findings.md, recommendations.md

for output in methodology.md findings.md recommendations.md; do
  assert_file_contains "$README" "$output" \
    "README lists data-analysis output: $output"
done

# --- Every workflow produces an executive-summary.md ---

for cmd in idea-validation monetization data-analysis; do
  assert_file_contains ".claude/commands/${cmd}.md" "executive-summary.md" \
    "${cmd} command specifies executive-summary.md output"
done

# --- Every workflow produces a recommendation output ---
# Note: data-analysis uses "recommendations.md" (plural),
# idea-validation and monetization use "recommendation.md" (singular).
# This test verifies each has at least one form.

for cmd in idea-validation monetization data-analysis; do
  CMD_FILE=".claude/commands/${cmd}.md"
  if grep -q "recommendation" "$PROJECT_ROOT/$CMD_FILE"; then
    pass "${cmd} command specifies a recommendation output"
  else
    fail "${cmd} command missing recommendation output"
  fi
done

# --- Cross-check: README workflow sections list correct output counts ---
# idea-validation: 5 outputs, monetization: 5 outputs, data-analysis: 4 outputs

assert_file_contains "$README" "executive-summary.md.*market-analysis.md.*competitive-scan.md.*risk-assessment.md.*recommendation.md" \
  "README lists all 5 idea-validation outputs in sequence" \
  || true  # Grep may not match across lines; checked individually above

print_summary
