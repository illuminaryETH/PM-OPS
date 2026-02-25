#!/usr/bin/env bash
# Test: Directory structure and file existence.
# Verifies the expected skeleton of the PM-OPS workspace is intact.

source "$(dirname "$0")/test_helpers.sh"

suite_header "Structure Tests"

# --- Expected directories ---

assert_dir_exists "assumptions"
assert_dir_exists "templates"
assert_dir_exists "workflows"
assert_dir_exists "workflows/idea-validation"
assert_dir_exists "workflows/idea-validation/intake"
assert_dir_exists "workflows/idea-validation/runs"
assert_dir_exists "workflows/monetization"
assert_dir_exists "workflows/monetization/intake"
assert_dir_exists "workflows/monetization/runs"
assert_dir_exists "workflows/data-analysis"
assert_dir_exists "workflows/data-analysis/intake"
assert_dir_exists "workflows/data-analysis/runs"
assert_dir_exists ".claude"
assert_dir_exists ".claude/commands"

# --- .gitkeep files in empty dirs ---

assert_file_exists "workflows/idea-validation/intake/.gitkeep"
assert_file_exists "workflows/idea-validation/runs/.gitkeep"
assert_file_exists "workflows/monetization/intake/.gitkeep"
assert_file_exists "workflows/monetization/runs/.gitkeep"
assert_file_exists "workflows/data-analysis/intake/.gitkeep"
assert_file_exists "workflows/data-analysis/runs/.gitkeep"

# --- Core content files ---

assert_file_exists "CLAUDE.md"
assert_file_exists "README.md"

# Assumption files
assert_file_exists "assumptions/company-context.md"
assert_file_exists "assumptions/target-market.md"
assert_file_exists "assumptions/competitive-landscape.md"
assert_file_exists "assumptions/constraints-and-resources.md"

# Templates
assert_file_exists "templates/idea-validation-intake.md"
assert_file_exists "templates/monetization-intake.md"
assert_file_exists "templates/data-analysis-intake.md"

# Slash command definitions
assert_file_exists ".claude/commands/idea-validation.md"
assert_file_exists ".claude/commands/monetization.md"
assert_file_exists ".claude/commands/data-analysis.md"
assert_file_exists ".claude/commands/pm-status.md"

print_summary
