---
name: assessing-amm-level
description: Use when the task asks "what AMM level are we at?", to assess an existing agent system against AMM, for due-diligence reviews, audits, or maturity gap analyses
---

# Assessing AMM Level

Evidence-first classification. The lowest level whose exit criteria are unmet sets the observed level.

## Inputs

`references/amm-levels.md`, `references/controls.md`, `references/patterns.md`, `references/rosetta.md`. Load all four. Cite their `canon_version` in the report.

## Process

1. For each level L1→L10: read its exit criteria and the controls activated at that level (from the matrix in `references/controls.md`).
2. For each control AND each pattern family at the level: resolve to its functional signature via `references/rosetta.md` and search the user's codebase by detection signals (file/dir patterns, dep names, log keywords, schema fields).
3. Record every search performed (what was looked for, where, what was found) — even when the answer is "found".
4. Classify: observed level = max L such that all criteria for L1..L are satisfied.
5. Produce the report using the **Output template** below.

## Hard rules

- **No control, pattern, or AMM exit criterion may be marked absent without a recorded rosetta-driven search** (≥3 detection signals checked, locations recorded).
- Self-claim is not evidence. Framework name is not evidence. Vocabulary match is not evidence. Vocabulary mismatch is not absence.

## Forbidden shortcuts

- "They use LangGraph so they're at L8" — framework ≠ exit criteria.
- "I don't see `evidence_pack`" — search via rosetta first.
- "Codebase is too big, I'll sample" — say so in the report; don't classify on sampling alone.
- "They told me L7" — verify against artifacts.

## Output template

```markdown
# AMM Assessment

- Canon versions: amm-levels v<x>, controls v<x>, patterns v<x>, rosetta v<x>
- Claimed level: L<n> (or "unstated")
- Observed level: L<n>
- Confidence: high | medium | low (with reason)

## Terminology mapping
| User-team name | AMM canonical |
| --- | --- |

## Evidence per level
### L<n> — <name>
- Exit criterion: <text>; verdict: satisfied | partial | missing; signals searched: <list>; locations: <files>

## Blockers to next level
- <criterion> — <what's missing> — <suggested smallest fix>

## Control gaps
| Control (canonical) | User name | Status | Rosetta signals searched | Verdict |
```

## Inline gate

Before declaring the assessment complete, re-check that every "missing"/"not satisfied" finding has its searched signals + locations recorded. If any is missing, re-do the search and update the report.
