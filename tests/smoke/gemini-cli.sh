#!/usr/bin/env bash
set -euo pipefail
if ! command -v gemini >/dev/null 2>&1; then
  echo "gemini-cli.sh: SKIP (gemini CLI not installed)"; exit 0
fi
fail=0
[[ -f gemini-extension.json ]] || { echo "gemini-cli.sh: gemini-extension.json missing"; fail=1; }
[[ -f GEMINI.md ]] || { echo "gemini-cli.sh: GEMINI.md missing"; fail=1; }
if [[ -f gemini-extension.json ]]; then
  jq empty gemini-extension.json || { echo "gemini-cli.sh: gemini-extension.json invalid JSON"; fail=1; }
fi
[[ $fail -eq 0 ]] && echo "gemini-cli.sh: OK"
exit $fail
