# Installing agentic-blueprints-skills for Cursor

Cursor's `/add-plugin` requires a published marketplace. For local installs, copy or symlink the cloned repo into Cursor's per-user plugins directory.

## Prerequisites

- Cursor IDE installed
- Git

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/agentic-blueprints-skills.git ~/.cursor/agentic-blueprints-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/agentic-blueprints-skills-src ~/.cursor/plugins/agentic-blueprints-skills
```

Then in Cursor: Cmd+Shift+P → "Developer: Reload Window" (or quit and relaunch). Cursor reads the plugin manifest from `~/.cursor/plugins/agentic-blueprints-skills/.cursor-plugin/plugin.json` and the bundled `skills/` directory.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/agentic-blueprints-skills.git "$env:USERPROFILE\.cursor\agentic-blueprints-skills-src"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\plugins"
cmd /c mklink /J "$env:USERPROFILE\.cursor\plugins\agentic-blueprints-skills" "$env:USERPROFILE\.cursor\agentic-blueprints-skills-src"
```

Reload Cursor.

## Per-project alternative

If you want the skills available only in a specific Cursor workspace (not user-wide), symlink the bundled `skills/` into the project's `.cursor/skills/` directory:

```bash
mkdir -p .cursor/skills
ln -s /path/to/agentic-blueprints-skills/skills .cursor/skills/agentic-blueprints-skills
```

Reload the workspace. (This path covers skills only — the full plugin manifest is not loaded.)

## Verify

In Cursor Agent chat:

> "What AMM level is this agent at?"

Expect the gateway to announce `Using \`assessing-amm-level\` to <purpose>`.

## Updating

```bash
cd ~/.cursor/agentic-blueprints-skills-src && git pull
```

Reload Cursor.

## Uninstalling

```bash
rm ~/.cursor/plugins/agentic-blueprints-skills
```

Optionally delete the source clone: `rm -rf ~/.cursor/agentic-blueprints-skills-src`.
