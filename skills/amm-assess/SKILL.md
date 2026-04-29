---
name: amm-assess
description: Use when the task asks "what AMM level are we at?", to assess an existing agent system against AMM, for due-diligence reviews, audits, or maturity gap analyses
---

# Assessing AMM Level

Evidence-first full-spectrum L1-L10 scan. The observed level is the highest fully satisfied prefix before the lowest failing boundary. The report still records partial higher-level evidence found after that boundary.

## Inputs

Load this skill's bundled `references/` files: `amm-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the report.

## Process

1. For every level L1→L10, read exit criteria, activated controls, and pattern entries.
2. For each control/pattern, run a recorded conceptual-equivalence search: compare functional signature, evidence produced, failure prevented, runtime boundary, and detection signals. Different names, files, services, or structures can satisfy the AMM item if they carry the same meaning.
3. For pure exit criteria, search for equivalent artifacts under local names (docs, configs, schemas, telemetry, tests, evidence outputs, external-store contracts).
4. Record searches, locations, found evidence, and equivalence rationale.
5. Mark each criterion `satisfied`, `partial`, `missing`, or `not_applicable`. Do not stop at the first gap; continue through L10.
6. Classify: observed level = highest L where all criteria for L1..L are satisfied. The first `partial`/`missing` item is the lowest failing boundary. Later satisfied/partial items are partial higher-level evidence, not the observed level.
7. Produce the report using the **Output template** below.

## Hard rules

- No control/pattern may be marked absent without a recorded conceptual-equivalence search: functional signature checked, at least four signal categories searched, and locations recorded.
- No pure exit criterion may be marked absent without a recorded artifact search: artifact sought, aliases checked, locations recorded, and result stated.
- L1-L3 are preparation evidence, not reliable runtime maturity detection. Reliable runtime assessment starts at L4, where review boundaries and control surfaces become observable. Still report L1-L3 artifacts or gaps when present.
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
- Assessment band note: L1-L3 are preparation evidence; reliable runtime assessment starts at L4.
- Confidence: high | medium | low (with reason)

## Terminology and conceptual mapping
| User-team structure/name | AMM canonical item | Equivalence reason |
| --- | --- |

## Evidence per level
### L<n> — <name>
- Criterion/control/pattern: <text>; verdict: satisfied | partial | missing | not_applicable; searched: <list>; locations: <files>; rationale: <text>

## Lowest failing boundary
- <level/criterion> — <partial or missing reason> — <smallest fix>

## Partial higher-level evidence
- <level/item> — <evidence found> — <why it does not raise observed level>

## Control gaps
| Control (canonical) | User structure/name | Status | Conceptual-equivalence search | Verdict |
```

## Inline gate

Before declaring the assessment complete, re-check that every `partial`, `missing`, or `not satisfied` finding has the applicable recorded conceptual-equivalence or artifact search. If any is missing, re-do the search and update the report.
