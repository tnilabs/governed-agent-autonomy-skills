# GEMINI.md

`agentic-maturity-model-skills` is a self-contained skills plugin for cross-tool coding agents. It enforces AMM-style discipline (assess / design / implement / review) for enterprise agents.

## Entrypoint

Start at `skills/amm/SKILL.md`. It is the gateway; it routes to one of four sibling skills based on intent.

## Canon

All canonical AMM/control/pattern/synonym-map material lives in `references/*.md`. The plugin does not depend on any external repo and does not fetch from the network.

- `references/amm-levels.md` — the 10 AMM levels with intent and exit criteria.
- `references/controls.md` — 9 control categories with the canonical activation matrix.
- `references/patterns.md` — source-aligned pattern entries per AMM level (functional signature + controls activated + test asserts for every source pattern ID, including L1/L2 substrate patterns).
- `references/synonyms.md` — synonym and detection-signal guide for every control and every pattern entry.

For any target or claimed level, apply levels L1 through that level inclusive. Controls are active when their `Activated at AMM levels` line contains the target level; patterns are active when introduced in any included level section.

## Synonym-aware matching (the rule that keeps reviews honest)

Controls and patterns are functional categories, not names. A user system has the control if it has the capability and the evidence the capability produces — under any name. Before a skill marks any control or pattern "missing" or "not satisfied," it must (a) load the synonym entry for the concept (`references/synonyms.md`), (b) search the codebase for at least three of that entry's detection signals, and (c) record those searches in the report. A finding without a recorded synonym-guided search is invalid output.

## Self-contained

Skills do NOT chain to other plugins. Whatever discipline a skill needs (test-first, file-touch planning, review gates, verification gates) is stated inline in the skill body. The plugin works on its own and behaves the same regardless of which other plugins are installed.
