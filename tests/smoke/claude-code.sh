#!/usr/bin/env bash
# Claude Code artifact-sanity check.
# CC's plugin install is interactive; v0/v1 verifies via static check
# that the manifest is well-formed and the gateway skill is bundled.
set -euo pipefail
if ! command -v claude >/dev/null 2>&1; then
  echo "claude-code.sh: SKIP (claude CLI not installed)"
  exit 0
fi
fail=0
[[ -f .claude-plugin/marketplace.json ]] || { echo "claude-code.sh: marketplace.json missing"; fail=1; }
[[ -f .claude-plugin/plugin.json ]] || { echo "claude-code.sh: plugin.json missing"; fail=1; }
[[ -f skills/using-agentic-blueprints/SKILL.md ]] || { echo "claude-code.sh: gateway SKILL.md missing"; fail=1; }
if [[ -f .claude-plugin/plugin.json ]]; then
  jq empty .claude-plugin/plugin.json || { echo "claude-code.sh: plugin.json invalid JSON"; fail=1; }
fi
if [[ -f .claude-plugin/marketplace.json ]]; then
  jq empty .claude-plugin/marketplace.json || { echo "claude-code.sh: marketplace.json invalid JSON"; fail=1; }
fi
[[ $fail -eq 0 ]] && echo "claude-code.sh: OK (artifacts present; manual /plugin marketplace add ./ required)"
exit $fail
