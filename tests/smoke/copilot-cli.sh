#!/usr/bin/env bash
# Copilot CLI smoke (reuses the Claude marketplace format).
set -euo pipefail
if ! command -v copilot >/dev/null 2>&1 && ! gh extension list 2>/dev/null | grep -q copilot; then
  echo "copilot-cli.sh: SKIP (copilot CLI / gh-copilot ext not installed)"; exit 0
fi
fail=0
[[ -f .claude-plugin/marketplace.json ]] || { echo "copilot-cli.sh: Claude marketplace manifest missing"; fail=1; }
if [[ -f .claude-plugin/marketplace.json ]]; then
  jq empty .claude-plugin/marketplace.json || { echo "copilot-cli.sh: marketplace.json invalid JSON"; fail=1; }
fi
[[ $fail -eq 0 ]] && echo "copilot-cli.sh: OK"
exit $fail
