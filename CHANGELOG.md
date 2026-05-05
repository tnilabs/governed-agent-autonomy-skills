# Changelog

All notable changes to `governed-agent-autonomy-skills` are documented here.

## v5.0.0 - 2026-05-05

### BREAKING

- Renamed the plugin manifest `name` (and Claude Code marketplace `name`) from
  `governed-agent-autonomy-skills` to `gaam` across every tool target
  (`.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`,
  `.cursor-plugin/plugin.json`, `.codex-plugin/plugin.json`,
  `gemini-extension.json`, `package.json`). The repository slug
  (`sirmarkz/governed-agent-autonomy-skills`) is unchanged; only the
  install identifier moved.
- Existing v4.x installs will not receive `update` commands keyed on the old
  name. To migrate: uninstall the old plugin, then reinstall using the
  v5.0.0 commands in `README.md`. The new Claude Code install is
  `/plugin install gaam@gaam`.
- OpenCode plugin spec entry changes from
  `"governed-agent-autonomy-skills@git+…"` to `"gaam@git+…"`.
- Bumped synchronized manifest versions to `5.0.0`.

### Why

The repeated package name made every install command unsayable in
conversation (`governed-agent-autonomy-skills@governed-agent-autonomy-skills`).
The new identifier matches the bundled skill names (`gaam`, `gaam-assess`,
`gaam-design`, `gaam-implement`, `gaam-review`) and the brand the plugin
already enforces.

## v4.5.0 - 2026-05-05

### Changed

- Bumped package and plugin manifest versions to `4.5.0`.
- Moved public ownership references, manifest metadata, install docs, and
  repository links to `sirmarkz`.

## v4.4.0 - 2026-05-01

### Changed

- Updated `gaam-assess` to ask whether to save the completed assessment report
  unless saving was already requested.
- Set `GAAM-assessment.md` as the default saved report path when the user agrees.
- Bumped plugin manifests to `4.4.0`.

## v4.3.0 - 2026-05-01

### Changed

- Bumped plugin manifests to `4.3.0` and bundled GAAM canon references to
  `3.2.0`.
- Clarified Level 2 and Level 3 foundation semantics across levels, controls,
  patterns, synonyms, and README guidance.
- Updated assessment guidance so Levels 2-3 are treated as useful foundation
  capabilities, not empty preparation.

## v4.1.0 - 2026-05-01

### Changed

- Broadened skill descriptions so hosts can select GAAM skills for AI-agent
  software work without explicit GAAM terms.
- Added README automatic-use guidance with a copy-paste project instruction
  snippet.
- Updated the Gemini entrypoint for the same AI-agent trigger boundary.

## v4.0.0 - 2026-05-01

### Changed

- Refreshed the standalone GAAM skills canon so the distribution no longer
  depends on the core GAAM repository at runtime.
- Reworked guidance around workflow context, authority boundaries, evidence
  semantics, runtime boundaries, and conceptual equivalence.
- Updated bundled references, skill-local reference copies, manifests, tests,
  docs, and the OpenCode plugin export.

## v3.0.0 - 2026-05-01

### Changed

- Published the GAAM skills canon and moved the package forward from the earlier
  AMM naming line.

## v2.x - 2026-04-29 to 2026-04-30

### Changed

- Finalized the earlier AMM skill surface, bundled local reference copies for
  installed-plugin sandboxes, and strengthened conceptual-equivalence matching.
- Added semantic-anchor behavior for maturity levels, controls, patterns, and
  record shapes.
- Clarified contribution guidance, validation expectations, and setup docs for
  the pre-GAAM release line.
