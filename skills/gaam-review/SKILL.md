---
name: gaam-review
description: Use when reviewing an AI-agent change, tool or retrieval workflow, delegated-action workflow, approval-gated automation, enterprise agent PR, evidence pack, pre-merge agent audit, or claimed GAAM level against artifacts
---

# Reviewing an Enterprise Agent

Verify workflow-scoped GAAM claims against artifacts using conceptual-equivalence search for controls/patterns and artifact search for exit criteria.

## Inputs

Load this skill's bundled `references/` files: `gaam-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the report.

## Process

1. Read the change set and GAAM claim: workflow, scope, period, allowed/excluded authority, controls, evidence, owner, and reassessment triggers.
2. Build the checklist for L1 through the claimed level inclusive: exit criteria from `references/gaam-levels.md`, controls whose `Activated at GAAM levels` line includes the claimed level, and pattern entries introduced at L1 through the claimed level.
3. For each control AND pattern, run a conceptual-equivalence search via `synonyms.md`: compare functional signature, workflow context, authority boundary, evidence semantics, failure, runtime boundary, and detection signals. Search semantic equivalents, not literal names. Record searches, findings, and rationale.
4. For each GAAM exit criterion that is not a control or pattern entry, run an artifact search for the named criterion under local names. Record terms, locations, and result.
5. Verify each integrated pattern has a passing functional-signature test (per the implement skill's rule).
6. Verify threat-model deltas, audit/observability mapping, and any evidence-pack outputs.
7. Produce the review report using the **Output template** below.

## Hard rule

Controls and patterns require a **recorded conceptual-equivalence search**: load the synonym entry, search at least four signal categories, compare context and function, and record locations. Pure GAAM exit criteria require a **recorded artifact search** under local names. Canonical control names and pattern IDs are trace anchors. Example artifact names are context cues, not required records. A missing/not-satisfied finding without the applicable recorded search is invalid output.

## Forbidden shortcuts

- "I read the design brief, controls look fine" — verify against artifacts, not against documents.
- Marking a control "missing" because the user's naming or file structure differs from the canonical naming.
- Marking a record "missing" before checking whether an equivalent event, schema, log, ticket, or external system carries the same evidence.

## Output template

```markdown
# GAAM Review: <change identifier>

- Canon versions: gaam-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n>
- Verified level: L<n>
- Claim context: workflow=<x>; scope=<x>; period=<x>; allowed/excluded authority=<x>; owner=<x>
- Verdict: PASS | FAIL | NEEDS-FIX

## Control activation
| GAAM semantic anchor | User structure/name | Location | Evidence | Equivalence rationale | Verdict |

## Pattern integration
| Pattern entry | Functional-sig test | Verdict |

## Missing / not-satisfied findings
- <finding> — searched signals/artifacts: <list>; locations: <files>; equivalence rationale: <text>; suggested fix: <text>

## Threat-model deltas
- <new attack-surface entry / refusal added / replay tested>

## Follow-up tasks
- [ ] <action> — owner: <name>
```

## Inline review discipline

Do not declare the review complete until (a) every "missing"/"not satisfied" finding has the applicable recorded conceptual-equivalence search or recorded artifact search, (b) every level claim has been checked against an artifact (not against a document), and (c) the canon version of every reference consulted is cited in the report.
