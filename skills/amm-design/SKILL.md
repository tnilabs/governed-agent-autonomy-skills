---
name: amm-design
description: Use when the task is to design a new enterprise agent, scope an AI agent product to an AMM target level, or turn an idea into a control-aware agent specification
---

# Designing an Enterprise Agent

Turn an idea into an AMM-scoped design brief. The brief commits to a target level and lists the controls + patterns + evidence that level demands.

## Inputs

Load this skill's bundled `references/` files: `amm-levels.md`, `controls.md`, `patterns.md`, `synonyms.md`. Cite their `canon_version` in the brief.

## Process

1. Clarify the target AMM level (L1-L10). If unstated, ask before writing the brief.
2. From `references/patterns.md`, list every pattern entry introduced at L1 through the target level inclusive (match `### L<n>-` headings).
3. From `references/controls.md`, list every control whose `Activated at AMM levels` line includes the target level.
4. Treat level requirements, controls, pattern IDs, and record/schema names as semantic anchors. Design semantic equivalents, not literal names: same capability, evidence, runtime boundary, and prevented failure under the team's vocabulary.
5. For each control, capture the AMM anchor plus the user-team's preferred capability/evidence name. The brief speaks the team's language while remaining AMM-traceable. Downstream review/assess depend on this map.
6. Produce the brief using the **Output template** below.

## Hard rules

- Target-level claim must come with the matching control activations and exit-criteria evidence in the brief — not vibes.
- The brief must include a terminology map. Do not force AMM example record names into the design unless the team wants those names.

## Forbidden shortcuts

- "We'll add controls later" — controls are part of the level claim, not a phase 2.
- Picking patterns by buzzword instead of by exit criteria.

## Output template (`amm-agent.yaml`-shaped)

```yaml
amm:
  target_level: L<n>
  canon_versions: { amm_levels: <x>, controls: <x>, patterns: <x>, synonyms: <x> }
scenario: <one-sentence problem>
schemas: [<schema names>]
controls:
  - amm_anchor: <Adversarial Awareness | …>
    local_name: <team's preferred capability/evidence name>
    activates_at: L<n>
    evidence: <what this control will produce>
patterns:
  - level: L<n introduced>
    pattern: <pattern entry from references/patterns.md>
    functional_signature: <capability — evidence — failure-prevented>
    test_asserts: <what the test will check>
semantic_mapping:
  - amm_anchor: <record/control/requirement shape>
    local_shape: <team schema/event/workflow/external system>
threat_model: [<assumption / new attack-surface entry>]
evidence_pack: [<artifact required at exit>]
exit_criteria: [<measurable check>]
out_of_scope: [<thing this brief does NOT cover>]
```

## Inline scope-clarification

When intent is fuzzy, ask the user one focused question before producing the brief (target level / scenario boundary / acceptable risk). Never ship a brief built on assumptions you didn't surface.
