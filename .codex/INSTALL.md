# Installing agentic-blueprints-skills for Codex CLI / App

Codex CLI and Codex App both discover skills from `~/.agents/skills/`. Clone this repo and symlink the bundled `skills/` directory.

## Prerequisites

- Git
- Codex CLI (or Codex App on the same machine)

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/agentic-blueprints-skills.git ~/.codex/agentic-blueprints-skills
mkdir -p ~/.agents/skills
ln -s ~/.codex/agentic-blueprints-skills/skills ~/.agents/skills/agentic-blueprints-skills
```

Restart Codex CLI (and Codex App, if installed). Skills are discovered automatically through native skill-tool resolution.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/agentic-blueprints-skills.git "$env:USERPROFILE\.codex\agentic-blueprints-skills"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\agentic-blueprints-skills" "$env:USERPROFILE\.codex\agentic-blueprints-skills\skills"
```

## Verify

```bash
ls -la ~/.agents/skills/agentic-blueprints-skills
```

Expect a symlink (or junction on Windows) into the cloned repo's `skills/`. In Codex, ask: "What AMM level is this agent at?" — the gateway should announce `Using \`assessing-amm-level\` to <purpose>` and the assess skill should load.

## Updating

```bash
cd ~/.codex/agentic-blueprints-skills && git pull
```

Skills update through the symlink on next Codex restart.

## Uninstalling

```bash
rm ~/.agents/skills/agentic-blueprints-skills
```

Optionally delete the clone: `rm -rf ~/.codex/agentic-blueprints-skills`.
