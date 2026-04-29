#!/usr/bin/env bash
# Verify reference content shape: frontmatter, level/control coverage,
# pattern coverage, rosetta entry shape, and skill→ref cross-links.
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
  ["Agent Control Tower"]="L6 L7 L8 L9 L10"
  ["Compliance Evidence Pack"]="L4 L5 L6 L7 L8 L9 L10"
  ["Credential and Delegated Access"]="L5 L6 L7 L8 L9 L10"
  ["Data Governance"]="L2 L3 L4 L5 L6 L7 L8 L9 L10"
  ["Protocol Conformance"]="L3 L4 L5 L6 L7 L8 L9 L10"
  ["Incident Response"]="L6 L7 L8 L9 L10"
  ["OpenTelemetry Mapping"]="L5 L6 L7 L8 L9 L10"
  ["Value and Cost Management"]="L6 L7 L8 L9 L10"
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
for f in references/amm-levels.md references/controls.md references/patterns.md references/rosetta.md; do
  if [[ ! -f "$f" ]]; then echo "MISSING: $f"; fail=1; continue; fi
  fm=$(awk 'BEGIN{c=0} /^---$/{c++; if (c==2) exit; next} c==1{print}' "$f")
  if ! printf '%s\n' "$fm" | grep -q '^canon_version:'; then
    echo "MISSING canon_version in $f frontmatter"; fail=1
  fi
  if ! printf '%s\n' "$fm" | grep -q '^last_reviewed:'; then
    echo "MISSING last_reviewed in $f frontmatter"; fail=1
  fi
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

# 5. patterns.md: exactly 10 H2 sections, one per L1..L10. Required-family
# levels (L3-L10) MUST have a **Functional signature:** block. L1, L2 MUST
# carry "no v0 pattern family" and MUST NOT have a functional signature.
PATTERNS_REQUIRE_FAMILY=(3 4 5 6 7 8 9 10)
PATTERNS_REQUIRE_NO_V0=(1 2)
PATTERN_FAMILY_NAMES=()
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
    has_sig=0; printf '%s' "$body" | grep -qE '\*\*Functional signature:\*\*' && has_sig=1
    has_no=0;  printf '%s' "$body" | grep -qiE 'no v0 pattern family' && has_no=1
    if [[ "$has_sig" == "0" && "$has_no" == "0" ]]; then
      echo "patterns.md L${n} section has neither '**Functional signature:**' nor 'no v0 pattern family'"; fail=1
    fi
    if printf ' %s ' "${PATTERNS_REQUIRE_FAMILY[*]}" | grep -q " ${n} "; then
      if [[ "$has_sig" == "0" ]]; then
        echo "patterns.md L${n} is in the required-family set but lacks a **Functional signature:** block"; fail=1
      fi
    fi
    if printf ' %s ' "${PATTERNS_REQUIRE_NO_V0[*]}" | grep -q " ${n} "; then
      if [[ "$has_sig" == "1" ]]; then
        echo "patterns.md L${n} must be a 'no v0 pattern family' entry; functional signature is not allowed in v0"; fail=1
      fi
      if [[ "$has_no" == "0" ]]; then
        echo "patterns.md L${n} must contain the literal phrase 'no v0 pattern family'"; fail=1
      fi
    fi
    if [[ "$has_sig" == "1" ]]; then
      hdr=$(awk -v n="$n" -v sep="$LSEP" '$0 ~ ("^## .*L" n sep) {print; exit}' references/patterns.md)
      PATTERN_FAMILY_NAMES+=("$hdr")
      controls_present=$(printf '%s\n' "$body" | grep -cE '^[*-][[:space:]]*\*\*Controls activated:?\*\*' || true)
      tests_present=$(printf '%s\n' "$body" | grep -cE '^[*-][[:space:]]*\*\*Test asserts:?\*\*' || true)
      if [[ "$controls_present" == "0" ]]; then
        echo "patterns.md L${n} missing '**Controls activated:**' line"; fail=1
      fi
      if [[ "$tests_present" == "0" ]]; then
        echo "patterns.md L${n} missing '**Test asserts:**' line"; fail=1
      fi
      controls_text=$(printf '%s\n' "$body" | sed -nE 's/^[*-][[:space:]]*\*\*Controls activated:?\*\*[[:space:]]*//p' | head -1)
      tests_text=$(printf '%s\n' "$body" | sed -nE 's/^[*-][[:space:]]*\*\*Test asserts:?\*\*[[:space:]]*//p' | head -1)
      if [[ "$controls_present" != "0" && -z "${controls_text// }" ]]; then
        echo "patterns.md L${n} '**Controls activated:**' is empty"; fail=1
      fi
      if [[ "$tests_present" != "0" && -z "${tests_text// }" ]]; then
        echo "patterns.md L${n} '**Test asserts:**' is empty"; fail=1
      fi
      # Validate: every name listed under **Controls activated:** in this
      # section must be one of the nine canonical control names.
      controls_line=$(printf '%s\n' "$body" | sed -nE 's/^[*-][[:space:]]*\*\*Controls activated:?\*\*[[:space:]]*//p' | head -1)
      if [[ -n "$controls_line" ]]; then
        IFS=',' read -ra activated <<< "$controls_line"
        for c in "${activated[@]}"; do
          name=$(printf '%s' "$c" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')
          [[ -z "$name" ]] && continue
          ok=0
          for canon in "${CONTROL_NAMES[@]}"; do
            if [[ "$name" == "$canon" ]]; then ok=1; break; fi
          done
          if [[ "$ok" != "1" ]]; then
            echo "patterns.md L${n} **Controls activated:** has non-canonical name '$name'"; fail=1
          fi
        done
      fi
    fi
  done
fi

# 6. rosetta.md: ## Controls + ## Patterns; every control covered;
# every pattern family from patterns.md covered; every entry has
# Functional signature, >=3 alt names, >=3 detection-signal categories.
if [[ -f references/rosetta.md ]]; then
  for s in Controls Patterns; do
    if ! grep -q "^## $s$" references/rosetta.md; then
      echo "rosetta.md missing top-level section '## $s'"; fail=1
    fi
  done
  for c in "${CONTROL_NAMES[@]}"; do
    if ! grep -qxF "### $c" references/rosetta.md; then
      echo "rosetta.md missing entry: '### $c'"; fail=1
    fi
  done
  for hdr in "${PATTERN_FAMILY_NAMES[@]}"; do
    fam=$(printf '%s' "$hdr" | sed -E 's/^##[[:space:]]*//')
    if ! grep -qxF "### $fam" references/rosetta.md; then
      echo "rosetta.md missing pattern-family entry for '$fam' (from $hdr)"; fail=1
    fi
  done
  awk '
    function flush() {
      if (entry == "") return
      if (!has_sig) { printf("rosetta.md entry \"%s\" missing **Functional signature:**\n", entry); bad=1 }
      if (alts < 3) { printf("rosetta.md entry \"%s\" has alt count %d (need >=3)\n", entry, alts); bad=1 }
      if (sigs < 3) { printf("rosetta.md entry \"%s\" has detection-signal categories %d (need >=3)\n", entry, sigs); bad=1 }
    }
    /^### / {
      flush()
      entry = substr($0, 5); alts=0; sigs=0; in_sig=0; has_sig=0; next
    }
    /\*\*Functional signature:\*\*/ { has_sig=1; in_sig=0; next }
    /\*\*Alternative names:\*\*/ {
      line=$0; sub(/.*\*\*Alternative names:\*\*[[:space:]]*/,"",line)
      n=split(line, a, /,/); alts=n; in_sig=0; next
    }
    /\*\*Detection signals:\*\*/ { in_sig=1; next }
    in_sig && /^[[:space:]]+-/ { sigs++; next }
    /^## / { flush(); entry=""; in_sig=0 }
    END { flush(); exit bad }
  ' references/rosetta.md || fail=1
fi

[[ $fail -eq 0 ]] && echo "refs.test.sh: OK"
exit $fail
