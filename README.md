# agentic-maturity-model-skills

Cross-tool skills for making coding agents assess, design, implement, and review enterprise agents against the Agentic Maturity Model (AMM).

AMM is a 10-level maturity model for production AI agents. It starts with unmanaged AI use and ends with governed continuous improvement. Each level adds a capability boundary: grounded knowledge, human review, read-only tools, approved writes, goal-directed execution, coordinated agents, policy-gated autonomy, and governed improvement.

This repo packages that discipline as installable skills for coding agents. The skills make an agent ask for evidence, map controls, search across local naming differences, and produce assessment/design/implementation/review artifacts that an enterprise team can actually audit.

The source AMM implementation lives in [`tnilabs/agentic-maturity-model`](https://github.com/tnilabs/agentic-maturity-model). This repo vendors a self-contained snapshot of the AMM levels, controls, pattern entries, synonyms, and detection guidance. Installed skills do not fetch from that repo at runtime.

## What You Get

- Evidence-first AMM assessment: classify the actual level from repo artifacts, not self-claims.
- Enterprise design briefs: turn an agent idea into a target-level plan with controls, evidence, and failure modes.
- Implementation planning: apply AMM pattern entries such as L5 read-only tools, L6 approved writes, or L8 coordinated agents.
- Review discipline: verify PRs, evidence packs, and level claims using synonym-guided searches.
- Synonym-aware matching: do not miss a control just because a team calls it something else.
- Self-contained canon: AMM levels, 9 enterprise controls, all source-aligned pattern entries, and detection signals ship in this repo.

## Skills

| Skill | Use it for |
| --- | --- |
| `amm` | Gateway. Routes AMM-related work to one of the four focused skills. |
| `amm-assess` | Determine the observed AMM level of an existing agent system. |
| `amm-design` | Design a new enterprise agent for a target AMM level. |
| `amm-implement` | Plan or implement AMM pattern entries in a codebase. |
| `amm-review` | Review a change, PR, or evidence pack for AMM conformance. |

The gateway announces the routed skill in the form `Using <skill> to <purpose>`. Direct invocation is also fine when your tool supports explicit skill names.

## Example Prompts

Use natural language first. The gateway should route automatically.

```text
What AMM level is this repository at? Use evidence only.
```

```text
Design a regulated support agent at AMM L6. Include controls, evidence, failure modes, and review boundaries.
```

```text
Use AMM to plan L5 read-only tool access for this codebase. Do not edit files yet.
```

```text
Review this PR for AMM L6 compliance. List every synonym-guided search you performed before marking anything missing.
```

```text
Create an implementation plan to move this prototype from L4 to L5.
```

## Explicit Skill Use

Most tools load skills automatically from the prompt. When you want to be explicit, use the compact skill name.

```text
Use amm-assess to classify this repo's observed AMM level.
```

```text
Use amm-design to design a claims-processing agent at AMM L6.
```

```text
Use amm-implement to plan L5 read-only tool manifests and audit records.
```

```text
Use amm-review to check this PR's claimed AMM L7 compliance.
```

Some hosts display the plugin namespace. In Codex, for example, the skills may appear as:

```text
agentic-maturity-model-skills:amm
agentic-maturity-model-skills:amm-assess
agentic-maturity-model-skills:amm-design
agentic-maturity-model-skills:amm-implement
agentic-maturity-model-skills:amm-review
```

In OpenCode, use the skill tool path:

```text
use skill tool to load agentic-maturity-model-skills/amm
```

## Typical Workflow

1. Assess the current system:
   `What AMM level is this repo at? Use evidence only.`
2. Pick a target level:
   `Design the smallest safe path from observed L<n> to target L<n+1>.`
3. Plan the implementation:
   `Use amm-implement to plan the required AMM pattern entries. Do not edit files yet.`
4. Implement in small changes:
   Ask your coding agent to make one bounded change at a time.
5. Review before merge:
   `Use amm-review to verify this PR against claimed AMM L<n>.`

## Expected Outputs

| Skill | Output |
| --- | --- |
| `amm-assess` | AMM assessment with observed level, confidence, evidence per level, blockers, and control gaps. |
| `amm-design` | Target-level design brief with active controls, pattern entries, evidence to produce, failure modes, and open questions. |
| `amm-implement` | Implementation plan with files to inspect/change, tests to add, controls activated, and verification gates. |
| `amm-review` | Review report with pass/fail findings, synonym-guided searches performed, control/pattern verdicts, and merge blockers. |

## Sample Output Shapes

`amm-assess` produces an evidence report:

```markdown
# AMM Assessment

- Canon versions: amm-levels v1.1.0, controls v1.1.0, patterns v1.1.0, synonyms v1.1.0
- Claimed level: unstated
- Observed level: L2
- Confidence: medium - workflow artifacts exist, but no L3 retrieval evidence was found

## Evidence per level
### L1 - Unstructured AI use
- Exit criterion: baseline cases recorded; verdict: satisfied; locations: docs/baseline.md

### L2 - Process definition
- Exit criterion: workflow stages have owners and policies; verdict: satisfied; locations: process/workflow.yaml

### L3 - Knowledge grounding
- Exit criterion: evidence IDs and retrieval evals; verdict: missing; signals searched: evidence_id, retrieval-evals, knowledge-index; locations: no matches

## Blockers to next level
- L3 knowledge grounding - add reviewed knowledge index, coverage map, and golden retrieval evals
```

`amm-design` produces a target-level design brief:

```yaml
target_level: L6
agent_goal: "Draft and execute one approved account-update action"
active_controls:
  - Data Governance
  - Credential and Delegated Access
  - Protocol Conformance
  - Incident Response
evidence_to_produce:
  - ApprovalRecord bound by action hash
  - CredentialLease consumed once
  - ToolAction with idempotency key
  - RollbackPlan for every write
open_questions:
  - Which writes are eligible for L6 approval?
  - Who signs approval records?
```

`amm-review` produces merge-oriented findings:

```markdown
# AMM Review

- Claimed level: L6
- Verdict: blocked

## Findings
- BLOCKER: approved writes are not bound to exact action hash.
  - Synonym signals searched: binding_hash, ApprovalRecord, approval_consumed
  - Locations: src/actions/write.ts, tests/actions/
  - Required fix: verify signed approval before issuing one-shot lease

## Passing Evidence
- Read-only tool manifests include side_effect_class=read_only.
- Tool calls emit AuditRecord with actor, scope, and redacted output.
```

## Enterprise Controls Covered

AMM controls accumulate by level. The skills track these nine categories:

- Adversarial Awareness
- Agent Control Tower
- Compliance Evidence Pack
- Credential and Delegated Access
- Data Governance
- Protocol Conformance
- Incident Response
- OpenTelemetry Mapping
- Value and Cost Management

L1-L2 are still detectable even though no enterprise controls are active yet. `amm-assess` checks their baseline, process, and threat-model artifacts. L3 adds knowledge-grounding patterns and Data Governance. From L4 onward, the control surface becomes much more visible: review boundaries, evidence packs, adversarial labels, telemetry, and value metrics.

## Install From GitHub

### Claude Code

```text
/plugin marketplace add tnilabs/agentic-maturity-model-skills
/plugin install agentic-maturity-model-skills@agentic-maturity-model-skills
```

### Codex CLI / Codex App

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.codex/agentic-maturity-model-skills
mkdir -p ~/.codex/skills
ln -s ~/.codex/agentic-maturity-model-skills/skills/* ~/.codex/skills/
```

Restart Codex. Codex discovers skills from `$CODEX_HOME/skills` (`~/.codex/skills` by default). Full doc: [`.codex/INSTALL.md`](.codex/INSTALL.md).

### Cursor

```bash
git clone https://github.com/tnilabs/agentic-maturity-model-skills.git ~/.cursor/agentic-maturity-model-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/agentic-maturity-model-skills-src ~/.cursor/plugins/agentic-maturity-model-skills
```

Reload Cursor: Cmd+Shift+P -> `Developer: Reload Window`. Full doc: [`.cursor-plugin/INSTALL.md`](.cursor-plugin/INSTALL.md).

### OpenCode

Add this plugin entry to `opencode.json`, then restart OpenCode:

```json
{
  "plugin": [
    "agentic-maturity-model-skills@git+https://github.com/tnilabs/agentic-maturity-model-skills.git"
  ]
}
```

Verify with: `use skill tool to load agentic-maturity-model-skills/amm`. Full doc: [`.opencode/INSTALL.md`](.opencode/INSTALL.md).

### Gemini CLI

```bash
gemini extensions install https://github.com/tnilabs/agentic-maturity-model-skills
```

### Copilot CLI

```bash
copilot plugin marketplace add tnilabs/agentic-maturity-model-skills
copilot plugin install agentic-maturity-model-skills@agentic-maturity-model-skills
```

## How The Skills Work

The skills consult four shipped canon files:

- [`references/amm-levels.md`](references/amm-levels.md): the 10 AMM levels and exit criteria.
- [`references/controls.md`](references/controls.md): 9 enterprise control categories and activation matrix.
- [`references/patterns.md`](references/patterns.md): source-aligned AMM pattern entries by level.
- [`references/synonyms.md`](references/synonyms.md): alternative names and detection signals for controls and patterns.

Focused skills also include local copies of those reference files so installed-plugin hosts can read the canon even when they restrict access outside a skill directory. Tests enforce that the copies match the root references exactly.

Assessment and review skills must record their searches. A missing-control finding is invalid unless the agent searched synonym and detection signals, then records where it looked. This is the main value of the plugin: it turns "I don't see it" into auditable evidence.

## Refresh

| Tool | Update command |
| --- | --- |
| Claude Code | `/plugin marketplace update agentic-maturity-model-skills` then `/plugin update agentic-maturity-model-skills` |
| Codex CLI / App | `cd ~/.codex/agentic-maturity-model-skills && git pull`, then restart Codex |
| Cursor | `cd ~/.cursor/agentic-maturity-model-skills-src && git pull`, then reload Cursor |
| OpenCode | Restart OpenCode, or pin/update the `#vX.Y.Z` suffix in `opencode.json` |
| Gemini CLI | `gemini extensions update agentic-maturity-model-skills` |
| Copilot CLI | `copilot plugin update agentic-maturity-model-skills@agentic-maturity-model-skills` |

## Non-Goals

This is not a runtime, CLI, model integration, or framework. It does not execute agents. It gives coding agents a compact AMM operating discipline and the canon needed to apply it.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation, release, and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. AMM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
