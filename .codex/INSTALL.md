# Installing governed-agent-autonomy-skills for Codex CLI / App

Codex CLI and Codex App both discover skills from `$CODEX_HOME/skills` (`~/.codex/skills` by default). Clone this repo and symlink the bundled skill directories.

## Prerequisites

- Git
- Codex CLI (or Codex App on the same machine)

## Installation (Linux / macOS)

```bash
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git ~/.codex/governed-agent-autonomy-skills
mkdir -p ~/.codex/skills
ln -s ~/.codex/governed-agent-autonomy-skills/skills/* ~/.codex/skills/
```

Restart Codex CLI (and Codex App, if installed). Skills are discovered automatically through native skill-tool resolution.

## Installation (Windows PowerShell)

```powershell
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git "$env:USERPROFILE\.codex\governed-agent-autonomy-skills"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills"
Get-ChildItem "$env:USERPROFILE\.codex\governed-agent-autonomy-skills\skills" -Directory | ForEach-Object {
  cmd /c mklink /J "$env:USERPROFILE\.codex\skills\$($_.Name)" "$($_.FullName)"
}
```

## Verify

```bash
ls -la ~/.codex/skills/gaam
```

Expect a symlink (or junction on Windows) into the cloned repo's `skills/gaam`. In Codex, ask: "What GAAM level is this agent at?" — the gateway should announce `Using \`gaam-assess\` to <purpose>` and the assess skill should load.

## Updating

```bash
cd ~/.codex/governed-agent-autonomy-skills && git pull
```

Skills update through the symlinks on next Codex restart.

## Uninstalling

```bash
rm ~/.codex/skills/gaam \
   ~/.codex/skills/gaam-assess \
   ~/.codex/skills/gaam-design \
   ~/.codex/skills/gaam-implement \
   ~/.codex/skills/gaam-review
```

Optionally delete the clone: `rm -rf ~/.codex/governed-agent-autonomy-skills`.
