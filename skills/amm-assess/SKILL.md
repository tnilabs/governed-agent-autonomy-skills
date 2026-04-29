---
name: amm-assess
description: Use when the task asks "what AMM level are we at?", to assess an existing agent system against AMM, for due-diligence reviews, audits, or maturity gap analyses
---

# Assessing AMM Level

Evidence-first classification. The lowest level whose exit criteria are unmet sets the observed level.

## Inputs

Load all four shared reference files from the plugin root's `references/` directory (`../../references/` from this file in the source tree): `amm-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the report.

## Process

1. For each level L1→L10: read its exit criteria and the controls activated at that level (from the matrix in `references/controls.md`).
2. For each control AND each pattern entry at the level: resolve to its functional signature via `synonyms.md` and search the user's codebase by detection signals (file/dir patterns, dep names, log keywords, schema fields).
3. For each AMM exit criterion that is not a control or pattern entry: search for the named artifact under any local name (docs, configs, tests, schemas, telemetry, evidence outputs).
4. Record every search performed (what was looked for, where, what was found) — even when the answer is "found".
5. Classify: observed level = max L such that all criteria for L1..L are satisfied.
6. Produce the report using the **Output template** below.

## Hard rules

- **No control or pattern may be marked absent without a recorded synonym-guided search** (≥3 detection signals checked, locations recorded).
- **No pure AMM exit criterion may be marked absent without a recorded artifact search** (artifact sought, aliases checked, locations and result recorded).
- Self-claim is not evidence. Framework name is not evidence. Vocabulary match is not evidence. Vocabulary mismatch is not absence.

## Forbidden shortcuts

- "They use LangGraph so they're at L8" — framework ≠ exit criteria.
- "I don't see `evidence_pack`" — search via the applicable synonym-map or artifact rule first.
- "Codebase is too big, I'll sample" — say so in the report; don't classify on sampling alone.
- "They told me L7" — verify against artifacts.

## Output template

```markdown
# AMM Assessment

- Canon versions: amm-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n> (or "unstated")
- Observed level: L<n>
- Confidence: high | medium | low (with reason)

## Terminology mapping
| User-team name | AMM canonical |
| --- | --- |

## Evidence per level
### L<n> — <name>
- Exit criterion: <text>; verdict: satisfied | partial | missing; signals/artifacts searched: <list>; locations: <files>

## Blockers to next level
- <criterion> — <what's missing> — <suggested smallest fix>

## Control gaps
| Control (canonical) | User name | Status | Synonym signals searched | Verdict |
```

## Inline gate

Before declaring the assessment complete, re-check that every "missing"/"not satisfied" finding has the applicable recorded synonym-guided search or recorded artifact search. If any is missing, re-do the search and update the report.
