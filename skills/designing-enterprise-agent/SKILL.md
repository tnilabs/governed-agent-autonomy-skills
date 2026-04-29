---
name: designing-enterprise-agent
description: Use when the task is to design a new enterprise agent, scope an AI agent product to an AMM target level, or turn an idea into a control-aware agent specification
---

# Designing an Enterprise Agent

Turn an idea into an AMM-scoped design brief. The brief commits to a target level and lists the controls + patterns + evidence that level demands.

## Inputs

`references/amm-levels.md`, `references/controls.md`, `references/patterns.md`, `references/rosetta.md`. Cite their `canon_version` in the brief.

## Process

1. Clarify the target AMM level (1–10). Risk appetite drives this; use `references/amm-levels.md` to explain trade-offs.
2. From `references/patterns.md`, list pattern families required at the target level.
3. From `references/controls.md`, list controls that must be activated at the target level (use the activation matrix).
4. For each control, capture both the AMM canonical name and the user-team's preferred name. The brief speaks the team's language while remaining AMM-traceable. Downstream review/assess depend on this map.
5. Produce the brief using the **Output template** below.

## Hard rules

- Target-level claim must come with the matching control activations and exit-criteria evidence in the brief — not vibes.
- The brief must include a terminology map.

## Forbidden shortcuts

- "We'll add controls later" — controls are part of the level claim, not a phase 2.
- Picking patterns by buzzword instead of by exit criteria.

## Output template (`amm-agent.yaml`-shaped)

```yaml
amm:
  target_level: L<n>
  canon_versions: { amm_levels: <x>, controls: <x>, patterns: <x>, rosetta: <x> }
scenario: <one-sentence problem>
schemas: [<schema names>]
controls:
  - canonical: <Adversarial Awareness | …>
    user_name: <team's preferred name>
    activates_at: L<n>
    evidence: <what this control will produce>
patterns:
  - level: L<n>
    family: <pattern family from references/patterns.md>
    functional_signature: <capability — evidence — failure-prevented>
    test_asserts: <what the test will check>
threat_model: [<assumption / new attack-surface entry>]
evidence_pack: [<artifact required at exit>]
exit_criteria: [<measurable check>]
out_of_scope: [<thing this brief does NOT cover>]
```

## Inline scope-clarification

When intent is fuzzy, ask the user one focused question before producing the brief (target level / scenario boundary / acceptable risk). Never ship a brief built on assumptions you didn't surface.
