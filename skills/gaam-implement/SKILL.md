---
name: gaam-implement
description: Use when the task is to apply a GAAM pattern entry to a codebase, implement a GAAM-level capability such as L5 scoped read access or L6 approved writes, or refactor existing code to satisfy GAAM exit criteria
---

# Implementing GAAM Patterns

Integrate GAAM pattern entries into the *existing* user system, under the team's existing names. Land the functional-signature test before code.

## Inputs

Load this skill's bundled `references/` files: `patterns.md`, `controls.md`, `synonyms.md`. Cite their `canon_version` in the implementation plan.

## Process

1. Locate the pattern entry in `references/patterns.md`. Note its functional signature, the controls it activates, and the test that asserts the signature.
2. Survey the user's codebase via `synonyms.md`. Search semantic equivalents, not literal names: local code may satisfy GAAM via different services, schemas, events, workflows, or external stores. Record what you found and where.
3. If equivalent exists: integrate / strengthen it under the existing names. Do not rename or duplicate.
4. If not: design the smallest addition that satisfies the functional signature; integrate at the natural seam in the existing architecture.
5. Write the functional-signature test first. Run it; it should fail. Implement minimally to pass. Add edge-case tests.
6. Use the **Output template** as the work record. If the user requested implementation, make the edits and run tests before final; do not stop at a plan.

## Hard rules

- Every pattern integration lands a test that asserts the functional signature *before* code lands.
- Do not rename existing user systems to match canonical GAAM terminology, and do not add GAAM example record names just for naming parity. Adapt and record the mapping. The team owns the vocabulary.
- When the pattern requires a contract change (schema field, header, log shape), update consumers and bump the contract version in the same change.

## Output template

````markdown
# Implementation Record: <pattern entry>

- Pattern entry: <pattern-id from references/patterns.md>
- Canon versions: patterns v<x>, synonyms v<x>, controls v<x>
- User-team mapping: <local structure/name> ↔ <GAAM semantic anchor>

## Existing capability survey (conceptual-equivalence)
| Detection signal | Searched in | Found / not found |

## File touch list
- <repo-relative path>: <what changes>

## Functional-signature test (lands first)
```<lang>
<test code asserting capability + evidence>
```

## Implementation steps
1. <step> — files: <list>
2. ...

## Contract changes
| Schema/header/log | Field | Old | New | Consumers updated |
````

## Inline TDD discipline

Write the functional-signature test first; run it; confirm it fails; write the smallest code that makes it pass; refactor while green. For multi-file changes, write the file-touch list and per-step commit boundaries before editing anything.
