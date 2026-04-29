# agentic-blueprints-skills

Coding-agent skills for AMM-style enterprise agent design, implementation, and review. Self-contained — no external dependencies.

The Agentic Maturity Model (AMM) is a 10-level capability ladder for production-grade AI agents, from unmanaged AI use (L1) to governed continuous improvement (L10). Each level adds one capability boundary; controls accumulate. This plugin packages opinionated AMM discipline as five skills so coding agents can apply it consistently across tools.

## Skills

- **`using-agentic-blueprints`** — gateway. Routes intent to one of four sibling skills.
- **`assessing-amm-level`** — classifies an existing agent's actual AMM level by evidence.
- **`designing-enterprise-agent`** — turns an idea into an AMM-scoped design brief.
- **`implementing-amm-patterns`** — integrates AMM pattern families into an existing codebase.
- **`reviewing-enterprise-agent`** — verifies AMM level claims against artifacts using rosetta-driven search.

## Install — per tool

### Claude Code (local marketplace)

```text
/plugin marketplace add ./
/plugin install agentic-blueprints-skills@agentic-blueprints-skills-dev
```

(Published-marketplace install is out of scope for v1; see "Updating / refreshing" for the release model.)

### Codex CLI / Codex App (manual symlink)

```bash
git clone https://github.com/tnilabs/agentic-blueprints-skills.git ~/.codex/agentic-blueprints-skills
mkdir -p ~/.agents/skills
ln -s ~/.codex/agentic-blueprints-skills/skills ~/.agents/skills/agentic-blueprints-skills
```

Restart Codex. Both Codex CLI and Codex App share `~/.agents/skills/` for skill discovery, so the same symlink serves both. `.codex-plugin/plugin.json` is shipped for future marketplace publishing but is not required to use Codex today. Full doc at [`.codex/INSTALL.md`](.codex/INSTALL.md).

### Cursor (manual symlink, no marketplace required)

```bash
git clone https://github.com/tnilabs/agentic-blueprints-skills.git ~/.cursor/agentic-blueprints-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/agentic-blueprints-skills-src ~/.cursor/plugins/agentic-blueprints-skills
```

Cmd+Shift+P → "Developer: Reload Window". Full doc at [`.cursor-plugin/INSTALL.md`](.cursor-plugin/INSTALL.md).

### OpenCode (`opencode.json` plugin entry)

Add to your `opencode.json` and restart:

```json
{
  "plugin": [
    "agentic-blueprints-skills@git+https://github.com/tnilabs/agentic-blueprints-skills.git"
  ]
}
```

Verify with: `use skill tool to load agentic-blueprints-skills/using-agentic-blueprints`. Full doc at [`.opencode/INSTALL.md`](.opencode/INSTALL.md).

### Gemini CLI

```bash
gemini extensions install https://github.com/tnilabs/agentic-blueprints-skills
```

### Copilot CLI (reads the Claude marketplace format)

```bash
copilot plugin marketplace add tnilabs/agentic-blueprints-skills
copilot plugin install agentic-blueprints-skills@agentic-blueprints-skills-dev
```

### Generic / manual install

Copy `skills/` into the host's user-skills directory (e.g., `~/.claude/skills/` for Claude Code, `~/.agents/skills/` for Codex personal install).

## How to use

Mention an AMM-related task — assess, design, implement, or review. The host's native skill resolution selects the gateway when the query matches; the gateway announces ``Using `<sibling-skill>` to <purpose>`` and routes to one of four siblings. The siblings consult the canon under `references/` (AMM levels, controls + activation matrix, pattern families, rosetta) and produce structured outputs (assessment report, design brief, implementation plan, review report).

## Updating / refreshing

### Author flow (releasing a new version)

1. Edit the affected `references/*.md` (bump its `canon_version` and `last_reviewed`).
2. Run `./scripts/bump-version.sh <new-version>` — bumps the plugin version uniformly across `package.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` (`plugins[].version`), `.codex-plugin/plugin.json`, `.cursor-plugin/plugin.json`, `gemini-extension.json`.
3. Run `./tests/manifests.test.sh && ./tests/skills.test.sh && ./tests/refs.test.sh && ./tests/no-external-fetch.test.sh`.
4. Run `./scripts/codex-review.sh` (review-and-fix gate) until verdict GO.
5. `git tag vX.Y.Z && git push origin main && git push origin vX.Y.Z`.

### Consumer refresh (per tool)

| Tool         | Update command                                                                                              |
|--------------|-------------------------------------------------------------------------------------------------------------|
| Claude Code  | `/plugin marketplace update agentic-blueprints-skills-dev` then `/plugin reinstall agentic-blueprints-skills` |
| Codex CLI    | `cd ~/.codex/agentic-blueprints-skills && git pull` (skills update through the symlink), then restart Codex |
| Codex App    | same as Codex CLI — `cd ~/.codex/agentic-blueprints-skills && git pull`, then restart Codex App             |
| Cursor       | `cd ~/.cursor/agentic-blueprints-skills-src && git pull`, then reload Cursor (Cmd+Shift+P → "Developer: Reload Window") |
| OpenCode     | restart OpenCode (it re-pulls the configured plugin source); to pin, change the `#vX.Y.Z` suffix in `opencode.json` and restart |
| Gemini CLI   | `gemini extensions update agentic-blueprints-skills`                                                        |
| Copilot CLI  | `copilot plugin update agentic-blueprints-skills@agentic-blueprints-skills-dev`                             |

## Contributing

See [`AGENTS.md`](AGENTS.md) for operational rules for AI coding agents working in this repo (layout, tests, version-bump policy, "Bar a change must clear" checklist).

**Non-goals.** No per-pattern skills (one skill per AMM pattern would flood discovery). No fork of any other skills library. No runtime, no CLI, no model/provider integration. No external repo dependency at build or runtime.

## Relationship to Superpowers

The packaging shape (manifest paths, frontmatter conventions) was informed by `obra/superpowers` v5.0.7 so per-tool install commands look familiar. The plugin does NOT depend on Superpowers at runtime; skills do not chain to Superpowers (or any other plugin) and behave identically with or without it installed.

## License

[CC BY 4.0](LICENSE) — © 2026 TNI Labs.
