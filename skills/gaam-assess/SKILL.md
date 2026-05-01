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
2. Determine actual authority first. If the system reads live production systems, prepares durable side effects, owns queue work, coordinates agents, acts without per-action approval, or proposes production changes, record the minimum candidate level before assessing the claim.
3. For every level L1→L10, read exit criteria, activated controls, patterns, and priority rules. Separate authority gates from scale gates and maturity-depth backlog.
4. Treat level descriptions, requirements, controls, pattern IDs, and example artifact names as context cues. Search semantic equivalents, not literal names: same workflow context, authority boundary, capability, evidence semantics, failure prevented, and runtime boundary.
5. For each control/pattern, run a recorded conceptual-equivalence search: compare functional signature, context, authority, evidence, failure, boundary, and detection signals.
6. For pure exit criteria, run artifact search under local names and record locations.
7. Classify: observed level = highest fully satisfied prefix. Authority-gate gaps fail the claim; scale-gate gaps block rollout/promotion. Later evidence is partial higher-level evidence, not observed level.
8. After reporting, ask whether to save it unless saving was already requested. If yes, write the exact report to the chosen path, defaulting to `GAAM-assessment.md`.

## Hard rules

- No control/pattern may be marked absent without a recorded conceptual-equivalence search: functional signature checked, at least four signal categories searched, and locations recorded.
- No pure exit criterion may be marked absent without a recorded artifact search: artifact sought, aliases checked, locations recorded, and result stated.
- Load all four bundled refs before classification. Citing a reference as not loaded is invalid output; load it or mark the assessment incomplete.
- Canonical control names and pattern IDs are trace anchors. Example artifact names are non-normative context cues; GAAM does not require specific record names.
- L1-L3 are foundation evidence. L2 may include AI-assisted process review, and L3 may include governed retrieval, but reliable production-assistant runtime assessment starts at L4. Report L1-L3 artifacts, useful capabilities, and gaps.
- Self-claim, framework name, and vocabulary match are not evidence. Vocabulary mismatch is not absence.
- A pilot is a narrower claim, not fewer controls. P0-style authority-gate gaps are not waived for production GAAM claims.

## Forbidden shortcuts

- Framework, expected record names, sampling, and self-claims do not establish level. Verify artifacts.

## Output template

```markdown
# GAAM Assessment

- Canon versions: gaam-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n> (or "unstated")
- Authority reclassification: none | actual authority implies at least L<n> because <reason>
- Observed level: L<n>
- Claim context: workflow=<x>; scope=<x>; period=<x>; allowed/excluded authority=<x>; owner=<x>
- Confidence: high | medium | low (with reason)

## Terminology and conceptual mapping
| User-team structure/name | GAAM semantic anchor | Equivalent capability/evidence |
| --- | --- | --- |

## Evidence per level
### L<n> — <name>
- <requirement/control/pattern>: <verdict>; searched=<signals/artifacts>; locations=<files>; rationale=<text>

## Lowest failing boundary
- <level/criterion> — <partial or missing reason> — <smallest fix>

## Priority findings
- Authority gates blocking the claim: <items>
- Scale gates blocking rollout/promotion: <items>
- Maturity-depth backlog: <items>

## Partial higher-level evidence
- <level/item> — <evidence found> — <why it does not raise observed level>

## Semantic gaps
| GAAM semantic anchor | User structure/name | Status | Conceptual-equivalence search | Verdict |
```

## Inline gate

Before declaring complete, re-check every `partial`, `missing`, or `not satisfied` finding has the applicable recorded conceptual-equivalence or artifact search.
