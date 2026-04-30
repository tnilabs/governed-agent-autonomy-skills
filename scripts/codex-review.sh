#!/usr/bin/env bash
# Optional local Codex review-and-fix helper.
#
# Codex reads the full tracked tree, identifies gaps against the v1
# acceptance criteria, and FIXES them inline (workspace-write sandbox),
# committing each logical fix as it goes. The human re-runs the gate
# until no BLOCKER or MAJOR findings remain in the report. MINOR/NIT may
# be deferred with a recorded justification. After Codex's pass the
# human reviews the new commits.
set -euo pipefail

if ! command -v codex >/dev/null 2>&1; then
  echo "codex CLI not installed; cannot run review gate"; exit 1
fi

mkdir -p internal
ts="$(date -u +%Y%m%dT%H%M%SZ)"
out="internal/codex-review-${ts}.md"
before_sha="$(git rev-parse HEAD)"

prompt='Review AND FIX the agentic-maturity-model-skills repo. The tracked tree (not a diff) is the input — every prior task already committed.

For every BLOCKER and MAJOR finding you identify: edit the affected file(s) inline, run `git add <paths>`, and run `git commit -m "fix(review): <one-line summary>"` for each logical fix. Do not batch unrelated fixes into one commit. Use `<type>(<scope>): <summary>` style consistently with the existing repo (see git log).

For MINOR and NIT findings: fix inline if trivial (typos, missing fields, easy regex tightening); otherwise list them as deferred follow-ups in the final report with a clear suggested fix.

Read all files under skills/, references/, scripts/, tests/, tests/smoke/, .claude-plugin/, .codex/, .codex-plugin/, .cursor-plugin/, .opencode/, plus package.json, gemini-extension.json, README.md, CONTRIBUTING.md, AGENTS.md, GEMINI.md.

Review criteria (do not skip any):
1. Internal consistency between references/ and skills/ — every concept a skill cites must be defined in references/.
2. Skill descriptions follow "Use when…" trigger-only convention with no workflow summary.
3. Plugin manifests are syntactically correct and reference real files (Codex interface block + capabilities=[Interactive,Read,Write], OpenCode package.json type/main, Cursor skills path with no agents/commands/hooks, Gemini contextFileName=GEMINI.md, Claude marketplace plugins[].source).
4. Cross-tool installation paths in README match each tool actual mechanism (Claude Code local marketplace, Codex CLI/App symlink, Cursor symlink, OpenCode opencode.json, Gemini extensions install, Copilot marketplace).
5. The assess and review skills enforce the conceptual-equivalence rule (no "missing" finding without a recorded conceptual-equivalence search; the literal phrase "recorded conceptual-equivalence search" must appear in both bodies).
5b. All focused skills enforce semantic-anchor matching: the literal phrase "semantic equivalents, not literal names" appears in assess/design/implement/review, and assess explicitly covers level descriptions, requirements, controls, and record/schema names.
6. Each synonym entry has **Functional signature:** + >=3 alternative names + >=4 detection-signal categories, including conceptual equivalents.
7. No skill, reference, README, context file, install doc, or script instructs the agent to fetch from external repos beyond the documented install/update commands.
8. patterns.md has one section per AMM level L1–L10; every source AMM pattern ID has a `### <pattern-id>` entry with **Functional signature:** + **Controls activated:** + **Test asserts:** blocks; L1 and L2 are substrate patterns and MUST NOT carry "no v0 pattern family" placeholders.
9. controls.md uses the canonical 9 names exactly with the source-aligned activation matrix from ../agentic-maturity-model/controls/README.md.
10. Skills do not chain to any other plugin (no superpowers:* or <plugin>:<skill> form anywhere in skill bodies).
11. Bash test scripts under tests/ and tests/smoke/ are correct (regexes match what they claim, exit codes are not masked, all paths exist) and consistent with the repo test requirements.

Final report (the only thing written to stdout, also the file Codex captures via -o):
- Summary: count of BLOCKERs fixed, MAJORs fixed, MINORs fixed, MINORs deferred, NITs deferred.
- For each fix applied: severity, location, what was wrong, the resulting commit subject.
- For each deferred MINOR/NIT: severity, location, what was wrong, suggested fix.
- Verdict: GO (no BLOCKER/MAJOR findings remain) / CONDITIONAL GO (only deferred MINOR/NIT) / HOLD (further iterations needed).

Do NOT modify gitignored files (docs/, internal/, .env, etc.). Do NOT touch any file outside this repo. Stay within the agentic-maturity-model-skills tracked tree.'

codex exec --sandbox workspace-write --skip-git-repo-check --ephemeral -o "$out" "$prompt"

if [[ ! -s "$out" ]]; then
  echo "FAIL: codex review produced no output ($out is empty)"; exit 1
fi

echo "Review-and-fix output: $out"
echo
echo "Commits Codex made in this pass:"
git log --oneline "${before_sha}..HEAD" || echo "(none)"
