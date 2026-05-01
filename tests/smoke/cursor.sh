#!/usr/bin/env bash
# Cursor artifact-sanity check. Treats presence of either `cursor` binary
# or ~/.cursor/ as "Cursor is on this machine".
set -euo pipefail
if ! command -v cursor >/dev/null 2>&1 && [[ ! -d "$HOME/.cursor" ]]; then
  echo "cursor.sh: SKIP (Cursor not detected — no \`cursor\` binary, no ~/.cursor/)"; exit 0
fi
fail=0
[[ -f .cursor-plugin/plugin.json ]] || { echo "cursor.sh: .cursor-plugin/plugin.json missing"; fail=1; }
[[ -f .cursor-plugin/INSTALL.md ]] || { echo "cursor.sh: .cursor-plugin/INSTALL.md missing"; fail=1; }
[[ -f skills/gaam/SKILL.md ]] || { echo "cursor.sh: gateway SKILL.md missing"; fail=1; }
if [[ -f .cursor-plugin/plugin.json ]]; then
  jq empty .cursor-plugin/plugin.json || { echo "cursor.sh: .cursor-plugin/plugin.json invalid JSON"; fail=1; }
fi
[[ $fail -eq 0 ]] && echo "cursor.sh: OK"
exit $fail
