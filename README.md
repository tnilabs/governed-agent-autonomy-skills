# governed-agent-autonomy-skills

Cross-tool skills for making coding agents assess, design, implement, and review enterprise agents against the Governed Agent Autonomy Model (GAAM).

GAAM is a 10-level framework for governed production AI agents. It starts with unmanaged AI baseline and ends with governed improvement loop. Each level adds an authority boundary: grounded knowledge, reviewed assistance, scoped read access, approved action, bounded task agency, verified agent coordination, policy-gated autonomy, and governed improvement loop.

This repo packages that discipline as installable skills for coding agents. The skills make an agent ask for evidence, map GAAM anchors to local semantics, search across naming and architecture differences, and produce assessment/design/implementation/review artifacts that an enterprise team can actually audit.

This repo is a standalone GAAM skills distribution. It ships the GAAM levels, controls, capability patterns, synonyms, and detection guidance needed by installed skills. Installed skills do not fetch canon from another repository at runtime.

## What You Get

- Evidence-first GAAM assessment: classify the actual level from repo artifacts, not self-claims.
- Enterprise design briefs: turn an agent idea into a target-level plan with controls, evidence, and failure modes.
- Implementation planning: apply GAAM capability patterns such as L5 scoped read access, L6 approved action, or L8 verified agent coordination.
- Review discipline: verify PRs, evidence packs, and level claims using conceptual-equivalence searches.
- Conceptual matching: do not miss a level requirement, control, pattern, or evidence shape just because a team names or structures it differently.
- Semantic anchors: GAAM names are traceability handles, not required strings; the skills search semantic equivalents, not literal names.
- Self-contained canon: GAAM levels, 10 enterprise controls, capability patterns, and detection signals ship in this repo.

## Skills

| Skill | Use it for |
| --- | --- |
| `gaam` | Gateway. Routes GAAM-related work to one of the four focused skills. |
| `gaam-assess` | Determine the observed GAAM level of an existing agent system. |
| `gaam-design` | Design a new enterprise agent for a target GAAM level. |
| `gaam-implement` | Plan or implement GAAM pattern entries in a codebase. |
| `gaam-review` | Review a change, PR, or evidence pack for GAAM conformance. |

The gateway announces the routed skill in the form `Using <skill> to <purpose>`. Direct invocation is also fine when your tool supports explicit skill names.

## Example Prompts

Use natural language first. The gateway should route automatically.

```text
What GAAM level is this repository at? Use evidence only.
```

```text
Design a regulated support agent at GAAM L6. Include controls, evidence, failure modes, and review boundaries.
```

```text
Use GAAM to plan L5 scoped read access for this codebase. Do not edit files yet.
```

```text
Review this PR for GAAM L6 compliance. List every conceptual-equivalence search you performed before marking anything missing.
```

```text
Create an implementation plan to move this prototype from L4 to L5.
```

## Explicit Skill Use

Most tools load skills automatically from the prompt. When you want to be explicit, use the compact skill name.

```text
Use gaam-assess to classify this repo's observed GAAM level.
```

```text
Use gaam-design to design a claims-processing agent at GAAM L6.
```

```text
Use gaam-implement to plan L5 read-only tool manifests and audit evidence.
```

```text
Use gaam-review to check this PR's claimed GAAM L7 compliance.
```

Some hosts display the plugin namespace. In Codex, for example, the skills may appear as:

```text
governed-agent-autonomy-skills:gaam
governed-agent-autonomy-skills:gaam-assess
governed-agent-autonomy-skills:gaam-design
governed-agent-autonomy-skills:gaam-implement
governed-agent-autonomy-skills:gaam-review
```

In OpenCode, use the skill tool path:

```text
use skill tool to load governed-agent-autonomy-skills/gaam
```

## Typical Workflow

1. Assess the current system:
   `What GAAM level is this repo at? Use evidence only.`
2. Pick a target level:
   `Design the smallest safe path from observed L<n> to target L<n+1>.`
3. Plan the implementation:
   `Use gaam-implement to plan the required GAAM pattern entries. Do not edit files yet.`
4. Implement in small changes:
   Ask your coding agent to make one bounded change at a time.
5. Review before merge:
   `Use gaam-review to verify this PR against claimed GAAM L<n>.`

## Expected Outputs

| Skill | Output |
| --- | --- |
| `gaam-assess` | GAAM assessment with observed level, full L1-L10 evidence, lowest failing boundary, partial higher-level evidence, and semantic gaps. |
| `gaam-design` | Target-level design brief with active controls, pattern entries, evidence to produce, failure modes, and open questions. |
| `gaam-implement` | Implementation plan with files to inspect/change, tests to add, controls activated, and verification gates. |
| `gaam-review` | Review report with pass/fail findings, conceptual-equivalence searches performed, control/pattern verdicts, and merge blockers. |

## Sample Output Shapes

`gaam-assess` produces an evidence report:

```markdown
# GAAM Assessment

- Canon versions: gaam-levels v2.0.0, controls v2.0.0, patterns v2.0.0, synonyms v2.0.0
- Claimed level: unstated
- Observed level: L2
- Confidence: medium - workflow artifacts exist, but no L3 retrieval evidence was found

## Terminology and conceptual mapping
| User-team structure/name | GAAM semantic anchor | Equivalent capability/evidence |
| --- | --- | --- |
| support run dossier | evidence and assurance | run, review, eval, audit, and approval evidence exported together |

## Evidence per level
### L1 - Unmanaged AI Baseline
- Exit criterion: baseline work items recorded; verdict: satisfied; locations: docs/baseline.md

### L2 - Process & Policy Contract
- Exit criterion: workflow stages have owners and policies; verdict: satisfied; locations: process/workflow.yaml

### L3 - Grounded Knowledge
- Exit criterion: evidence IDs and retrieval evals; verdict: missing; searched: evidence_id, retrieval-evals, knowledge-index, equivalent corpus gates; locations: no matches

### L5 - Scoped Read Access
- Pattern: scoped read grants; verdict: partial; searched: issue_read_grant, authority broker, delegated read access, equivalent per-run authority; locations: src/auth/grants.ts

## Lowest failing boundary
- L3 grounded knowledge - add reviewed knowledge index, coverage map, and golden retrieval evals

## Partial higher-level evidence
- L5 scoped grants exist, but L3/L4 are incomplete, so they do not raise the observed level
```

`gaam-design` produces a target-level design brief:

```yaml
target_level: L6
agent_goal: "Draft and execute one approved account-update action"
active_controls:
  - Threat & Adversarial Resilience
  - Evidence & Assurance
  - Data, Context & Memory Governance
  - Runtime Isolation & Execution Safety
  - Observability & Telemetry
  - Value, Cost & Reliability
  - Delegated Authority & Access
  - Tool & Protocol Safety
  - Incident Response & Recovery
evidence_to_produce:
  - approval evidence bound by action hash
  - one-use action authority consumed once
  - action result entry with idempotency key
  - recovery or compensation plan for every side effect
open_questions:
  - Which actions are eligible for L6 approval?
  - Which local approval artifact is the audit source of truth?
```

`gaam-review` produces merge-oriented findings:

```markdown
# GAAM Review

- Claimed level: L6
- Verdict: blocked

## Findings
- BLOCKER: approved actions are not bound to the exact action payload.
  - Signals searched: binding hash, approval ledger, reviewer signoff, action digest, equivalent approval workflow
  - Locations: src/actions/execute.ts, tests/actions/
  - Required fix: verify signed approval before issuing one-shot authority

## Passing Evidence
- Read-only tool manifests include side_effect_class=read_only.
- Tool calls emit audit events with actor, scope, and redacted output.
```

## Enterprise Controls Covered

GAAM controls accumulate by level. The skills track these ten categories:

- Threat & Adversarial Resilience
- Agent Registry & Lifecycle
- Evidence & Assurance
- Delegated Authority & Access
- Data, Context & Memory Governance
- Tool & Protocol Safety
- Incident Response & Recovery
- Runtime Isolation & Execution Safety
- Observability & Telemetry
- Value, Cost & Reliability

L1-L3 are preparation evidence, not reliable runtime maturity detection. `gaam-assess` can report baseline, process, threat-model, and knowledge-grounding artifacts when they exist, but many real repos will not keep process docs or RAG corpus contents in-tree. That is a valid evidence gap, not an assessment failure. The reliable assessment range starts at L4, where review boundaries, evidence packs, adversarial labels, telemetry, and control surfaces become observable. The observed level stays at the highest fully evidenced prefix, while later artifacts are still captured as partial higher-level evidence.

## Install From GitHub

### Claude Code

```text
/plugin marketplace add tnilabs/governed-agent-autonomy-skills
/plugin install governed-agent-autonomy-skills@governed-agent-autonomy-skills
```

### Codex CLI / Codex App

```bash
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git ~/.codex/governed-agent-autonomy-skills
mkdir -p ~/.codex/skills
ln -s ~/.codex/governed-agent-autonomy-skills/skills/* ~/.codex/skills/
```

Restart Codex. Codex discovers skills from `$CODEX_HOME/skills` (`~/.codex/skills` by default). Full doc: [`.codex/INSTALL.md`](.codex/INSTALL.md).

### Cursor

```bash
git clone https://github.com/tnilabs/governed-agent-autonomy-skills.git ~/.cursor/governed-agent-autonomy-skills-src
mkdir -p ~/.cursor/plugins
ln -s ~/.cursor/governed-agent-autonomy-skills-src ~/.cursor/plugins/governed-agent-autonomy-skills
```

Reload Cursor: Cmd+Shift+P -> `Developer: Reload Window`. Full doc: [`.cursor-plugin/INSTALL.md`](.cursor-plugin/INSTALL.md).

### OpenCode

Add this plugin entry to `opencode.json`, then restart OpenCode:

```json
{
  "plugin": [
    "governed-agent-autonomy-skills@git+https://github.com/tnilabs/governed-agent-autonomy-skills.git"
  ]
}
```

Verify with: `use skill tool to load governed-agent-autonomy-skills/gaam`. Full doc: [`.opencode/INSTALL.md`](.opencode/INSTALL.md).

### Gemini CLI

```bash
gemini extensions install https://github.com/tnilabs/governed-agent-autonomy-skills
```

### Copilot CLI

```bash
copilot plugin marketplace add tnilabs/governed-agent-autonomy-skills
copilot plugin install governed-agent-autonomy-skills@governed-agent-autonomy-skills
```

## How The Skills Work

The skills consult four shipped canon files:

- [`references/gaam-levels.md`](references/gaam-levels.md): the 10 GAAM levels and exit criteria.
- [`references/controls.md`](references/controls.md): 10 enterprise control categories and activation matrix.
- [`references/patterns.md`](references/patterns.md): GAAM capability patterns by level.
- [`references/synonyms.md`](references/synonyms.md): alternative names, conceptual-equivalence rules, and detection signals for controls and patterns.

Focused skills also include local copies of those reference files so installed-plugin hosts can read the canon even when they restrict access outside a skill directory. Tests enforce that the copies match the root references exactly.

Assessment and review skills must record their searches. A missing-control finding is invalid unless the agent checked functional meaning, detection signals, local structures, and locations. This is the main value of the plugin: it turns "I don't see it" into auditable evidence.

The canon uses stable GAAM names so reports are traceable, but those names are not a naming mandate. Level descriptions, requirements, control headings, and pattern IDs are semantic anchors. Example artifact names are context cues, not required records. A local ticket workflow, event stream, table, service, external evidence store, or existing schema can satisfy a GAAM item when it proves the same workflow context, authority boundary, capability, evidence semantics, runtime boundary, and failure prevention.

For headless Claude Code validation, plugin skill references may need the plugin cache added as a readable directory:

```bash
claude -p "Use gaam-assess to classify this repo" \
  --settings ~/.claude/settings.json \
  --add-dir ~/.claude/plugins/cache \
  --allowedTools Read,Glob,Grep
```

## Refresh

| Tool | Update command |
| --- | --- |
| Claude Code | `/plugin marketplace update governed-agent-autonomy-skills` then `/plugin update governed-agent-autonomy-skills` |
| Codex CLI / App | `cd ~/.codex/governed-agent-autonomy-skills && git pull`, then restart Codex |
| Cursor | `cd ~/.cursor/governed-agent-autonomy-skills-src && git pull`, then reload Cursor |
| OpenCode | Restart OpenCode, or pin/update the `#vX.Y.Z` suffix in `opencode.json` |
| Gemini CLI | `gemini extensions update governed-agent-autonomy-skills` |
| Copilot CLI | `copilot plugin update governed-agent-autonomy-skills@governed-agent-autonomy-skills` |

## Non-Goals

This is not a runtime, CLI, model integration, or framework. It does not execute agents. It gives coding agents a compact GAAM operating discipline and the canon needed to apply it.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation, release, and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. GAAM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
