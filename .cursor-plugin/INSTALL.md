# Installing agentic-maturity-model-skills for Cursor

Cursor's `/add-plugin` requires a published marketplace. For local installs, copy or symlink the cloned repo into Cursor's per-user plugins directory.

## Prerequisites

- Cursor IDE installed
- Git

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.cursor/agentic-maturity-model-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/agentic-maturity-model-skills-src ~/.cursor/plugins/agentic-maturity-model-skills
```

Then in Cursor: Cmd+Shift+P → "Developer: Reload Window" (or quit and relaunch). Cursor reads the plugin manifest from `~/.cursor/plugins/agentic-maturity-model-skills/.cursor-plugin/plugin.json` and the bundled `skills/` directory.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git "$env:USERPROFILE\.cursor\agentic-maturity-model-skills-src"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\plugins"
cmd /c mklink /J "$env:USERPROFILE\.cursor\plugins\agentic-maturity-model-skills" "$env:USERPROFILE\.cursor\agentic-maturity-model-skills-src"
```

Reload Cursor.

## Per-project alternative

If you want the skills available only in a specific Cursor workspace (not user-wide), symlink the bundled `skills/` into the project's `.cursor/skills/` directory:

```bash
mkdir -p .cursor/skills
ln -s /path/to/agentic-maturity-model-skills/skills .cursor/skills/agentic-maturity-model-skills
```

Reload the workspace. (This path covers skills only — the full plugin manifest is not loaded.)

## Verify

In Cursor Agent chat:

> "What AMM level is this agent at?"

Expect the gateway to announce `Using \`assessing-amm-level\` to <purpose>`.

## Updating

```bash
cd ~/.cursor/agentic-maturity-model-skills-src && git pull
```

Reload Cursor.

## Uninstalling

```bash
rm ~/.cursor/plugins/agentic-maturity-model-skills
```

Optionally delete the source clone: `rm -rf ~/.cursor/agentic-maturity-model-skills-src`.
