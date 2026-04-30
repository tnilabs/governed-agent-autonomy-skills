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
2. Treat level descriptions, requirements, controls, and record/schema names as AMM semantic anchors. Search for semantic equivalents, not literal names: same capability, evidence, failure prevented, and runtime boundary under local vocabulary, services, workflows, or external systems.
3. For each control/pattern, run a recorded conceptual-equivalence search: compare functional signature, evidence produced, failure prevented, runtime boundary, and detection signals.
4. For pure exit criteria, search for equivalent artifacts under local names (docs, configs, schemas, telemetry, tests, evidence outputs, external-store contracts).
5. Record searches, locations, found evidence, and equivalence rationale.
6. Mark each criterion `satisfied`, `partial`, `missing`, or `not_applicable`. Do not stop at the first gap; continue through L10.
7. Classify: observed level = highest L where all criteria for L1..L are satisfied. The first `partial`/`missing` item is the lowest failing boundary. Later satisfied/partial items are partial higher-level evidence, not the observed level.
8. Produce the report using the **Output template** below.

## Hard rules

- No control/pattern may be marked absent without a recorded conceptual-equivalence search: functional signature checked, at least four signal categories searched, and locations recorded.
- No pure exit criterion may be marked absent without a recorded artifact search: artifact sought, aliases checked, locations recorded, and result stated.
- Canonical control names, pattern IDs, and record/schema names are trace anchors and examples. Do not require user artifacts to use AMM strings such as approval record, credential lease, audit record, or evidence pack.
- L1-L3 are preparation evidence, not reliable runtime maturity detection. Reliable runtime assessment starts at L4, where review boundaries and control surfaces become observable. Still report L1-L3 artifacts or gaps when present.
- Self-claim is not evidence. Framework name is not evidence. Vocabulary match is not evidence. Vocabulary mismatch is not absence.

## Forbidden shortcuts

- "They use LangGraph so they're at L8" — framework ≠ exit criteria.
- "I don't see `evidence_pack`" — search via the applicable synonym-map or artifact rule first.
- "They do not have `ApprovalRecord`" — search for equivalent signed approval evidence and binding semantics first.
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
| User-team structure/name | AMM semantic anchor | Equivalent capability/evidence |
| --- | --- | --- |

## Evidence per level
### L<n> — <name>
- Requirement/control/pattern: <semantic anchor>; verdict: satisfied | partial | missing | not_applicable; searched: <list>; locations: <files>; rationale: <text>

## Lowest failing boundary
- <level/criterion> — <partial or missing reason> — <smallest fix>

## Partial higher-level evidence
- <level/item> — <evidence found> — <why it does not raise observed level>

## Semantic gaps
| AMM semantic anchor | User structure/name | Status | Conceptual-equivalence search | Verdict |
```

## Inline gate

Before declaring the assessment complete, re-check that every `partial`, `missing`, or `not satisfied` finding has the applicable recorded conceptual-equivalence or artifact search. If any is missing, re-do the search and update the report.
