# Installing agentic-maturity-model-skills for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed.

## Installation

Add to the `plugin` array in your `opencode.json` (global or project-level):

```json
{
  "plugin": [
    "agentic-maturity-model-skills@git+https://github.com/tnilabs/agentic-maturity-model-skills.git"
  ]
}
```

Restart OpenCode. The plugin auto-installs and registers all skills.

Verify with: "Use the skill tool to list skills" — you should see `agentic-maturity-model-skills/using-agentic-maturity-model` and four siblings.

## Pinning a version

```json
{
  "plugin": [
    "agentic-maturity-model-skills@git+https://github.com/tnilabs/agentic-maturity-model-skills.git#v2.0.0"
  ]
}
```

## Usage

Use OpenCode's native `skill` tool:

```
use skill tool to load agentic-maturity-model-skills/using-agentic-maturity-model
```

## Updating

OpenCode pulls the configured plugin source on restart. To pin a specific version, change the `#vX.Y.Z` suffix in `opencode.json` and restart.

## Troubleshooting

- **Plugin not loading:** `opencode run --print-logs "hello" 2>&1 | grep -i agentic-maturity`
- **Skills not found:** use the `skill` tool to list discovered skills.

## Manual fallback if the `config` hook isn't called by your OpenCode build

A small set of OpenCode builds may not honor the plugin `config` hook at startup. If `use skill tool to list skills` does not show `agentic-maturity-model-skills/using-agentic-maturity-model` after a clean restart, add the `skills.paths` entry yourself in `opencode.json` (alongside the `plugin` array):

```json
{
  "plugin": [
    "agentic-maturity-model-skills@git+https://github.com/tnilabs/agentic-maturity-model-skills.git"
  ],
  "skills": {
    "paths": [
      "<absolute-path-to-cloned-repo>/skills"
    ]
  }
}
```

Replace `<absolute-path-to-cloned-repo>` with where OpenCode placed the plugin clone (typically inside its plugin cache). Restart OpenCode. The manual `skills.paths` entry registers the bundled skills directory directly, bypassing any hook-loading issue.
