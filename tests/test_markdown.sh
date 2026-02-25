#!/usr/bin/env bash
# Test: Basic markdown well-formedness.
# Checks that all content markdown files follow basic conventions.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Markdown Well-Formedness Tests"

# Collect all .md files that are content (not .gitkeep, not in runs/).
CONTENT_MD_FILES=(
  "CLAUDE.md"
  "README.md"
  "assumptions/company-context.md"
  "assumptions/target-market.md"
  "assumptions/competitive-landscape.md"
  "assumptions/constraints-and-resources.md"
  "templates/idea-validation-intake.md"
  "templates/monetization-intake.md"
  "templates/data-analysis-intake.md"
  ".claude/commands/idea-validation.md"
  ".claude/commands/monetization.md"
  ".claude/commands/data-analysis.md"
  ".claude/commands/pm-status.md"
)

# --- Every content .md file starts with a level-1 heading ---

for md in "${CONTENT_MD_FILES[@]}"; do
  filepath="$PROJECT_ROOT/$md"
  if [ ! -f "$filepath" ]; then
    fail "File missing (cannot check heading): $md"
    continue
  fi
  first_line=$(head -n 1 "$filepath")
  if [[ "$first_line" == "# "* ]]; then
    pass "Starts with H1: $md"
  else
    fail "Does not start with H1: $md"
  fi
done

# --- No empty content .md files ---

for md in "${CONTENT_MD_FILES[@]}"; do
  assert_file_not_empty "$md" "Not empty: $md"
done

# --- Template files contain placeholder comments ---

for tpl in templates/idea-validation-intake.md templates/monetization-intake.md \
           templates/data-analysis-intake.md; do
  if grep -q '<!--' "$PROJECT_ROOT/$tpl"; then
    pass "Has placeholder comments: $tpl"
  else
    fail "Missing placeholder comments: $tpl"
  fi
done

# --- Command files contain step-by-step instructions ---

for cmd in .claude/commands/idea-validation.md .claude/commands/monetization.md \
           .claude/commands/data-analysis.md; do
  if grep -q '### Step' "$PROJECT_ROOT/$cmd"; then
    pass "Has step-by-step structure: $cmd"
  else
    fail "Missing step-by-step structure: $cmd"
  fi
done

print_summary
