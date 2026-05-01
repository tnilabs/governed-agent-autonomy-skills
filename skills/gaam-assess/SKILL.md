---
name: gaam-assess
description: Use when assessing an existing AI agent or agent workflow, asking what maturity or governance level it has, checking production readiness, due-diligence reviews, audits, or maturity gap analyses
---

# Assessing GAAM Level

Evidence-first full-spectrum L1-L10 scan. A GAAM level is a workflow-scoped authority claim, not a repository label. The observed level is the highest fully satisfied prefix before the lowest failing boundary; the report still records partial higher-level evidence after that boundary.

## Inputs

Load this skill's bundled `references/` files: `gaam-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the report.

## Process

1. Identify the GAAM claim context: workflow, scope, period, allowed/excluded authority, owner, evidence records, and reassessment triggers. If unstated, infer cautiously and mark gaps.
2. For every level L1→L10, read exit criteria, activated controls, and pattern entries.
3. Treat level descriptions, requirements, controls, pattern IDs, and example artifact names as context cues. Search semantic equivalents, not literal names: same workflow context, authority boundary, capability, evidence semantics, failure prevented, and runtime boundary.
4. For each control/pattern, run a recorded conceptual-equivalence search: compare functional signature, context, authority, evidence, failure, boundary, and detection signals.
5. For pure exit criteria, search equivalent artifacts under local names (docs, configs, schemas, telemetry, tests, evidence outputs, external-store contracts). Record searches, locations, evidence, and rationale.
6. Mark each criterion `satisfied`, `partial`, `missing`, or `not_applicable`. Continue through L10.
7. Classify: observed level = highest L where all criteria for L1..L are satisfied. The first `partial`/`missing` item is the lowest failing boundary. Later satisfied/partial items are partial higher-level evidence, not the observed level.

## Hard rules

- No control/pattern may be marked absent without a recorded conceptual-equivalence search: functional signature checked, at least four signal categories searched, and locations recorded.
- No pure exit criterion may be marked absent without a recorded artifact search: artifact sought, aliases checked, locations recorded, and result stated.
- Load all four bundled refs before classification. Citing a reference as not loaded is invalid output; load it or mark the assessment incomplete.
- Canonical control names and pattern IDs are trace anchors. Example artifact names are non-normative context cues; GAAM does not require specific record names.
- L1-L3 are preparation evidence, not reliable runtime maturity detection. Reliable runtime assessment starts at L4, where review boundaries and control surfaces become observable. Report L1-L3 artifacts or gaps.
- Self-claim is not evidence. Framework name is not evidence. Vocabulary match is not evidence. Vocabulary mismatch is not absence.

## Forbidden shortcuts

- "They use LangGraph so they're at L8" — framework ≠ exit criteria.
- "I don't see `evidence_pack`" — search via the applicable synonym-map or artifact rule first.
- "They do not use the expected approval record name" — search for equivalent approval evidence and exact-action binding first.
- "Codebase is too big, I'll sample" — say so in the report; don't classify on sampling alone.
- "They told me L7" — verify against artifacts.

## Output template

```markdown
# GAAM Assessment

- Canon versions: gaam-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n> (or "unstated")
- Observed level: L<n>
- Claim context: workflow=<x>; scope=<x>; period=<x>; allowed/excluded authority=<x>; owner=<x>
- Assessment band note: L1-L3 are preparation evidence; reliable runtime assessment starts at L4.
- Confidence: high | medium | low (with reason)

## Terminology and conceptual mapping
| User-team structure/name | GAAM semantic anchor | Equivalent capability/evidence |
| --- | --- | --- |

## Evidence per level
### L<n> — <name>
- Requirement/control/pattern: <semantic anchor>; verdict: satisfied | partial | missing | not_applicable; searched: <list>; locations: <files>; rationale: <text>

## Lowest failing boundary
- <level/criterion> — <partial or missing reason> — <smallest fix>

## Partial higher-level evidence
- <level/item> — <evidence found> — <why it does not raise observed level>

## Semantic gaps
| GAAM semantic anchor | User structure/name | Status | Conceptual-equivalence search | Verdict |
```

## Inline gate

Before declaring the assessment complete, re-check that every `partial`, `missing`, or `not satisfied` finding has the applicable recorded conceptual-equivalence or artifact search. If any is missing, re-do the search and update the report.
