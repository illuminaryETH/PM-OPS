# PM-OPS

A lightweight PM Ops workspace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Repeatable workflows for the PM tasks you'd rather offload: idea validation, financial modeling, and data analysis.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and configured

## Quick Start

```bash
git clone https://github.com/illuminaryETH/PM-OPS.git
cd PM-OPS
```

Open Claude Code in the project directory and run:

```
/start
```

Claude will walk you through:
1. **Setting up context** — Fill in your company, market, competitive, and resource info through conversation
2. **Picking a workflow** — Idea validation, monetization modeling, or data analysis
3. **Building the intake** — Describe what you need; Claude asks follow-ups and generates the intake doc
4. **Getting output** — Results land in a timestamped folder under `workflows/<workflow>/runs/`

**Already set up?** Jump directly to a workflow:
```
/idea-validation
/monetization
/data-analysis
```

All three support conversational intake — no manual file editing needed.

## Workflows

### `/start`
Guided setup and workflow runner. Walks you through filling assumptions, choosing a workflow, and running it — all conversationally. Best entry point for first-time use.

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
