#!/usr/bin/env bash
# Verify reference content shape: frontmatter, level/control coverage,
# pattern coverage, synonym entry shape, and skill→ref cross-links.
set -euo pipefail
fail=0

# Canonical control names — single source of truth for tests.
CONTROL_NAMES=(
  "Adversarial Awareness"
  "Agent Control Tower"
  "Compliance Evidence Pack"
  "Credential and Delegated Access"
  "Data Governance"
  "Protocol Conformance"
  "Incident Response"
  "OpenTelemetry Mapping"
  "Value and Cost Management"
)

# Canonical control-to-AMM-level activation matrix (v1).
declare -A EXPECTED_ACTIVATIONS=(
  ["Adversarial Awareness"]="L4 L5 L6 L7 L8 L9 L10"
  ["Agent Control Tower"]="L7 L8 L9 L10"
  ["Compliance Evidence Pack"]="L4 L5 L6 L7 L8 L9 L10"
  ["Credential and Delegated Access"]="L5 L6 L7 L8 L9 L10"
  ["Data Governance"]="L3 L4 L5 L6 L7 L8 L9 L10"
  ["Protocol Conformance"]="L5 L6 L7 L8 L9 L10"
  ["Incident Response"]="L6 L7 L8 L9 L10"
  ["OpenTelemetry Mapping"]="L4 L5 L6 L7 L8 L9 L10"
  ["Value and Cost Management"]="L4 L5 L6 L7 L8 L9 L10"
)

PATTERN_IDS=(
  "L1-baseline-failure-cataloguing"
  "L2-process-as-substrate"
  "L2-threat-model-as-substrate"
  "L3-knowledge-coverage-map"
  "L3-golden-retrieval-evals"
  "L3-provenance-attested-source"
  "L4-pending-review-boundary"
  "L4-provenance-framed-prompt-assembly"
  "L4-customer-safe-output-check"
  "L4-adversarial-input-labeling"
  "L5-typed-tool-manifest-with-scope"
  "L5-scoped-grant-per-run"
  "L5-read-tool-audit-redaction"
  "L5-mcp-conformance-derived-from-manifest"
  "L5-tool-output-sanitization"
  "L5-native-tool-conformance"
  "L6-model-recommends-runtime-assembles"
  "L6-approval-binding-hash"
  "L6-one-shot-credential-lease"
  "L6-idempotent-write-replay"
  "L6-rollback-metadata-on-every-write"
  "L6-signed-approval-record"
  "L6-customer-safety-block-gate"
  "L7-signed-goal-with-immutable-scope"
  "L7-success-criteria-predicate-registry"
  "L7-task-agent-stop-reasons"
  "L7-memory-write-validation"
  "L8-signed-a2a-card"
  "L8-validator-veto-handoff"
  "L8-durable-orchestration-state"
  "L9-policy-eligibility-gate"
  "L9-global-pause-and-dead-letter"
  "L9-continuous-adversarial-eval-corpus"
  "L10-evidence-backed-improvement-proposal"
  "L10-adversarial-release-gate"
)

# POSIX-safe separator for L<n> headings: whitespace, end-of-line, or dash.
LSEP='([[:space:]]|$|—|–|-)'

# 1. Cross-link check: every references/<file> link in skills/ resolves.
if [[ -d skills ]]; then
  while IFS= read -r line; do
    f=$(echo "$line" | awk -F: '{print $1}')
    target=$(echo "$line" | grep -oE 'references/[a-zA-Z0-9._-]+\.md' | head -1)
    if [[ -n "$target" && ! -f "$target" ]]; then
      echo "BROKEN REF in $f -> $target"; fail=1
    fi
  done < <(grep -rEHno 'references/[a-zA-Z0-9._-]+\.md' skills/ 2>/dev/null || true)
fi

# 2. Reference frontmatter check — fields must appear inside the first
#    `---`-delimited frontmatter block, not anywhere in the file body.
for f in references/amm-levels.md references/controls.md references/patterns.md references/synonyms.md; do
  if [[ ! -f "$f" ]]; then echo "MISSING: $f"; fail=1; continue; fi
  fm=$(awk 'BEGIN{c=0} /^---$/{c++; if (c==2) exit; next} c==1{print}' "$f")
  if ! printf '%s\n' "$fm" | grep -q '^canon_version:'; then
    echo "MISSING canon_version in $f frontmatter"; fail=1
  fi
  if ! printf '%s\n' "$fm" | grep -q '^last_reviewed:'; then
    echo "MISSING last_reviewed in $f frontmatter"; fail=1
  fi
done

# 2b. Focused skills carry local reference copies for installed-plugin
#     sandboxes. They must stay byte-for-byte aligned with the root canon.
for skill in amm-assess amm-design amm-implement amm-review; do
  for ref in amm-levels.md controls.md patterns.md synonyms.md; do
    copy="skills/${skill}/references/${ref}"
    root="references/${ref}"
    if [[ ! -f "$copy" ]]; then
      echo "MISSING skill-local reference: $copy"; fail=1; continue
    fi
    if ! cmp -s "$root" "$copy"; then
      echo "DRIFT: $copy differs from $root"; fail=1
    fi
  done
done

# 3. amm-levels.md: exactly 10 H2 sections matching ^## L<n>(<sep>|$).
if [[ -f references/amm-levels.md ]]; then
  count=$(grep -cE "^## L([1-9]|10)${LSEP}" references/amm-levels.md || true)
  if [[ "$count" != "10" ]]; then
    echo "amm-levels.md has $count H2 'L<n>' sections, expected 10"; fail=1
  fi
fi

# 4. controls.md: exactly 9 H2 sections, each a canonical control name,
# and each carrying an `Activated at AMM levels:` line that matches.
LEVEL_ORDER="L1 L2 L3 L4 L5 L6 L7 L8 L9 L10"
canon_sort() {
  local tokens=" $1 "
  local out=""
  for L in $LEVEL_ORDER; do
    if printf '%s' "$tokens" | grep -q " ${L} "; then out="$out${L} "; fi
  done
  printf '%s' "${out% }"
}

if [[ -f references/controls.md ]]; then
  for c in "${CONTROL_NAMES[@]}"; do
    if ! grep -qxF "## $c" references/controls.md; then
      echo "controls.md missing canonical heading: '## $c'"; fail=1; continue
    fi
    section=$(awk -v hdr="## $c" 'index($0, hdr)==1 {found=1; next} found && /^## / {exit} found {print}' references/controls.md)
    activations_line=$(printf '%s\n' "$section" | grep -E '^[*-][[:space:]]*\*\*Activated at AMM levels:?\*\*' | head -1 || true)
    if [[ -z "$activations_line" ]]; then
      echo "controls.md '$c' missing 'Activated at AMM levels:' line"; fail=1; continue
    fi
    list=$(printf '%s' "$activations_line" | sed -E 's/.*\*\*Activated at AMM levels:?\*\*[[:space:]]*//')
    actual_tokens=$(printf '%s' "$list" | tr -d ' ' | tr ',' '\n' | xargs)
    actual_levels=$(canon_sort "$actual_tokens")
    expected_levels=$(canon_sort "${EXPECTED_ACTIVATIONS["$c"]}")
    if [[ "$actual_levels" != "$expected_levels" ]]; then
      echo "controls.md '$c' Activated levels mismatch:"
      echo "  expected: $expected_levels"
      echo "  actual:   $actual_levels"
      fail=1
    fi
  done
  total=$(grep -c '^## ' references/controls.md || true)
  if [[ "$total" != "9" ]]; then
    echo "controls.md has $total H2 sections, expected exactly 9"; fail=1
  fi
fi

# 5. patterns.md: exactly 10 H2 sections, one per L1..L10. Every source
# pattern from ../agentic-maturity-model must be represented as a `###` entry with
# a functional signature, controls activated, and test asserts. L1/L2 are
# substrate patterns, not "no pattern" placeholders.
PATTERN_ENTRY_NAMES=()
if [[ -f references/patterns.md ]]; then
  pcount=$(grep -cE "^## L([1-9]|10)${LSEP}" references/patterns.md || true)
  if [[ "$pcount" != "10" ]]; then
    echo "patterns.md has $pcount H2 'L<n>' sections, expected exactly 10"; fail=1
  fi
  for n in 1 2 3 4 5 6 7 8 9 10; do
    if ! grep -qE "^## .*L${n}${LSEP}" references/patterns.md; then
      echo "patterns.md missing section for L${n}"; fail=1; continue
    fi
    body=$(awk -v n="$n" -v sep="$LSEP" '
      $0 ~ ("^## .*L" n sep) { in_sec=1; next }
      in_sec && /^## / { exit }
      in_sec { print }
    ' references/patterns.md)
    if printf '%s' "$body" | grep -qiE 'no v0 pattern family'; then
      echo "patterns.md L${n} still uses obsolete 'no v0 pattern family' placeholder"; fail=1
    fi
  done

  for pattern_id in "${PATTERN_IDS[@]}"; do
    if ! grep -qxF "### $pattern_id" references/patterns.md; then
      echo "patterns.md missing source pattern entry: '### $pattern_id'"; fail=1; continue
    fi
    body=$(awk -v hdr="### $pattern_id" 'index($0, hdr)==1 {found=1; next} found && /^### / {exit} found && /^## / {exit} found {print}' references/patterns.md)
    for label in "Functional signature" "Controls activated" "Test asserts"; do
      if ! printf '%s\n' "$body" | grep -qE "^[*-][[:space:]]*\\*\\*${label}:?\\*\\*"; then
        echo "patterns.md '$pattern_id' missing '**${label}:**' line"; fail=1
      fi
    done
    controls_line=$(printf '%s\n' "$body" | sed -nE 's/^[*-][[:space:]]*\*\*Controls activated:?\*\*[[:space:]]*//p' | head -1)
    if [[ -n "$controls_line" ]]; then
      IFS=',' read -ra activated <<< "$controls_line"
      for c in "${activated[@]}"; do
        name=$(printf '%s' "$c" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')
        [[ -z "$name" || "$name" == "None" ]] && continue
        ok=0
        for canon in "${CONTROL_NAMES[@]}"; do
          if [[ "$name" == "$canon" ]]; then ok=1; break; fi
        done
        if [[ "$ok" != "1" ]]; then
          echo "patterns.md '$pattern_id' **Controls activated:** has non-canonical name '$name'"; fail=1
        fi
      done
    fi
    PATTERN_ENTRY_NAMES+=("$pattern_id")
  done
fi

# 6. synonyms.md: ## Controls + ## Patterns; every control covered;
# every pattern entry from patterns.md covered; every entry has
# Functional signature, >=3 alt names, >=4 detection-signal categories,
# including conceptual-equivalence guidance.
if [[ -f references/synonyms.md ]]; then
  for s in Controls Patterns; do
    if ! grep -q "^## $s$" references/synonyms.md; then
      echo "synonyms.md missing top-level section '## $s'"; fail=1
    fi
  done
  if ! grep -q '^## Conceptual Equivalence Rules$' references/synonyms.md; then
    echo "synonyms.md missing '## Conceptual Equivalence Rules'"; fail=1
  fi
  if ! grep -qF 'Canonical AMM names and record/schema names are semantic anchors, not required strings.' references/synonyms.md; then
    echo "synonyms.md missing semantic-anchor rule"; fail=1
  fi
  for c in "${CONTROL_NAMES[@]}"; do
    if ! grep -qxF "### $c" references/synonyms.md; then
      echo "synonyms.md missing entry: '### $c'"; fail=1
    fi
  done
  for fam in "${PATTERN_ENTRY_NAMES[@]}"; do
    if ! grep -qxF "### $fam" references/synonyms.md; then
      echo "synonyms.md missing pattern entry for '$fam'"; fail=1
    fi
  done
  awk '
    function flush() {
      if (entry == "") return
      if (!has_sig) { printf("synonyms.md entry \"%s\" missing **Functional signature:**\n", entry); bad=1 }
      if (alts < 3) { printf("synonyms.md entry \"%s\" has alt count %d (need >=3)\n", entry, alts); bad=1 }
      if (sigs < 4) { printf("synonyms.md entry \"%s\" has detection-signal categories %d (need >=4)\n", entry, sigs); bad=1 }
      if (!has_concept) { printf("synonyms.md entry \"%s\" missing conceptual-equivalence signal\n", entry); bad=1 }
    }
    /^### / {
      flush()
      entry = substr($0, 5); alts=0; sigs=0; in_sig=0; has_sig=0; has_concept=0; next
    }
    /\*\*Functional signature:\*\*/ { has_sig=1; in_sig=0; next }
    /\*\*Alternative names:\*\*/ {
      line=$0; sub(/.*\*\*Alternative names:\*\*[[:space:]]*/,"",line)
      n=split(line, a, /,/); alts=n; in_sig=0; next
    }
    /\*\*Detection signals:\*\*/ { in_sig=1; next }
    in_sig && /^[[:space:]]+-/ {
      sigs++;
      if ($0 ~ /Conceptual equivalents:/) has_concept=1
      next
    }
    /^## / { flush(); entry=""; in_sig=0 }
    END { flush(); exit bad }
  ' references/synonyms.md || fail=1
fi

[[ $fail -eq 0 ]] && echo "refs.test.sh: OK"
exit $fail
