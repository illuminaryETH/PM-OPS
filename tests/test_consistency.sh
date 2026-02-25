#!/usr/bin/env bash
# Test: Documentation consistency.
# Verifies CLAUDE.md and README.md agree with each other and with
# the actual filesystem.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Documentation Consistency Tests"

# --- Both docs list all slash commands ---

for cmd in idea-validation monetization data-analysis pm-status; do
  assert_file_contains "CLAUDE.md" "/${cmd}" \
    "CLAUDE.md references /${cmd} command"
  assert_file_contains "README.md" "/${cmd}" \
    "README.md references /${cmd} command"
done

# --- Every .claude/commands/*.md file is referenced in both docs ---

for cmd_file in "$PROJECT_ROOT"/.claude/commands/*.md; do
  cmd_name="$(basename "$cmd_file" .md)"
  if grep -q "/${cmd_name}" "$PROJECT_ROOT/CLAUDE.md"; then
    pass "CLAUDE.md lists command /${cmd_name}"
  else
    fail "CLAUDE.md missing command /${cmd_name}"
  fi
  if grep -q "/${cmd_name}" "$PROJECT_ROOT/README.md"; then
    pass "README.md lists command /${cmd_name}"
  else
    fail "README.md missing command /${cmd_name}"
  fi
done

# --- README lists all assumption files ---

for f in company-context target-market competitive-landscape constraints-and-resources; do
  assert_file_contains "README.md" "${f}.md" \
    "README.md lists assumption file ${f}.md"
done

# --- README lists all template files ---

for f in idea-validation-intake monetization-intake data-analysis-intake; do
  assert_file_contains "README.md" "${f}.md" \
    "README.md lists template ${f}.md"
done

# --- Workflow count matches ---
# Count actual workflow directories vs what docs claim

actual_workflow_count=$(find "$PROJECT_ROOT/workflows" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
for doc in CLAUDE.md README.md; do
  for wf_dir in idea-validation monetization data-analysis; do
    if ! grep -q "$wf_dir" "$PROJECT_ROOT/$doc"; then
      fail "$doc missing reference to workflow $wf_dir"
    fi
  done
done

if [ "$actual_workflow_count" -eq 3 ]; then
  pass "Workflow directory count matches expected (3)"
else
  fail "Expected 3 workflow directories, found $actual_workflow_count"
fi

# --- Both docs describe same project structure ---
# Both should mention the key directories

for dir_name in "assumptions/" "templates/" "workflows/" ".claude/"; do
  assert_file_contains "CLAUDE.md" "$dir_name" \
    "CLAUDE.md mentions $dir_name in structure"
  assert_file_contains "README.md" "$dir_name" \
    "README.md mentions $dir_name in structure"
done

print_summary
