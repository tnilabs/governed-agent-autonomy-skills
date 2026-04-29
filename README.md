# agentic-maturity-model-skills

Cross-tool coding-agent skills for assessing, designing, implementing, and reviewing enterprise agents against AMM. Self-contained — no external dependencies.

The Agentic Maturity Model (AMM) is a 10-level capability ladder for production-grade AI agents, from unmanaged AI use (L1) to governed continuous improvement (L10). Each level adds one capability boundary; controls accumulate. For enterprises, AMM makes agent autonomy auditable: teams can prove data governance, tool scope, delegated access, approval binding, telemetry, incident response, compliance evidence, cost control, and adversarial readiness before granting more authority. This plugin packages opinionated AMM discipline as five skills so coding agents can apply it consistently across tools.

The source implementation and full blueprint catalogue live in [`tnilabs/agentic-maturity-model`](https://github.com/tnilabs/agentic-maturity-model). This plugin vendors a self-contained snapshot of that repo's AMM levels, enterprise controls, pattern entries, and rosetta recognition guidance; installed skills do not fetch from it at runtime.

## Skills

- **`using-agentic-maturity-model`** — gateway. Routes intent to one of four sibling skills.
- **`assessing-amm-level`** — classifies an existing agent's actual AMM level by evidence.
- **`designing-enterprise-agent`** — turns an idea into an AMM-scoped design brief.
- **`implementing-amm-patterns`** — integrates source-aligned AMM pattern entries into an existing codebase.
- **`reviewing-enterprise-agent`** — verifies AMM level claims against artifacts using rosetta-driven search.

## Install — per tool

### Claude Code (GitHub marketplace)

```text
/plugin marketplace add tnilabs/agentic-maturity-model-skills
/plugin install agentic-maturity-model-skills@agentic-maturity-model-skills
```

### Codex CLI / Codex App (manual symlink)

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.codex/agentic-maturity-model-skills
mkdir -p ~/.agents/skills
ln -s ~/.codex/agentic-maturity-model-skills/skills ~/.agents/skills/agentic-maturity-model-skills
```

Restart Codex. Both Codex CLI and Codex App share `~/.agents/skills/` for skill discovery, so the same symlink serves both. `.codex-plugin/plugin.json` is shipped for future marketplace publishing but is not required to use Codex today. Full doc at [`.codex/INSTALL.md`](.codex/INSTALL.md).

### Cursor (manual symlink, no marketplace required)

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.cursor/agentic-maturity-model-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/agentic-maturity-model-skills-src ~/.cursor/plugins/agentic-maturity-model-skills
```

Cmd+Shift+P → "Developer: Reload Window". Full doc at [`.cursor-plugin/INSTALL.md`](.cursor-plugin/INSTALL.md).

### OpenCode (`opencode.json` plugin entry)

Add to your `opencode.json` and restart:

```json
{
  "plugin": [
    "agentic-maturity-model-skills@git+https://github.com/tnilabs/agentic-maturity-model-skills.git"
  ]
}
```

Verify with: `use skill tool to load agentic-maturity-model-skills/using-agentic-maturity-model`. Full doc at [`.opencode/INSTALL.md`](.opencode/INSTALL.md).

### Gemini CLI

```bash
gemini extensions install https://github.com/tnilabs/agentic-maturity-model-skills
```

### Copilot CLI (reads the Claude marketplace format)

```bash
copilot plugin marketplace add tnilabs/agentic-maturity-model-skills
copilot plugin install agentic-maturity-model-skills@agentic-maturity-model-skills
```

### Generic / manual install

For hosts that expect one skill per directory, copy the five child directories under `skills/` into the host's user-skills directory:

```bash
mkdir -p ~/.claude/skills
cp -R skills/* ~/.claude/skills/
```

Use the host-specific instructions above when the tool supports plugin-level registration or a configured skills path.

## How to use

Mention an AMM-related task — assess, design, implement, or review. The host's native skill resolution selects the gateway when the query matches; the gateway announces ``Using `<sibling-skill>` to <purpose>`` and routes to one of four siblings. The siblings consult the canon under `references/` (AMM levels, source-aligned controls + activation matrix, all 35 source pattern entries, rosetta) and produce structured outputs (assessment report, design brief, implementation plan, review report).

## Updating / refreshing

### Author flow (releasing a new version)

1. Edit the affected `references/*.md` (bump its `canon_version` and `last_reviewed`).
2. Run `./scripts/bump-version.sh <new-version>` — bumps the plugin version uniformly across `package.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` (`plugins[].version`), `.codex-plugin/plugin.json`, `.cursor-plugin/plugin.json`, `gemini-extension.json`.
3. Run `./tests/manifests.test.sh && ./tests/skills.test.sh && ./tests/refs.test.sh && ./tests/no-external-fetch.test.sh`.
4. `git tag vX.Y.Z && git push origin main && git push origin vX.Y.Z`.

### Consumer refresh (per tool)

| Tool         | Update command                                                                                              |
|--------------|-------------------------------------------------------------------------------------------------------------|
| Claude Code  | `/plugin marketplace update agentic-maturity-model-skills` then `/plugin reinstall agentic-maturity-model-skills` |
| Codex CLI    | `cd ~/.codex/agentic-maturity-model-skills && git pull` (skills update through the symlink), then restart Codex |
| Codex App    | same as Codex CLI — `cd ~/.codex/agentic-maturity-model-skills && git pull`, then restart Codex App             |
| Cursor       | `cd ~/.cursor/agentic-maturity-model-skills-src && git pull`, then reload Cursor (Cmd+Shift+P → "Developer: Reload Window") |
| OpenCode     | restart OpenCode (it re-pulls the configured plugin source); to pin, change the `#vX.Y.Z` suffix in `opencode.json` and restart |
| Gemini CLI   | `gemini extensions update agentic-maturity-model-skills`                                                        |
| Copilot CLI  | `copilot plugin update agentic-maturity-model-skills@agentic-maturity-model-skills`                                 |

## Contributing

See [`AGENTS.md`](AGENTS.md) for operational rules for AI coding agents working in this repo (layout, tests, version-bump policy, "Bar a change must clear" checklist).

**Non-goals.** No per-pattern skills (one skill per AMM pattern would flood discovery). No fork of any other skills library. No runtime, no CLI, no model/provider integration. No external repo dependency at build or runtime. The shipped references are self-contained snapshots of the source AMM/control/pattern canon.

## Relationship to Superpowers

The packaging shape (manifest paths, frontmatter conventions) was informed by `obra/superpowers` v5.0.7 so per-tool install commands look familiar. The plugin does NOT depend on Superpowers at runtime; skills do not chain to Superpowers (or any other plugin) and behave identically with or without it installed.

## License

[CC BY 4.0](LICENSE) — © 2026 TNI Labs.
