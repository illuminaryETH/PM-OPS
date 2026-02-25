#!/usr/bin/env bash
# PM-OPS Test Runner
# Usage: ./tests/run_tests.sh [suite ...]
# Examples:
#   ./tests/run_tests.sh              # run all suites
#   ./tests/run_tests.sh structure    # run only structure tests
#   ./tests/run_tests.sh templates crossref  # run two suites

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ALL_SUITES=(
  structure
  templates
  crossref
  alignment
  consistency
  markdown
)

# Determine which suites to run.
if [ $# -gt 0 ]; then
  SUITES=("$@")
else
  SUITES=("${ALL_SUITES[@]}")
fi

TOTAL_PASS=0
TOTAL_FAIL=0
TOTAL_WARN=0
EXIT_CODE=0

printf "\n\033[1mPM-OPS Test Suite\033[0m\n"
printf "═══════════════════════════════════════════\n"

for suite in "${SUITES[@]}"; do
  suite_file="$SCRIPT_DIR/test_${suite}.sh"
  if [ ! -f "$suite_file" ]; then
    printf "\033[0;31m  ✗ Suite not found: %s\033[0m\n" "$suite_file"
    TOTAL_FAIL=$((TOTAL_FAIL + 1))
    EXIT_CODE=1
    continue
  fi

  # Run suite in a subshell and capture its output and exit code.
  output=$(bash "$suite_file" 2>&1) || true
  printf "%s\n" "$output"

  # Extract counts from the Results line.
  results_line=$(echo "$output" | grep -E "^Results:" || true)
  if [ -n "$results_line" ]; then
    p=$(echo "$results_line" | grep -oP '\d+(?= passed)' || echo 0)
    f=$(echo "$results_line" | grep -oP '\d+(?= failed)' || echo 0)
    w=$(echo "$results_line" | grep -oP '\d+(?= warnings)' || echo 0)
    TOTAL_PASS=$((TOTAL_PASS + p))
    TOTAL_FAIL=$((TOTAL_FAIL + f))
    TOTAL_WARN=$((TOTAL_WARN + w))
    if [ "$f" -gt 0 ]; then
      EXIT_CODE=1
    fi
  fi
done

TOTAL=$((TOTAL_PASS + TOTAL_FAIL + TOTAL_WARN))

printf "\n═══════════════════════════════════════════\n"
if [ "$TOTAL_FAIL" -eq 0 ]; then
  printf "\033[0;32m\033[1mALL PASSED: %d passed, %d warnings (of %d checks)\033[0m\n\n" \
    "$TOTAL_PASS" "$TOTAL_WARN" "$TOTAL"
else
  printf "\033[0;31m\033[1mFAILURES: %d passed, %d failed, %d warnings (of %d checks)\033[0m\n\n" \
    "$TOTAL_PASS" "$TOTAL_FAIL" "$TOTAL_WARN" "$TOTAL"
fi

exit $EXIT_CODE
