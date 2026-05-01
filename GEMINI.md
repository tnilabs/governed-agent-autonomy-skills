# GEMINI.md

`governed-agent-autonomy-skills` is a self-contained skills plugin for cross-tool coding agents. It enforces GAAM-style discipline (assess / design / implement / review) for enterprise agents.

## Entrypoint

Start at `skills/gaam/SKILL.md`. It is the gateway; it routes to one of four sibling skills based on intent.

## Canon

All canonical GAAM/control/pattern/synonym-map material lives in `references/*.md`. The plugin does not depend on any external repo and does not fetch from the network.

- `references/gaam-levels.md` — the 10 GAAM levels with intent and exit criteria.
- `references/controls.md` — 10 control categories with the canonical activation matrix.
- `references/patterns.md` — GAAM capability patterns per level (functional signature + controls activated + test asserts, including L1/L2 substrate patterns).
- `references/synonyms.md` — synonym, conceptual-equivalence, and detection-signal guide for every control and every pattern entry.

For any target or claimed level, apply levels L1 through that level inclusive. Controls are active when their `Activated at GAAM levels` line contains the target level; patterns are active when introduced in any included level section.

## Conceptual-Equivalence Matching

Level descriptions, requirements, controls, and patterns are semantic anchors. Example artifact names are context cues, not required record names. A user system has the GAAM item if it has the same workflow context, authority boundary, capability, evidence semantics, failure prevention, and runtime boundary under any local name or structure, including external systems. Before a skill marks any control or pattern "missing" or "not satisfied," it must load the synonym entry, search at least four detection-signal categories including conceptual equivalents, and record the equivalence rationale. A finding without a recorded conceptual-equivalence search is invalid output.

## Self-contained

Skills do NOT chain to other plugins. Whatever discipline a skill needs (test-first, file-touch planning, review gates, verification gates) is stated inline in the skill body. The plugin works on its own and behaves the same regardless of which other plugins are installed.
