# Installing agentic-maturity-model-skills for Codex CLI / App

Codex CLI and Codex App both discover skills from `~/.agents/skills/`. Clone this repo and symlink the bundled `skills/` directory.

## Prerequisites

- Git
- Codex CLI (or Codex App on the same machine)

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.codex/agentic-maturity-model-skills
mkdir -p ~/.agents/skills
ln -s ~/.codex/agentic-maturity-model-skills/skills ~/.agents/skills/agentic-maturity-model-skills
```

Restart Codex CLI (and Codex App, if installed). Skills are discovered automatically through native skill-tool resolution.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git "$env:USERPROFILE\.codex\agentic-maturity-model-skills"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\agentic-maturity-model-skills" "$env:USERPROFILE\.codex\agentic-maturity-model-skills\skills"
```

## Verify

```bash
ls -la ~/.agents/skills/agentic-maturity-model-skills
```

Expect a symlink (or junction on Windows) into the cloned repo's `skills/`. In Codex, ask: "What AMM level is this agent at?" — the gateway should announce `Using \`assessing-amm-level\` to <purpose>` and the assess skill should load.

## Updating

```bash
cd ~/.codex/agentic-maturity-model-skills && git pull
```

Skills update through the symlink on next Codex restart.

## Uninstalling

```bash
rm ~/.agents/skills/agentic-maturity-model-skills
```

Optionally delete the clone: `rm -rf ~/.codex/agentic-maturity-model-skills`.
