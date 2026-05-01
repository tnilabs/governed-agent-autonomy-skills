---
name: gaam-design
description: Use when the task is to design a new enterprise agent, scope an AI agent product to a GAAM target level, or turn an idea into a control-aware agent specification
---

# Designing an Enterprise Agent

Turn an idea into a workflow-scoped GAAM design brief. The brief states the target authority, excluded authority, active controls, evidence, and production boundaries.

## Inputs

Load this skill's bundled `references/` files: `gaam-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the brief.

## Process

1. Clarify workflow, scope, target GAAM level (L1-L10), allowed/excluded authority, owner, and acceptable risk. If the target level is unstated, ask before writing.
2. From `references/patterns.md`, list every pattern entry introduced at L1 through the target level inclusive (match `### L<n>-` headings).
3. From `references/controls.md`, list every control whose `Activated at GAAM levels` line includes the target level.
4. Treat level requirements, controls, pattern IDs, and example artifact names as context cues. Design semantic equivalents, not literal names: same workflow context, authority boundary, capability, evidence semantics, runtime boundary, and prevented failure under the team's vocabulary.
5. For each control, capture the GAAM anchor plus the user-team's preferred capability/evidence name. The brief speaks the team's language while remaining GAAM-traceable. Downstream review/assess depend on this map.
6. Produce the brief using the **Output template** below.

## Hard rules

- Target-level claim must come with the matching control activations and exit-criteria evidence in the brief — not vibes.
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
local_artifacts: [<team schemas/events/services/evidence stores>]
controls:
  - gaam_anchor: <Threat & Adversarial Resilience | ...>
    local_name: <team's preferred capability/evidence name>
    introduced_at: L<n>
    active_for_target: true
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

When intent is fuzzy, ask the user one focused question before producing the brief (target level / scenario boundary / acceptable risk). Never ship a brief built on assumptions you didn't surface.
