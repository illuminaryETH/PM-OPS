# PM Status Dashboard

Generate a concise status summary across all workflows.

## Instructions

### Step 1: Scan All Workflow Runs

Check each runs directory for existing output folders:
- `workflows/idea-validation/runs/`
- `workflows/monetization/runs/`
- `workflows/data-analysis/runs/`

List all run folders, sorted by date (most recent first).

### Step 2: Scan Pending Intakes

Check each intake directory for files that haven't been run yet:
- `workflows/idea-validation/intake/`
- `workflows/monetization/intake/`
- `workflows/data-analysis/intake/`

### Step 3: Read Recent Summaries

For the 3 most recent runs (across all workflows), read their `executive-summary.md` to extract:
- The verdict or key conclusion
- Confidence level
- Recommended next steps

### Step 4: Check Assumptions Health

Read each file in `assumptions/` and check:
- Are there empty or placeholder sections?
- Does the content appear complete or skeletal?

### Step 5: Output

Print the status directly to the conversation (do not create a file):

```
## PM-OPS Status

### Recent Runs

| Date | Workflow | Name | Verdict / Key Finding | Confidence |
|------|----------|------|-----------------------|------------|
| ...  | ...      | ...  | ...                   | ...        |

### Pending Intakes

- [ ] workflow/intake-file.md — (brief description)

### Assumptions Health

| File | Status | Notes |
|------|--------|-------|
| company-context.md | Complete / Incomplete / Empty | ... |
| target-market.md | ... | ... |
| competitive-landscape.md | ... | ... |
| constraints-and-resources.md | ... | ... |

### Suggested Actions

1. ...
2. ...
3. ...
```

## Tone

- Brief and scannable. This is a dashboard, not a report.
- Flag anything stale or incomplete.
- Prioritize actions the PM should take.
