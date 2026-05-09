---
name: gaam-design
description: Use when designing a new AI agent, agent workflow, tool-calling workflow, retrieval workflow, delegated-action capability, approval-gated automation, enterprise agent, or control-aware agent specification
---

# Designing an Enterprise Agent

Produce a workflow-scoped GAAM design brief covering target/excluded authority, controls, evidence, and production boundaries.

## Inputs

Load bundled `references/` files: `gaam-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the brief.

## Process

1. Clarify workflow, scope, target GAAM level (L0-L7), allowed/excluded authority, owner, and acceptable risk. If the target level is unstated, ask before writing.
2. Check actual authority against the reclassification rule: production drafts or recommendations for human review imply at least L1; live reads at least L2; durable side effects at least L3; task ownership at least L4; agent handoffs at least L5; action without routine per-action approval at least L6; production behavior proposals at least L7. Surface target/authority conflicts before designing.
3. From `references/patterns.md`, list every pattern entry introduced at L0 through the target level inclusive (match `### L<n>-` headings).
4. From `references/controls.md`, list every control whose `Activated at GAAM levels` line includes the target level, separating authority gates, scale gates, and maturity-depth backlog.
5. Treat level requirements, controls, pattern IDs, and example artifact names as context cues. Design semantic equivalents, not literal names: same workflow context, authority boundary, capability, evidence semantics, runtime boundary, and prevented failure under the team's vocabulary.
6. For each control, capture the GAAM anchor plus the user-team's preferred capability/evidence name. The brief stays team-native and GAAM-traceable.

## Hard rules

- Target-level claim must come with the matching control activations and exit-criteria evidence in the brief — not vibes.
- A pilot is narrower scope, not fewer controls. Authority gates cannot be deferred for a production claim.
- The brief must include a terminology map. Do not force GAAM example artifact names into the design; GAAM does not require specific record names.

## Forbidden shortcuts

- "We'll add controls later" — controls are part of the level claim, not a phase 2.
- Picking patterns by buzzword instead of by exit criteria.

## Output template (`gaam-agent.yaml`-shaped)

```yaml
gaam:
  target_level: L<n>
  canon_versions: { gaam_levels: <x>, controls: <x>, patterns: <x>, synonyms: <x> }
claim:
  workflow: <workflow>
  scope: <covered users/work items/environments>
  allowed_authority: <what the agent may read/draft/prepare/act on>
  excluded_authority: <what it may not do>
  owner: <team/person>
  reassessment_triggers: [<events/cadence>]
authority_reclassification: none | target must be L<n> because <actual authority>
local_artifacts: [<team schemas/events/services/evidence stores>]
controls:
  - gaam_anchor: <Threat & Adversarial Resilience | ...>
    local_name: <team's preferred capability/evidence name>
    introduced_at: L<n>
    active_for_target: true
    priority: blocks_claim | blocks_scale_out | improve_next
    evidence: <what this control will produce>
patterns:
  - level: L<n introduced>
    pattern: <pattern entry from references/patterns.md>
    functional_signature: <capability — evidence — failure-prevented>
    test_asserts: <what the test will check>
semantic_mapping:
  - gaam_anchor: <record/control/requirement shape>
    local_shape: <team schema/event/workflow/external system>
threat_model: [<assumption / new attack-surface entry>]
evidence_pack: [<artifact required at exit>]
exit_criteria: [<measurable check>]
out_of_scope: [<thing this brief does NOT cover>]
```

## Inline scope-clarification

When intent is fuzzy, ask the user one question before producing the brief (target level / scenario boundary / acceptable risk). Never ship a brief on unsurfaced assumptions.
