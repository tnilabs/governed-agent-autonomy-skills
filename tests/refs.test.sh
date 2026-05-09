#!/usr/bin/env bash
# Verify reference content shape: frontmatter, level/control coverage,
# pattern coverage, synonym entry shape, and skill→ref cross-links.
set -euo pipefail
fail=0

# Canonical control names — single source of truth for tests.
CONTROL_NAMES=(
  "Threat & Adversarial Resilience"
  "Agent Registry & Lifecycle"
  "Evidence & Assurance"
  "Delegated Authority & Access"
  "Data, Context & Memory Governance"
  "Tool & Protocol Safety"
  "Incident Response & Recovery"
  "Runtime Isolation & Execution Safety"
  "Observability & Telemetry"
  "Value, Cost & Reliability"
)

# Canonical control-to-GAAM-level activation matrix (v6).
declare -A EXPECTED_ACTIVATIONS=(
  ["Threat & Adversarial Resilience"]="L1 L2 L3 L4 L5 L6 L7"
  ["Agent Registry & Lifecycle"]="L4 L5 L6 L7"
  ["Evidence & Assurance"]="L1 L2 L3 L4 L5 L6 L7"
  ["Delegated Authority & Access"]="L2 L3 L4 L5 L6 L7"
  ["Data, Context & Memory Governance"]="L0 L1 L2 L3 L4 L5 L6 L7"
  ["Tool & Protocol Safety"]="L2 L3 L4 L5 L6 L7"
  ["Incident Response & Recovery"]="L3 L4 L5 L6 L7"
  ["Runtime Isolation & Execution Safety"]="L1 L2 L3 L4 L5 L6 L7"
  ["Observability & Telemetry"]="L1 L2 L3 L4 L5 L6 L7"
  ["Value, Cost & Reliability"]="L1 L2 L3 L4 L5 L6 L7"
)

PATTERN_IDS=(
  "L0-baseline-failure-cataloguing"
  "L0-process-as-substrate"
  "L0-threat-model-as-substrate"
  "L0-knowledge-coverage-map"
  "L0-golden-retrieval-evals"
  "L0-provenance-attested-source"
  "L1-pending-review-boundary"
  "L1-provenance-framed-prompt-assembly"
  "L1-customer-safe-output-check"
  "L1-adversarial-input-labeling"
  "L2-typed-tool-manifest-with-scope"
  "L2-scoped-grant-per-run"
  "L2-read-tool-audit-redaction"
  "L2-mcp-conformance-derived-from-manifest"
  "L2-tool-output-sanitization"
  "L2-native-tool-conformance"
  "L3-model-recommends-runtime-assembles"
  "L3-approval-binding-hash"
  "L3-one-shot-action-authority"
  "L3-idempotent-action-replay"
  "L3-recovery-metadata-on-every-action"
  "L3-signed-approval-evidence"
  "L3-customer-safety-block-gate"
  "L4-signed-goal-with-immutable-scope"
  "L4-success-criteria-predicate-registry"
  "L4-task-agent-stop-reasons"
  "L4-memory-write-validation"
  "L5-signed-a2a-card"
  "L5-validator-veto-handoff"
  "L5-durable-orchestration-state"
  "L6-policy-eligibility-gate"
  "L6-global-pause-and-dead-letter"
  "L6-continuous-adversarial-eval-corpus"
  "L7-evidence-backed-improvement-proposal"
  "L7-adversarial-release-gate"
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
for f in references/gaam-levels.md references/controls.md references/patterns.md references/synonyms.md; do
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
for skill in gaam-assess gaam-design gaam-implement gaam-review; do
  for ref in gaam-levels.md controls.md patterns.md synonyms.md; do
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

# 3. gaam-levels.md: exactly 8 H2 sections matching ^## L<n>(<sep>|$).
if [[ -f references/gaam-levels.md ]]; then
  count=$(grep -cE "^## L[0-7]${LSEP}" references/gaam-levels.md || true)
  if [[ "$count" != "8" ]]; then
    echo "gaam-levels.md has $count H2 'L<n>' sections, expected 8"; fail=1
  fi
  for n in 8 9 10; do
    if grep -qE "^## L${n}${LSEP}" references/gaam-levels.md; then
      echo "gaam-levels.md contains forbidden obsolete L${n} section"; fail=1
    fi
  done
  for n in 0 1 2 3 4 5 6 7; do
    if ! grep -qE "^## L${n}${LSEP}" references/gaam-levels.md; then
      echo "gaam-levels.md missing section for L${n}"; fail=1
    fi
  done
fi

# 4. controls.md: exactly 10 H2 sections, each a canonical control name,
# and each carrying an `Activated at GAAM levels:` line that matches.
LEVEL_ORDER="L0 L1 L2 L3 L4 L5 L6 L7"
canon_sort() {
  local tokens=" $1 "
  local out=""
  for L in $LEVEL_ORDER; do
    if printf '%s' "$tokens" | grep -q " ${L} "; then out="$out${L} "; fi
  done
  printf '%s' "${out% }"
}

reject_obsolete_levels() {
  local label=$1
  local text=$2
  if printf '%s' "$text" | grep -Eq '(^|[^A-Za-z0-9_-])L(8|9|10)([^A-Za-z0-9_-]|$)'; then
    echo "$label contains forbidden obsolete L8-L10 level token"; fail=1
  fi
}

if [[ -f references/controls.md ]]; then
  reject_obsolete_levels "controls.md" "$(cat references/controls.md)"
  for c in "${CONTROL_NAMES[@]}"; do
    if ! grep -qxF "## $c" references/controls.md; then
      echo "controls.md missing canonical heading: '## $c'"; fail=1; continue
    fi
    section=$(awk -v hdr="## $c" 'index($0, hdr)==1 {found=1; next} found && /^## / {exit} found {print}' references/controls.md)
    activations_line=$(printf '%s\n' "$section" | grep -E '^[*-][[:space:]]*\*\*Activated at GAAM levels:?\*\*' | head -1 || true)
    if [[ -z "$activations_line" ]]; then
      echo "controls.md '$c' missing 'Activated at GAAM levels:' line"; fail=1; continue
    fi
    list=$(printf '%s' "$activations_line" | sed -E 's/.*\*\*Activated at GAAM levels:?\*\*[[:space:]]*//')
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
  if [[ "$total" != "10" ]]; then
    echo "controls.md has $total H2 sections, expected exactly 10"; fail=1
  fi
fi

# 5. patterns.md: exactly 8 H2 sections, one per L0..L7. Every GAAM
# capability pattern must be represented as a `###` entry with
# a functional signature, controls activated, and test asserts. L0 carries
# substrate patterns, not "no pattern" placeholders.
PATTERN_ENTRY_NAMES=()
if [[ -f references/patterns.md ]]; then
  reject_obsolete_levels "patterns.md" "$(cat references/patterns.md)"
  pcount=$(grep -cE "^## L[0-7]${LSEP}" references/patterns.md || true)
  if [[ "$pcount" != "8" ]]; then
    echo "patterns.md has $pcount H2 'L<n>' sections, expected exactly 8"; fail=1
  fi
  for n in 8 9 10; do
    if grep -qE "^## .*L${n}${LSEP}" references/patterns.md; then
      echo "patterns.md contains forbidden obsolete L${n} section"; fail=1
    fi
  done
  for n in 0 1 2 3 4 5 6 7; do
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
      echo "patterns.md missing GAAM capability pattern entry: '### $pattern_id'"; fail=1; continue
    fi
    body=$(awk -v hdr="### $pattern_id" 'index($0, hdr)==1 {found=1; next} found && /^### / {exit} found && /^## / {exit} found {print}' references/patterns.md)
    for label in "Functional signature" "Controls activated" "Test asserts"; do
      if ! printf '%s\n' "$body" | grep -qE "^[*-][[:space:]]*\\*\\*${label}:?\\*\\*"; then
        echo "patterns.md '$pattern_id' missing '**${label}:**' line"; fail=1
      fi
    done
    controls_line=$(printf '%s\n' "$body" | sed -nE 's/^[*-][[:space:]]*\*\*Controls activated:?\*\*[[:space:]]*//p' | head -1)
    if [[ -n "$controls_line" && "$controls_line" != "None" ]]; then
      remainder="$controls_line"
      for canon in "${CONTROL_NAMES[@]}"; do
        remainder=${remainder//"$canon"/}
      done
      remainder=$(printf '%s' "$remainder" | tr -d '[:space:],')
      if [[ -n "$remainder" ]]; then
        echo "patterns.md '$pattern_id' **Controls activated:** has non-canonical residue '$remainder' in '$controls_line'"; fail=1
      fi
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
  if ! grep -qF 'Canonical GAAM names are semantic anchors. Example artifact names are non-normative context cues, not required strings.' references/synonyms.md; then
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
