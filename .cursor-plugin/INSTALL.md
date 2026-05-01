# Installing governed-agent-autonomy-skills for Cursor

Cursor's `/add-plugin` requires a published marketplace. For local installs, copy or symlink the cloned repo into Cursor's per-user plugins directory.

## Prerequisites

- Cursor IDE installed
- Git

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git ~/.cursor/governed-agent-autonomy-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/governed-agent-autonomy-skills-src ~/.cursor/plugins/governed-agent-autonomy-skills
```

Then in Cursor: Cmd+Shift+P → "Developer: Reload Window" (or quit and relaunch). Cursor reads the plugin manifest from `~/.cursor/plugins/governed-agent-autonomy-skills/.cursor-plugin/plugin.json` and the bundled `skills/` directory.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git "$env:USERPROFILE\.cursor\governed-agent-autonomy-skills-src"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\plugins"
cmd /c mklink /J "$env:USERPROFILE\.cursor\plugins\governed-agent-autonomy-skills" "$env:USERPROFILE\.cursor\governed-agent-autonomy-skills-src"
```

Reload Cursor.

## Per-project alternative

If you want the skills available only in a specific Cursor workspace (not user-wide), symlink the bundled `skills/` into the project's `.cursor/skills/` directory:

```bash
mkdir -p .cursor/skills
ln -s /path/to/governed-agent-autonomy-skills/skills .cursor/skills/governed-agent-autonomy-skills
```

Reload the workspace. (This path covers skills only — the full plugin manifest is not loaded.)

## Verify

In Cursor Agent chat:

> "What GAAM level is this agent at?"

Expect the gateway to announce `Using \`assessing-gaam-level\` to <purpose>`.

## Updating

```bash
cd ~/.cursor/governed-agent-autonomy-skills-src && git pull
```

Reload Cursor.

## Uninstalling

```bash
rm ~/.cursor/plugins/governed-agent-autonomy-skills
```

Optionally delete the source clone: `rm -rf ~/.cursor/governed-agent-autonomy-skills-src`.
