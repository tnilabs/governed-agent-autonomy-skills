# AGENTS.md

Operational rules for AI coding agents working in this repo. No
narrative — if you need the human onboarding doc, see
[`README.md`](README.md).

## What this repo is

`governed-agent-autonomy-skills`, a self-contained, cross-tool skills plugin
for coding agents. It enforces GAAM-style discipline (assess / design /
implement / review) for enterprise agents. The plugin ships:

- five skills under `skills/` (one gateway + four sibling skills);
- four hand-authored canon references under `references/`;
- per-tool plugin manifests under `.claude-plugin/`, `.codex/`,
  `.codex-plugin/`, `.cursor-plugin/`, `.opencode/`, plus
  `gemini-extension.json`;
- helper scripts under `scripts/` and validation tests under `tests/`.

Boundary: skills distribution. Not a runtime, not a CLI, not a model
integration, not a fork of any other skills library. The plugin works on
its own and behaves the same regardless of which other plugins are
installed in the host tool.

## Layout

| Path | Owns |
| --- | --- |
| `skills/<skill-name>/SKILL.md` | One skill: frontmatter (`name`, `description`) + body. Five skills total, set is fixed. |
| `skills/<focused-skill>/references/*.md` | Skill-local copies of GAAM canon for installed-plugin sandboxes; must match root `references/*.md` byte-for-byte. |
| `references/gaam-levels.md` | Root canon of the 10 GAAM levels (one H2 per level). |
| `references/controls.md` | Root canon of the 10 enterprise control categories (canonical spelling enforced by tests). |
| `references/patterns.md` | Root source-aligned pattern index per GAAM level (one section per L1–L10; every source pattern ID has functional signature, controls activated, and test asserts). |
| `references/synonyms.md` | Root synonym, conceptual-equivalence, and detection-signal guide; one entry per control category and per pattern entry. |
| `.claude-plugin/plugin.json` + `marketplace.json` | Claude Code (and Copilot CLI) plugin + local-marketplace manifest. |
| `.codex/INSTALL.md` | Codex CLI manual install (clone + symlink skill dirs into `$CODEX_HOME/skills`). |
| `.codex-plugin/plugin.json` | Codex App marketplace manifest, with full `interface` block. |
| `.cursor-plugin/plugin.json` | Cursor plugin manifest. |
| `.opencode/INSTALL.md` + `.opencode/plugins/governed-agent-autonomy-skills.js` | OpenCode install instructions + minimal plugin (registers the bundled `skills/` via the `config` hook). |
| `gemini-extension.json` | Gemini CLI extension manifest (`contextFileName: "GEMINI.md"`). |
| `package.json` | npm metadata, ESM (`type: "module"`), `main` points at the OpenCode plugin. |
| `GEMINI.md` | Compact Gemini CLI host-context entrypoint. |
| `AGENTS.md` | This file. Operational rules for AI coding agents working in this repo. |
| `README.md` | Human install, usage, examples, and refresh guide. |
| `CONTRIBUTING.md` | Human contribution, validation, and release guide. |
| `scripts/` | `codex-review.sh` (optional local review helper), `bump-version.sh` (synchronized manifest version bumps). |
| `tests/manifests.test.sh` | JSON-validates every manifest, asserts required fields, verifies declared paths exist. |
| `tests/skills.test.sh` | Asserts the exact 5-skill set, frontmatter shape, word budgets, conceptual-equivalence sentinel in assess+review, semantic-anchor sentinel in all focused skills, no external plugin chains. |
| `tests/refs.test.sh` | Asserts ref content shape: 10 GAAM levels, 10 canonical controls, L1–L10 patterns coverage, synonym/concept cross-check against patterns.md. |
| `tests/no-external-fetch.test.sh` | Forbids fetch instructions in skills, refs, scripts, README, host-context files, install docs (allowlist for documented install URLs only). |
| `tests/smoke/<tool>.sh` | Per-tool artifact-sanity scripts. Skip-with-message when the tool isn't installed. |
| `internal/` | Gitignored. Design memos, sourcing notes, manual verification checklist, codex-review outputs. Not part of the public surface. |
| `docs/` | Gitignored. Local working notes (specs and plans live here while in flight). |

## Skills

- The set of skills under `skills/` is exactly `{gaam, gaam-assess,
  gaam-design, gaam-implement, gaam-review}`. Adding, renaming, or
  removing a skill is a deliberate scope change.
- Frontmatter has two required fields: `name` (matches the directory)
  and `description` (starts with "Use when…", trigger-only, no workflow
  summary, no first-person, no process steps). Total frontmatter ≤1024
  chars.
- Body is ≤200 words for the gateway, ≤650 words for `gaam-assess`, and
  ≤500 words for other siblings. Word count is enforced by
  `tests/skills.test.sh`.
- Skills do NOT chain to other plugins. If a skill needs TDD, file-touch
  planning, request-for-review, or verification-before-completion
  discipline, that discipline is stated inline in the skill body. No
  `superpowers:<skill-name>` references, no `<plugin>:<skill>` form
  anywhere in skill bodies.
- Inside this plugin, skills do NOT chain to each other. The gateway
  (`gaam`) announces a sibling skill in the literal
  form ``Using `<sibling-skill>` to <purpose>``; the host's native skill
  resolution loads the sibling. Use bare skill directory names in the
  gateway's routing table.
- Conceptual-equivalence matching is a hard rule for the assess and review
  skills. Their bodies MUST contain the literal sentinel
  `recorded conceptual-equivalence search`. A finding marked "missing" /
  "not satisfied" without functional-signature comparison, detection
  signals searched, and locations is invalid output.
- All focused skills MUST contain the literal sentinel
  `semantic equivalents, not literal names`. GAAM level descriptions,
  requirements, control names, pattern IDs, and record/schema names are
  semantic anchors and trace handles, not required strings in user repos.
- `gaam-assess` MUST contain the literal sentinel
  `Citing a reference as not loaded is invalid output`; classification
  requires all four bundled refs.
- Skills carry their own output templates inline (assessment report
  shape, design brief shape, implementation plan shape, review report
  shape). References hold canon; skills hold output shape.
- Focused skills bundle local copies of `references/*.md` because some
  installed-plugin hosts allow the skill body but deny reads outside the
  skill directory. Root `references/*.md` remain the canonical source;
  `tests/refs.test.sh` rejects drift between root and skill-local copies.

## References (canon)

- Every reference file's frontmatter has `canon_version:` (semver-like)
  and `last_reviewed:` (ISO date). Tests reject a missing field.
- `references/gaam-levels.md` has exactly 10 H2 sections, one per L1–L10.
- `references/controls.md` has exactly 10 H2 sections using the canonical
  spelling (no ampersands, no abbreviations): `Threat & Adversarial Resilience`,
  `Agent Registry & Lifecycle`, `Evidence & Assurance`,
  `Delegated Authority & Access`, `Data, Context & Memory Governance`,
  `Tool & Protocol Safety`, `Incident Response & Recovery`,
  `Runtime Isolation & Execution Safety`, `Observability & Telemetry`,
  `Value, Cost & Reliability`. Tests fail on any deviation.
- `references/patterns.md` has one section per GAAM level L1–L10. Every
  source GAAM pattern ID appears as a `### <pattern-id>` entry with
  `**Functional signature:**`,
  `**Controls activated:**`, and `**Test asserts:**`. L1 and L2 carry
  substrate patterns; do not reintroduce `no v0 pattern family`.
- `references/synonyms.md` has `## Conceptual Equivalence Rules`,
  `## Controls`, and `## Patterns` sections.
  It MUST state that canonical GAAM names and record/schema names are
  semantic anchors, not required strings.
  Every control (ten) and every pattern entry gets a
  `### <Canonical Name or pattern-id>` entry with `**Functional signature:**`,
  `**Alternative names:**` (≥3), and `**Detection signals:**` with at
  least four signal categories, including `Conceptual equivalents:`.
- Refs are versioned together with the plugin. Any change to a ref
  file's canon meaning bumps `canon_version` and `last_reviewed`.

## Manifests

- Each tool's manifest follows that tool's published plugin format. Do
  not invent fields; do not skip required fields.
- The Codex App manifest (`.codex-plugin/plugin.json`) MUST include the
  full `interface` block (`displayName`, `shortDescription`,
  `longDescription`, `developerName`, `category`, `capabilities`,
  `defaultPrompt`, `brandColor`). `capabilities` includes `Interactive`,
  `Read`, `Write` because the implementation skill guides write
  changes; do not under-declare.
- The Codex CLI is served by `.codex/INSTALL.md` (manual symlinks into
  `$CODEX_HOME/skills`), not by the App manifest.
- `package.json` MUST have `"type": "module"` and
  `"main": ".opencode/plugins/governed-agent-autonomy-skills.js"`. The
  OpenCode plugin file MUST export a named async plugin function
  (`AgenticMaturityModelSkillsPlugin`) returning an object with a `config`
  async hook that pushes the bundled `skills/` absolute path into
  `config.skills.paths`. No symlinks. No prompt injection. No
  system-message hook.
- Cursor manifest uses just `skills`. No `agents`/`commands`/`hooks` for
  v0 (we ship skills only).

## Self-contained — no external chains, no fetching

- This plugin has no external repository dependency. Build-time scripts
  and runtime skills both stay inside this repo.
- Skills do NOT instruct the agent to fetch from GitHub, raw content
  URLs, or any other external source. `tests/no-external-fetch.test.sh`
  greps every shipped file for fetch verbs and external URLs; only
  documented install URLs in expected install-instruction shapes pass.
- Skills do NOT chain to Superpowers or any other plugin. The plugin
  works the same with or without other plugins installed.
- The packaging shape was informed by `obra/superpowers` v5.0.7's plugin
  layout (manifest paths, frontmatter conventions). That is structural
  inspiration, not runtime dependency.

## Tests

- Static checks (`tests/manifests.test.sh`, `tests/skills.test.sh`,
  `tests/refs.test.sh`, `tests/no-external-fetch.test.sh`) run on every
  change and gate the build.
- Per-tool smoke scripts (`tests/smoke/<tool>.sh`) check artifact
  presence + manifest parse + skill-dir presence. They skip-with-message
  when the tool isn't installed locally; they exit non-zero on real
  failures. Runners must NOT use `|| true` to mask failures.
- Real install-and-trigger verification lives in
  `internal/manual-verification-checklist.md` (gitignored). The author
  ticks through every environment they have access to before declaring
  the v1 release gate complete; inaccessible environments use a
  `Deferred:` field with date + reason.
- Tests protect contracts and supported behavior. Don't add tests that
  pin static strings or test third-party library internals.
- `scripts/codex-review.sh` is an optional local review helper, not a
  required release gate.

## Documentation

- Write docs for someone who has never seen the codebase.
- README must document install for all six tool targets and the
  per-tool refresh table.
- Skill bodies do not summarize their workflow in `description:` (that
  causes Claude to follow the description instead of the body, per
  upstream skills documentation we have learned from). Triggering
  conditions only.
- Context entrypoints inline the conceptual-equivalence matching rule because
  `docs/` and `internal/` are gitignored and not shipped — do not
  reference paths users won't have.
- The default tone in skills, README, and context files is plain,
  technical, and direct. No marketing voice. No emojis unless asked.
- Commands in install instructions must be verified to work.

## Code quality

- Bash scripts use `set -euo pipefail`. Validate input. Quote variables.
  Fail fast on missing prerequisites.
- JSON manifests are minimal and conform to their tool's documented
  schema.
- The OpenCode plugin (`.opencode/plugins/governed-agent-autonomy-skills.js`)
  is ESM and stays minimal — register skills, nothing else.
- Files scoped to one responsibility; split files that start mixing
  concerns.
- Use repo-relative or environment-derived paths.

## Update / refresh policy

- Authors who change canon (any `references/<file>.md`) MUST:
  1. Bump that ref's `canon_version` and update `last_reviewed:`.
  2. Run `./scripts/bump-version.sh <new-version>` to bump the plugin
     version uniformly across `package.json`, `.claude-plugin/plugin.json`,
     `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`,
     `.cursor-plugin/plugin.json`, `gemini-extension.json`.
  3. Run `tests/*.test.sh`.
  4. Commit, tag (`git tag vX.Y.Z`), push the tag. Version-pinning users
     (notably OpenCode `#vX.Y.Z`) opt in deliberately.
- Skill or manifest changes without a canon change skip step 1; do 2–4.
- Bump policy for v1.0+:
  - Major bump (`v2.0.0+`): skill rename/removal, canonical-name
    rename/removal, manifest-shape break, ref-structure break, or other
    backwards-incompatible public behavior.
  - Minor bump: backwards-compatible canon content change (more detail,
    new alternative names, new detection signals) or additive public
    surface.
  - Patch bump: typos, clarifications, regex tightening, and other
    behavior-preserving fixes.

## General rules

- Keep `main` buildable. Every commit is public history.
- Prefer small, reviewable, production-safe changes.
- Don't commit secrets, local `.env` files, private keys,
  machine-specific config, editor state, caches, or unintended
  generated output.
- Don't commit anything under `internal/` or `docs/` — both are
  gitignored. If a change requires committing material from there,
  promote it to the public surface deliberately.
- Update README and the relevant manifests whenever install commands,
  tool-specific paths, framework-track behavior, or examples change.
- Don't add AI assistants, automation, or tools as co-authors or
  attribution in commit messages, file headers, docs, or release notes.
- Commit subjects use `type(scope): summary` (e.g.,
  `ref(controls): clarify Evidence & Assurance failure mode`,
  `skill(reviewing): tighten missing-finding rule`,
  `manifest(opencode): wire config hook to skills.paths`).

## Bar a change must clear

1. All four static tests pass:
   `./tests/manifests.test.sh && ./tests/skills.test.sh &&
   ./tests/refs.test.sh && ./tests/no-external-fetch.test.sh`.
2. Headless smoke tests (`tests/smoke/*.sh`) pass on this machine for
   every tool that is installed; absent tools cleanly skip.
3. Manual verification checklist
   (`internal/manual-verification-checklist.md`) ticked through for
   every environment the author has access to. Inaccessible
   environments use `Deferred:` with date + reason.
4. Version-bump policy followed: `canon_version` bumped on any ref
   content change; plugin `version` synchronized across all manifests
   via `scripts/bump-version.sh`; new git tag pushed if a release.
5. Doc updates: README install matrix, refresh table, and any affected
   manifest excerpts updated to match the change.
6. `git status` clean except for tracked plugin files.
