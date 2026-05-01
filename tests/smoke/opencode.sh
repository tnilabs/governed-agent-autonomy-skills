#!/usr/bin/env bash
# OpenCode artifact-sanity check.
#
# Skip-with-message rule: if the `opencode` binary is absent, this script
# exits 0 with a SKIP message (CI must not fail on partial environments).
# When opencode IS present, we functionally exercise the plugin's `config`
# hook to confirm it pushes the bundled skills/ path into
# `config.skills.paths` — bare syntax check isn't enough (a missing hook
# would pass --check but break OpenCode skill discovery).
set -euo pipefail
if ! command -v opencode >/dev/null 2>&1; then
  echo "opencode.sh: SKIP (opencode CLI not installed)"; exit 0
fi
if ! command -v node >/dev/null 2>&1; then
  echo "opencode.sh: FAIL (opencode is installed but node isn't; the plugin requires Node)"; exit 1
fi
fail=0
[[ -f .opencode/INSTALL.md ]] || { echo "opencode.sh: .opencode/INSTALL.md missing"; fail=1; }
[[ -f .opencode/plugins/governed-agent-autonomy-skills.js ]] || { echo "opencode.sh: plugin JS missing"; fail=1; }
if [[ $fail -ne 0 ]]; then exit $fail; fi

node --check .opencode/plugins/governed-agent-autonomy-skills.js

# Functionally exercise the config hook.
node --input-type=module - <<'NODEJS'
import path from "node:path";
const repoRoot = process.cwd();
const expected = path.resolve(repoRoot, "skills");

const mod = await import(path.resolve(repoRoot, ".opencode/plugins/governed-agent-autonomy-skills.js"));
const plugin = mod.GovernedAgentAutonomySkillsPlugin || mod.default;
if (typeof plugin !== "function") {
  console.error("plugin is not a callable function");
  process.exit(1);
}
const result = await plugin({ client: {}, directory: repoRoot });
if (!result || typeof result.config !== "function") {
  console.error("plugin return value missing config() async hook");
  process.exit(1);
}
const cfg = {};
await result.config(cfg);
if (!cfg.skills || !Array.isArray(cfg.skills.paths) || !cfg.skills.paths.includes(expected)) {
  console.error("config.skills.paths missing expected path:", expected, "got:", cfg.skills && cfg.skills.paths);
  process.exit(1);
}
console.log("opencode plugin functional check: OK");
NODEJS
echo "opencode.sh: OK"
