#!/usr/bin/env bash
# Validate every plugin manifest is parseable JSON, has required fields,
# and that every path declared by a manifest exists on disk.
set -euo pipefail
fail=0

require_field() {
  local f="$1"; local p="$2"
  if ! jq -e ".${p}" "$f" >/dev/null 2>&1; then
    echo "MISSING FIELD .$p in $f"; fail=1
  fi
}

check_json_parse() {
  local f="$1"
  if [[ ! -f "$f" ]]; then echo "MISSING: $f"; fail=1; return 1; fi
  if ! jq empty "$f" 2>/dev/null; then echo "INVALID JSON: $f"; fail=1; return 1; fi
  return 0
}

# .claude-plugin/plugin.json
if check_json_parse .claude-plugin/plugin.json; then
  for p in name description version; do require_field .claude-plugin/plugin.json "$p"; done
fi

# .claude-plugin/marketplace.json
if check_json_parse .claude-plugin/marketplace.json; then
  for p in name plugins; do require_field .claude-plugin/marketplace.json "$p"; done
fi

# .codex-plugin/plugin.json — top-level + interface block
if check_json_parse .codex-plugin/plugin.json; then
  for p in name version description skills; do require_field .codex-plugin/plugin.json "$p"; done
  for p in 'interface.displayName' 'interface.shortDescription' 'interface.longDescription' \
           'interface.developerName' 'interface.category' 'interface.capabilities' \
           'interface.defaultPrompt' 'interface.brandColor'; do
    require_field .codex-plugin/plugin.json "$p"
  done
  for cap in Interactive Read Write; do
    if ! jq -e --arg c "$cap" '.interface.capabilities | index($c)' .codex-plugin/plugin.json >/dev/null 2>&1; then
      echo ".codex-plugin/plugin.json interface.capabilities missing '$cap'"; fail=1
    fi
  done
fi

# .cursor-plugin/plugin.json — has skills, must NOT have agents/commands/hooks (v0 ships skills only).
if check_json_parse .cursor-plugin/plugin.json; then
  for p in name version skills; do require_field .cursor-plugin/plugin.json "$p"; done
  for forbidden in agents commands hooks; do
    if jq -e --arg k "$forbidden" 'has($k)' .cursor-plugin/plugin.json | grep -q true; then
      echo ".cursor-plugin/plugin.json must NOT have '$forbidden' for v0 (skills only)"; fail=1
    fi
  done
fi

# gemini-extension.json — contextFileName must be exactly GEMINI.md
if check_json_parse gemini-extension.json; then
  for p in name description version contextFileName; do require_field gemini-extension.json "$p"; done
  if [[ "$(jq -r .contextFileName gemini-extension.json)" != "GEMINI.md" ]]; then
    echo "gemini-extension.json .contextFileName must be \"GEMINI.md\""; fail=1
  fi
fi

# package.json — must be ESM and point main at the OpenCode plugin
if check_json_parse package.json; then
  for p in name version type main; do require_field package.json "$p"; done
  if [[ "$(jq -r .type package.json)" != "module" ]]; then
    echo "package.json .type must be \"module\""; fail=1
  fi
  expected_main=".opencode/plugins/agentic-blueprints-skills.js"
  if [[ "$(jq -r .main package.json)" != "$expected_main" ]]; then
    echo "package.json .main must be \"$expected_main\""; fail=1
  fi
  if [[ ! -f "$(jq -r .main package.json)" ]]; then
    echo "package.json .main points to missing file"; fail=1
  fi
fi

# Cross-reference: every path declared by a manifest must exist on disk.
for f in .codex-plugin/plugin.json .cursor-plugin/plugin.json; do
  if [[ -f "$f" ]]; then
    sk=$(jq -r .skills "$f")
    if [[ -n "$sk" && "$sk" != "null" && ! -d "$sk" ]]; then
      echo "BROKEN REF: $f .skills -> $sk"; fail=1
    fi
  fi
done

if [[ -f .claude-plugin/marketplace.json ]]; then
  while IFS= read -r src; do
    [[ -n "$src" && "$src" != "null" ]] || continue
    if [[ ! -e "$src" ]]; then
      echo "BROKEN REF: .claude-plugin/marketplace.json plugins[].source -> $src"; fail=1
    fi
  done < <(jq -r '.plugins[].source' .claude-plugin/marketplace.json)
fi

if [[ -f gemini-extension.json ]]; then
  cfn=$(jq -r .contextFileName gemini-extension.json)
  if [[ -n "$cfn" && "$cfn" != "null" && ! -f "$cfn" ]]; then
    echo "BROKEN REF: gemini-extension.json contextFileName -> $cfn"; fail=1
  fi
fi

for f in .opencode/INSTALL.md .opencode/plugins/agentic-blueprints-skills.js; do
  if [[ ! -f "$f" ]]; then echo "MISSING OpenCode artifact: $f"; fail=1; fi
done

if [[ ! -f .codex/INSTALL.md ]]; then echo "MISSING: .codex/INSTALL.md"; fail=1; fi

[[ $fail -eq 0 ]] && echo "manifests.test.sh: OK"
exit $fail
