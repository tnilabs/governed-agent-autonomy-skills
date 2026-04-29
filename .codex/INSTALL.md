# Installing agentic-maturity-model-skills for Codex CLI / App

Codex CLI and Codex App both discover skills from `$CODEX_HOME/skills` (`~/.codex/skills` by default). Clone this repo and symlink the bundled skill directories.

## Prerequisites

- Git
- Codex CLI (or Codex App on the same machine)

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.codex/agentic-maturity-model-skills
mkdir -p ~/.codex/skills
ln -s ~/.codex/agentic-maturity-model-skills/skills/* ~/.codex/skills/
```

Restart Codex CLI (and Codex App, if installed). Skills are discovered automatically through native skill-tool resolution.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git "$env:USERPROFILE\.codex\agentic-maturity-model-skills"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills"
Get-ChildItem "$env:USERPROFILE\.codex\agentic-maturity-model-skills\skills" -Directory | ForEach-Object {
  cmd /c mklink /J "$env:USERPROFILE\.codex\skills\$($_.Name)" "$($_.FullName)"
}
```

## Verify

```bash
ls -la ~/.codex/skills/amm
```

Expect a symlink (or junction on Windows) into the cloned repo's `skills/amm`. In Codex, ask: "What AMM level is this agent at?" — the gateway should announce `Using \`amm-assess\` to <purpose>` and the assess skill should load.

## Updating

```bash
cd ~/.codex/agentic-maturity-model-skills && git pull
```

Skills update through the symlinks on next Codex restart.

## Uninstalling

```bash
rm ~/.codex/skills/amm \
   ~/.codex/skills/amm-assess \
   ~/.codex/skills/amm-design \
   ~/.codex/skills/amm-implement \
   ~/.codex/skills/amm-review
```

Optionally delete the clone: `rm -rf ~/.codex/agentic-maturity-model-skills`.
