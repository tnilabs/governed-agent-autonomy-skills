#!/usr/bin/env bash
# Validate the exact set of skills, their frontmatter shape, word budgets,
# conceptual-equivalence and semantic-anchor sentinels, and forbid external
# plugin chains in skill bodies.
set -euo pipefail
fail=0

GATE_BUDGET=200
SIB_BUDGET=500
ASSESS_BUDGET=650
EXPECTED_SET="amm amm-assess amm-design amm-implement amm-review"
SYNONYM_SENTINEL="recorded conceptual-equivalence search"
SEMANTIC_SENTINEL="semantic equivalents, not literal names"
ASSESS_SEMANTIC_SCOPE="level descriptions, requirements, controls, and record/schema names"
ASSESS_REF_LOAD_SENTINEL="Citing a reference as not loaded is invalid output"

if [[ ! -d skills ]]; then echo "skills/ missing"; exit 1; fi

# Skill-set assertion: directories under skills/ must equal EXPECTED_SET.
# Use a portable find form (no GNU -printf).
actual=$(find skills -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | xargs)
expected=$(printf '%s\n' $EXPECTED_SET | sort | xargs)
if [[ "$actual" != "$expected" ]]; then
  echo "SKILL SET MISMATCH"
  echo "  expected: $expected"
  echo "  actual:   $actual"
  fail=1
fi

shopt -s nullglob
for d in skills/*/; do
  name=$(basename "$d")
  f="$d/SKILL.md"
  if [[ ! -f "$f" ]]; then echo "MISSING: $f"; fail=1; continue; fi

  # Frontmatter (between first two --- lines)
  fm=$(awk 'BEGIN{c=0} /^---$/{c++; next} c==1{print}' "$f")
  fmlen=$(printf '%s' "$fm" | wc -c)
  if [[ $fmlen -gt 1024 ]]; then echo "FRONTMATTER >1024 chars: $f ($fmlen)"; fail=1; fi

  fm_name=$(printf '%s\n' "$fm" | awk -F': *' '/^name:/{print $2; exit}')
  fm_desc=$(printf '%s\n' "$fm" | awk '/^description:/{sub(/^description: */,""); print; exit}')

  if [[ "$fm_name" != "$name" ]]; then
    echo "NAME MISMATCH: $f frontmatter name='$fm_name' dir='$name'"; fail=1
  fi
  if [[ "$fm_desc" != "Use when"* ]]; then
    echo "DESC NOT 'Use when...': $f"; fail=1
  fi

  # No-workflow-summary check on description: forbid common workflow patterns.
  if printf '%s' "$fm_desc" | grep -qiE 'process:|step [0-9]|→|first.*then|then[[:space:]]+|first[[:space:]]+(write|run|do)'; then
    echo "DESC CONTAINS WORKFLOW SUMMARY: $f"; fail=1
  fi

  # Body word count (after second ---)
  body=$(awk 'BEGIN{c=0} /^---$/{c++; next} c>=2{print}' "$f")
  words=$(printf '%s' "$body" | wc -w)
  budget=$SIB_BUDGET
  [[ "$name" == "amm" ]] && budget=$GATE_BUDGET
  [[ "$name" == "amm-assess" ]] && budget=$ASSESS_BUDGET
  if [[ $words -gt $budget ]]; then
    echo "WORD COUNT $words > $budget: $f"; fail=1
  fi

  # Sentinel check: assess + review skills must contain the conceptual-equivalence hard rule.
  if [[ "$name" == "amm-assess" || "$name" == "amm-review" ]]; then
    if ! grep -qF "$SYNONYM_SENTINEL" "$f"; then
      echo "SENTINEL MISSING ('$SYNONYM_SENTINEL') in $f"; fail=1
    fi
  fi

  # Focused skills must treat AMM names as trace anchors, not strings the
  # user's repo must literally contain.
  if [[ "$name" != "amm" ]]; then
    if ! grep -qF "$SEMANTIC_SENTINEL" "$f"; then
      echo "SEMANTIC SENTINEL MISSING ('$SEMANTIC_SENTINEL') in $f"; fail=1
    fi
  fi

  if [[ "$name" == "amm-assess" ]]; then
    for required in "full-spectrum L1-L10 scan" "partial higher-level evidence" "lowest failing boundary" "$ASSESS_SEMANTIC_SCOPE" "$ASSESS_REF_LOAD_SENTINEL"; do
      if ! grep -qF "$required" "$f"; then
        echo "ASSESS CONTRACT MISSING ('$required') in $f"; fail=1
      fi
    done
  fi

  # Extract just the body for plugin-chain checks.
  body_only=$(awk 'BEGIN{c=0} /^---$/{c++; next} c>=2{print}' "$f")

  # No qualified plugin chains in skill bodies (catches superpowers:tdd,
  # @org/plugin:x, agentic-maturity-model-skills:assess, etc.)
  if printf '%s' "$body_only" | grep -qE '(^|[[:space:]])(@[a-z0-9_-]+/)?[a-z][a-z0-9-]*:[a-z][a-z0-9-]*'; then
    echo "QUALIFIED PLUGIN CHAIN in $f body (skills must use bare skill names)"
    fail=1
  fi

  # Plain plugin-name reference: line containing /Superpowers/i AND /skill/i.
  if printf '%s\n' "$body_only" | grep -niE '(^|[[:space:]])superpowers\b' | grep -qiE 'skill'; then
    echo "PLAIN PLUGIN-NAME REFERENCE in $f body (Superpowers + 'skill' mentioned together)"
    fail=1
  fi
done

[[ $fail -eq 0 ]] && echo "skills.test.sh: OK"
exit $fail
