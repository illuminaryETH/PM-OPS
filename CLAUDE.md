# pm-ops

A lightweight PM Ops workspace designed for Claude Code: repeatable workflows + shared context.

## Project Structure

```
PM-OPS/
├── CLAUDE.md              # Project-wide instructions for Claude
├── assumptions/           # Standing context: company, market, competition, constraints
├── templates/             # Intake templates — copy, fill in, drop into a workflow's intake/
├── workflows/
│   ├── idea-validation/   # Evaluate business/product ideas
│   │   ├── intake/        # Filled-in intake docs
│   │   └── runs/          # Timestamped output folders
│   ├── monetization/      # Financial/pricing/revenue modeling
│   │   ├── intake/
│   │   └── runs/
│   └── data-analysis/     # Analyze data and produce insights
│       ├── intake/
│       └── runs/
└── .claude/
    └── commands/          # Custom slash commands that trigger workflows
```

## How to Use

**Start here:** Run `/start`. Claude will walk you through everything — filling in assumptions, picking a workflow, building the intake through conversation, and running the analysis. No manual file editing required.

**Direct access** (if assumptions are already filled):
- `/idea-validation` — evaluate a product/business idea
- `/monetization` — build pricing and revenue models
- `/data-analysis` — analyze data to answer a specific question
- `/pm-status` — dashboard of recent activity across all workflows

All three workflow commands support conversational intake — just run the command and describe what you need. Claude will ask follow-up questions and generate the intake doc for you.

**Manual intake** (optional): Copy a template from `templates/` into the workflow's `intake/` folder, fill it in, then run the slash command. Claude will pick up the existing intake file automatically.

## Output Locations

Each run produces a timestamped folder:
`workflows/<workflow>/runs/YYYY-MM-DD-<slug>/`

## Instructions for Claude

- **Tone**: Direct, analytical, no filler. Write like a senior PM talking to other PMs.
- **Gaps**: If the intake or assumptions are missing critical information, flag it explicitly. Do not guess or fabricate data. State what is missing and what impact the gap has on the analysis.
- **Assumptions files**: Always read every file in `assumptions/` before producing output. These are the PM's source of truth.
- **Intake files**: Use the most recently modified file in the workflow's `intake/` folder.
- **Output**: All output files use markdown. Use tables, bullet points, and headers for scannability. No walls of text.
- **References**: When a conclusion depends on an assumption from `assumptions/`, cite which file and section it comes from.
- **Prior runs**: If the intake references a prior run's output, read those files too.

## Tips

- Keep `assumptions/` current. Claude is only as good as the source of truth.
- Link runs together by referencing prior output file paths in your next intake.
- Intake docs are disposable. Write them fast, let the workflow do the heavy lifting.
