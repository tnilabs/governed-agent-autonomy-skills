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
2. Determine actual authority first. Live reads imply at least L5; durable side effects at least L6; queue/task ownership at least L7; agent handoffs at least L8; action without routine approval at least L9; production behavior proposals/promotions at least L10.
3. Build the checklist for L1 through the higher of claimed or reclassified level: exit criteria, activated controls, pattern entries, authority gates, scale gates, and maturity-depth backlog.
4. For each control AND pattern, run a conceptual-equivalence search via `synonyms.md`: compare functional signature, workflow context, authority boundary, evidence semantics, failure, runtime boundary, and detection signals. Search semantic equivalents, not literal names. Record searches, findings, and rationale.
5. For pure exit criteria, run artifact search. Verify functional tests, threat model, telemetry, and evidence.
6. Produce the review report using the **Output template** below.

## Hard rule

Controls and patterns require a **recorded conceptual-equivalence search**: load the synonym entry, search at least four signal categories, compare context and function, and record locations. Pure GAAM exit criteria require a **recorded artifact search** under local names. Canonical control names and pattern IDs are trace anchors. Example artifact names are context cues, not required records. A missing/not-satisfied finding without the applicable recorded search is invalid output.

Authority-gate gaps fail the claim. Scale-gate gaps block broader rollout or promotion. Maturity-depth gaps are backlog. A pilot is a narrower claim, not fewer controls.

## Forbidden shortcuts

- Do not pass controls from docs alone; verify artifacts.
- Do not mark controls or records missing before checking equivalent local names, events, schemas, logs, tickets, or external systems.

## Output template

```markdown
# GAAM Review: <change identifier>

- Canon versions: gaam-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n>
- Authority reclassification: none | actual authority implies at least L<n> because <reason>
- Verified level: L<n>
- Claim context: workflow=<x>; scope=<x>; period=<x>; allowed/excluded authority=<x>; owner=<x>
- Verdict: PASS | FAIL | NEEDS-FIX

## Control activation
| GAAM semantic anchor | User structure/name | Location | Evidence | Equivalence rationale | Verdict |

## Pattern integration
| Pattern entry | Functional-sig test | Verdict |

## Missing / not-satisfied findings
- <finding> — searched signals/artifacts: <list>; locations: <files>; equivalence rationale: <text>; suggested fix: <text>

## Priority findings
- Authority gates blocking the claim: <items>
- Scale gates blocking rollout/promotion: <items>
- Maturity-depth backlog: <items>

## Threat-model deltas
- <new attack-surface entry / refusal added / replay tested>

## Follow-up tasks
- [ ] <action> — owner: <name>
```

## Inline review discipline

Do not declare complete until findings have recorded searches, claims are artifact-checked, and consulted canon versions are cited.
