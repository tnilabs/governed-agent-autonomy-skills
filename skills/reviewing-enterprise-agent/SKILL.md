---
name: reviewing-enterprise-agent
description: Use when reviewing an enterprise agent change for AMM conformance, performing a pre-merge agent audit, validating an evidence pack, or checking a PR's claimed AMM level against artifacts
---

# Reviewing an Enterprise Agent

Verify AMM level claims against artifacts using rosetta-driven search for controls/patterns and artifact search for pure exit criteria. Produce a structured review report.

## Inputs

`references/amm-levels.md`, `references/controls.md`, `references/patterns.md`, `references/rosetta.md`. Cite their `canon_version` in the report.

## Process

1. Read the change set and any AMM-level claim in the PR description / design brief.
2. Pull the level's exit criteria from `references/amm-levels.md`, the required controls from `references/controls.md`, and the required pattern families from `references/patterns.md`.
3. For each control AND each pattern family, run a rosetta-driven search of the codebase via `references/rosetta.md`. Record what was searched, where, and what was found.
4. For each AMM exit criterion that is not a control or pattern family, run an artifact search for the named criterion under local names. Record terms, locations, and result.
5. Verify each integrated pattern has a passing functional-signature test (per the implement skill's rule).
6. Verify threat-model deltas, audit/observability mapping, and any evidence-pack outputs.
7. Produce the review report using the **Output template** below.

## Hard rule

Controls and pattern families use a **recorded rosetta-driven search**: load the rosetta entry, search at least three detection signals, and record searches and locations. Pure AMM exit criteria use a **recorded artifact search**: search for the named exit-criterion artifact under local names, then record terms, locations, and result. A missing/not-satisfied finding without the applicable recorded search is invalid output.

## Forbidden shortcuts

- "I read the design brief, controls look fine" — verify against artifacts, not against documents.
- Marking a control "missing" because the user's naming differs from the canonical naming.

## Output template

```markdown
# AMM Review: <change identifier>

- Canon versions: amm-levels v<x>, controls v<x>, patterns v<x>, rosetta v<x>
- Claimed level: L<n>
- Verified level: L<n>
- Verdict: PASS | FAIL | NEEDS-FIX

## Control activation
| AMM canonical | User-team name | Location | Evidence | Verdict |

## Pattern integration
| Pattern family | Functional-sig test | Verdict |

## Missing / not-satisfied findings
- <finding> — searched signals/artifacts: <list>; locations: <files>; suggested fix: <text>

## Threat-model deltas
- <new attack-surface entry / refusal added / replay tested>

## Follow-up tasks
- [ ] <action> — owner: <name>
```

## Inline review discipline

Do not declare the review complete until (a) every "missing"/"not satisfied" finding has the applicable recorded rosetta-driven search or recorded artifact search, (b) every level claim has been checked against an artifact (not against a document), and (c) the canon version of every reference consulted is cited in the report.
