# PM-OPS

A lightweight PM Ops workspace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Repeatable workflows for the PM tasks you'd rather offload: idea validation, financial modeling, and data analysis.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and configured

## Quick Start

```bash
git clone https://github.com/illuminaryETH/PM-OPS.git
cd PM-OPS
```

1. **Fill in your context** — Edit the four files in `assumptions/` with your company, market, competitive, and resource info. This is the shared context every workflow reads.

2. **Create an intake** — Copy a template from `templates/` into the matching workflow's `intake/` folder:
   ```
   cp templates/idea-validation-intake.md workflows/idea-validation/intake/my-idea.md
   ```

3. **Fill in the intake** — Open the copied file and fill in the sections.

4. **Run the workflow** — Open Claude Code in the project directory and run:
   ```
   /idea-validation
   ```

5. **Get your output** — Results land in a timestamped folder:
   ```
   workflows/idea-validation/runs/2026-02-24-my-idea/
   ```

## Workflows

### `/idea-validation`
Evaluate a business or product idea. Produces a market analysis, competitive scan, risk assessment, and a GO / NO-GO / CONDITIONAL GO recommendation.

**Outputs:** `executive-summary.md`, `market-analysis.md`, `competitive-scan.md`, `risk-assessment.md`, `recommendation.md`

### `/monetization`
Build financial and pricing models. Produces scenario-based revenue projections, unit economics, pricing analysis, and specific pricing recommendations.

**Outputs:** `executive-summary.md`, `revenue-model.md`, `unit-economics.md`, `pricing-analysis.md`, `recommendation.md`

### `/data-analysis`
Analyze data to answer a specific question. Produces methodology documentation, structured findings, and actionable recommendations tied to evidence.

**Outputs:** `executive-summary.md`, `methodology.md`, `findings.md`, `recommendations.md`

### `/pm-status`
Dashboard view across all workflows. Shows recent runs, pending intakes, and flags stale assumptions. Prints to chat — no files created.

## Project Structure

```
PM-OPS/
├── assumptions/           # Shared context (fill these in first)
│   ├── company-context.md
│   ├── target-market.md
│   ├── competitive-landscape.md
│   └── constraints-and-resources.md
├── templates/             # Intake templates (copy, don't edit in place)
│   ├── idea-validation-intake.md
│   ├── monetization-intake.md
│   └── data-analysis-intake.md
├── workflows/
│   ├── idea-validation/
│   │   ├── intake/        # Drop filled-in intakes here
│   │   └── runs/          # Timestamped output folders
│   ├── monetization/
│   │   ├── intake/
│   │   └── runs/
│   └── data-analysis/
│       ├── intake/
│       └── runs/
├── .claude/
│   └── commands/          # Slash command definitions
└── CLAUDE.md              # Project instructions for Claude
```

## Tips

- **Keep assumptions fresh.** Claude is only as good as the context you give it. Update `assumptions/` whenever strategy, market, or constraints change.
- **Chain workflows together.** Reference a prior run's output path in your next intake to build on previous analysis.
- **Intakes are disposable.** Don't overthink them. Fill in what you know, flag what you don't, and let the workflow do the heavy lifting.
- **Check `/pm-status` regularly.** It'll tell you what's stale and what needs attention.

## License

MIT
