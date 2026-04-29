---
name: amm-review
description: Use when reviewing an enterprise agent change for AMM conformance, performing a pre-merge agent audit, validating an evidence pack, or checking a PR's claimed AMM level against artifacts
---

# Reviewing an Enterprise Agent

Verify AMM level claims against artifacts using synonym-guided search for controls/patterns and artifact search for pure exit criteria. Produce a structured review report.

## Inputs

Load this skill's bundled `references/` files: `amm-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the report.

## Process

1. Read the change set and any AMM-level claim in the PR description / design brief.
2. Build the checklist for L1 through the claimed level inclusive: exit criteria from `references/amm-levels.md`, controls whose `Activated at AMM levels` line includes the claimed level, and pattern entries introduced at L1 through the claimed level.
3. For each control AND each pattern entry, run a synonym-guided search of the codebase via `synonyms.md`. Record what was searched, where, and what was found.
4. For each AMM exit criterion that is not a control or pattern entry, run an artifact search for the named criterion under local names. Record terms, locations, and result.
5. Verify each integrated pattern has a passing functional-signature test (per the implement skill's rule).
6. Verify threat-model deltas, audit/observability mapping, and any evidence-pack outputs.
7. Produce the review report using the **Output template** below.

## Hard rule

Controls and pattern entries use a **recorded synonym-guided search**: load the synonym entry, search at least three detection signals, and record searches and locations. Pure AMM exit criteria use a **recorded artifact search**: search for the named exit-criterion artifact under local names, then record terms, locations, and result. A missing/not-satisfied finding without the applicable recorded search is invalid output.

## Forbidden shortcuts

- "I read the design brief, controls look fine" — verify against artifacts, not against documents.
- Marking a control "missing" because the user's naming differs from the canonical naming.

## Output template

```markdown
# AMM Review: <change identifier>

- Canon versions: amm-levels v<x>, controls v<x>, patterns v<x>, synonyms v<x>
- Claimed level: L<n>
- Verified level: L<n>
- Verdict: PASS | FAIL | NEEDS-FIX

## Control activation
| AMM canonical | User-team name | Location | Evidence | Verdict |

## Pattern integration
| Pattern entry | Functional-sig test | Verdict |

## Missing / not-satisfied findings
- <finding> — searched signals/artifacts: <list>; locations: <files>; suggested fix: <text>

## Threat-model deltas
- <new attack-surface entry / refusal added / replay tested>

## Follow-up tasks
- [ ] <action> — owner: <name>
```

## Inline review discipline

Do not declare the review complete until (a) every "missing"/"not satisfied" finding has the applicable recorded synonym-guided search or recorded artifact search, (b) every level claim has been checked against an artifact (not against a document), and (c) the canon version of every reference consulted is cited in the report.
