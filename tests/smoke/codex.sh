#!/usr/bin/env bash
# Codex artifact-sanity check: verifies both install paths exist and are valid.
#  - .codex/INSTALL.md: CLI/App manual symlink install
#  - .codex-plugin/plugin.json: App marketplace manifest
set -euo pipefail
if ! command -v codex >/dev/null 2>&1; then
  echo "codex.sh: SKIP (codex CLI not installed)"; exit 0
fi
fail=0
[[ -d skills ]] || { echo "codex.sh: skills/ missing"; fail=1; }
[[ -f .codex/INSTALL.md ]] || { echo "codex.sh: .codex/INSTALL.md missing"; fail=1; }
[[ -f .codex-plugin/plugin.json ]] || { echo "codex.sh: .codex-plugin/plugin.json missing"; fail=1; }
if [[ -f .codex-plugin/plugin.json ]]; then
  jq empty .codex-plugin/plugin.json || { echo "codex.sh: .codex-plugin/plugin.json invalid JSON"; fail=1; }
fi
[[ $fail -eq 0 ]] && echo "codex.sh: OK"
exit $fail
