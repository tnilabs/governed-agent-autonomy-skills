#!/usr/bin/env bash
# Bump the plugin version everywhere.
# Usage: scripts/bump-version.sh <new-version>
# Example: scripts/bump-version.sh 1.1.0
set -euo pipefail

new="${1:-}"
if [[ -z "$new" ]]; then
  echo "usage: $0 <new-version>"; exit 2
fi
if ! [[ "$new" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.+-]+)?$ ]]; then
  echo "version must be semver-like (e.g. 1.1.0 or 2.0.0-rc.1); got '$new'"; exit 2
fi

set_top_version() {
  local f="$1"
  [[ -f "$f" ]] || { echo "missing: $f"; return 1; }
  local tmp; tmp=$(mktemp)
  jq --arg v "$new" '.version = $v' "$f" > "$tmp"
  mv "$tmp" "$f"
  echo "  updated $f"
}

set_marketplace_plugin_version() {
  local f=".claude-plugin/marketplace.json"
  [[ -f "$f" ]] || { echo "missing: $f"; return 1; }
  local tmp; tmp=$(mktemp)
  jq --arg v "$new" '.plugins |= map(if .name == "agentic-blueprints-skills" then .version = $v else . end)' "$f" > "$tmp"
  mv "$tmp" "$f"
  echo "  updated $f (plugins[].version where name==agentic-blueprints-skills)"
}

echo "bumping plugin version → $new"
set_top_version package.json
set_top_version .claude-plugin/plugin.json
set_top_version .codex-plugin/plugin.json
set_top_version .cursor-plugin/plugin.json
set_top_version gemini-extension.json
set_marketplace_plugin_version

# Verify all six are now equal.
versions=$(
  jq -r .version package.json
  jq -r .version .claude-plugin/plugin.json
  jq -r .version .codex-plugin/plugin.json
  jq -r .version .cursor-plugin/plugin.json
  jq -r .version gemini-extension.json
  jq -r '.plugins[] | select(.name=="agentic-blueprints-skills") | .version' .claude-plugin/marketplace.json
)
uniq=$(printf '%s\n' "$versions" | sort -u | wc -l)
if [[ "$uniq" != "1" ]]; then
  echo "version mismatch after bump:"
  printf '%s\n' "$versions"
  exit 1
fi
echo "OK — every manifest is now at $new"
