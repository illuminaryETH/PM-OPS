#!/usr/bin/env bash
# Shared test helpers for PM-OPS test suite.
# Source this file at the top of each test_*.sh file.

# Resolve project root relative to this script's location.
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Counters
PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

# Colors (disabled if not a terminal)
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  BOLD='\033[1m'
  RESET='\033[0m'
else
  GREEN='' RED='' YELLOW='' BOLD='' RESET=''
fi

pass() {
  PASS_COUNT=$((PASS_COUNT + 1))
  printf "${GREEN}  ✓ %s${RESET}\n" "$1"
}

fail() {
  FAIL_COUNT=$((FAIL_COUNT + 1))
  printf "${RED}  ✗ %s${RESET}\n" "$1"
}

warn() {
  WARN_COUNT=$((WARN_COUNT + 1))
  printf "${YELLOW}  ⚠ %s${RESET}\n" "$1"
}

suite_header() {
  printf "\n${BOLD}━━━ %s ━━━${RESET}\n" "$1"
}

# --- Assertion helpers ---

assert_dir_exists() {
  local dir="$1" label="${2:-$1}"
  if [ -d "$PROJECT_ROOT/$dir" ]; then
    pass "Directory exists: $label"
  else
    fail "Directory missing: $label"
  fi
}

assert_file_exists() {
  local file="$1" label="${2:-$1}"
  if [ -f "$PROJECT_ROOT/$file" ]; then
    pass "File exists: $label"
  else
    fail "File missing: $label"
  fi
}

assert_file_not_empty() {
  local file="$1" label="${2:-$1}"
  if [ -f "$PROJECT_ROOT/$file" ] && [ -s "$PROJECT_ROOT/$file" ]; then
    pass "File not empty: $label"
  else
    fail "File empty or missing: $label"
  fi
}

assert_file_contains() {
  local file="$1" pattern="$2" label="${3:-$file contains '$pattern'}"
  if [ -f "$PROJECT_ROOT/$file" ] && grep -q "$pattern" "$PROJECT_ROOT/$file"; then
    pass "$label"
  else
    fail "$label"
  fi
}

assert_file_not_contains() {
  local file="$1" pattern="$2" label="${3:-$file does not contain '$pattern'}"
  if [ -f "$PROJECT_ROOT/$file" ] && ! grep -q "$pattern" "$PROJECT_ROOT/$file"; then
    pass "$label"
  else
    fail "$label"
  fi
}

# Print summary. Returns 1 if any failures.
print_summary() {
  local total=$((PASS_COUNT + FAIL_COUNT + WARN_COUNT))
  printf "\n${BOLD}Results: %d passed, %d failed, %d warnings (of %d checks)${RESET}\n" \
    "$PASS_COUNT" "$FAIL_COUNT" "$WARN_COUNT" "$total"
  [ "$FAIL_COUNT" -eq 0 ]
}
