#!/usr/bin/env bash
# Enforce the no-external-dependency stance: no skill, reference, README,
# context file, install doc, or script instructs the agent to fetch from
# an external repo or URL beyond a small allowlist of documented install
# and update commands.
set -euo pipefail
fail=0

# Stage 1: tokens that are never acceptable, anywhere.
HARD_FORBIDDEN_RE='WebFetch|web_fetch|(^|[[:space:]])curl([[:space:]]|$)|(^|[[:space:]])wget([[:space:]]|$)|gh[[:space:]]+repo[[:space:]]+clone|gh[[:space:]]+api([[:space:]]|$)|raw\.githubusercontent\.com'

# Stage 2: external URLs and any `git` fetch verb. Allowlisted only for
# documented install/update instructions.
URL_OR_GIT_FETCH_RE='https?://[^[:space:]]+|(^|[[:space:]])git[[:space:]]+(clone|pull|fetch|submodule)([[:space:]]|$)'

ALLOWLIST_PATTERNS=(
  '^[[:space:]]*git[[:space:]]+clone[[:space:]]+https://github\.com/tnilabs/agentic-maturity-model-skills\.git[[:space:]]+~/\.(codex|cursor)/'
  'git[[:space:]]+clone[[:space:]]+https://github\.com/tnilabs/agentic-maturity-model-skills\.git[[:space:]]+"\$env'
  '^[[:space:]]*cd[[:space:]]+~/\.(codex|cursor)/agentic-maturity-model-skills(-src)?[[:space:]]*&&[[:space:]]*git[[:space:]]+pull([[:space:]]|$)'
  '^[[:space:]]*gemini[[:space:]]+extensions[[:space:]]+install[[:space:]]+https://github\.com/tnilabs/agentic-maturity-model-skills([[:space:]]|$)'
  '^[[:space:]]*"agentic-maturity-model-skills@git\+https://github\.com/tnilabs/agentic-maturity-model-skills\.git'
  '^[[:space:]]*https://github\.com/tnilabs/agentic-maturity-model-skills([./#v0-9]*)?[[:space:]]*$'
  '\]\(https://github\.com/tnilabs/agentic-maturity-model-skills'
  '\]\(https://github\.com/tnilabs/agentic-maturity-model\)'
  '\[OpenCode\.ai\]\(https://opencode\.ai\)'
  '\]\(https://(opencode\.ai|cursor\.com|github\.com/openai/codex|google\.github\.io/adk-docs)'
)

is_allowed() {
  local line="$1"
  local pat
  for pat in "${ALLOWLIST_PATTERNS[@]}"; do
    if printf '%s' "$line" | grep -qE "$pat"; then return 0; fi
  done
  return 1
}

scan_file() {
  local f="$1"
  [[ -f "$f" ]] || return 0
  local n=0
  while IFS= read -r line; do
    n=$((n+1))
    if printf '%s' "$line" | grep -qE "$HARD_FORBIDDEN_RE"; then
      echo "HARD-FORBIDDEN in $f:$n: $line"; fail=1; continue
    fi
    if printf '%s' "$line" | grep -qE "$URL_OR_GIT_FETCH_RE"; then
      if ! is_allowed "$line"; then
        echo "EXTERNAL URL/GIT-FETCH not allowlisted in $f:$n: $line"; fail=1
      fi
    fi
  done < "$f"
}

scan_dir() {
  local d="$1"
  [[ -d "$d" ]] || return 0
  while IFS= read -r f; do scan_file "$f"; done < <(find "$d" -type f \( -name '*.md' -o -name '*.sh' -o -name '*.js' -o -name '*.json' \))
}

scan_dir skills
scan_dir references
scan_dir scripts
scan_file CLAUDE.md
scan_file AGENTS.md
scan_file GEMINI.md
scan_file README.md
scan_file .codex/INSTALL.md
scan_file .cursor-plugin/INSTALL.md
scan_file .opencode/INSTALL.md
scan_file .opencode/plugins/agentic-maturity-model-skills.js

[[ $fail -eq 0 ]] && echo "no-external-fetch.test.sh: OK"
exit $fail
