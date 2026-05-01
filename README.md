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

## Which Skill To Use

This package ships one gateway skill and four focused skills. The gateway is useful when you want the agent to choose; the focused skills are better when you already know the job.

| Skill | Use when | Give it | It returns |
| --- | --- | --- | --- |
| `gaam` | The request mentions GAAM, agent governance, agent compliance, or a GAAM level, but the exact task type is not clear. | The natural-language task. | A routed sibling skill announcement. The gateway does not do assessment, design, implementation, or review itself. |
| `gaam-assess` | You need to know the observed GAAM level of an existing workflow or repo. | Workflow scope, claimed level if any, evidence locations, time period, and known out-of-repo systems. | An evidence-first L1-L10 assessment with observed level, lowest failing boundary, partial higher-level evidence, and semantic gaps. |
| `gaam-design` | You are designing a new agent workflow or target-level upgrade. | Workflow, target level, allowed authority, excluded authority, owner, risk tolerance, and production domain. | A target-level design brief with active controls, capability patterns, evidence obligations, threat assumptions, and open questions. |
| `gaam-implement` | You want to add or strengthen a GAAM capability in code. | Pattern ID or target level, repo area, workflow boundary, allowed authority, and whether edits are allowed. | An implementation record: existing-capability survey, file touch list, functional-signature test, code plan, and verification gates. |
| `gaam-review` | You are reviewing a PR, change set, evidence pack, or claimed GAAM level before merge or release. | Claimed level, diff or artifact locations, workflow scope, evidence pack, and acceptance criteria. | A merge-oriented review with pass/fail findings, recorded conceptual-equivalence searches, blockers, and follow-up tasks. |

The skills are intentionally evidence-bound. A framework name, a self-claim, or a matching file name is not enough. A differently named local service, schema, event stream, workflow, or external evidence store can satisfy GAAM when it proves the same workflow context, authority boundary, capability, evidence semantics, runtime boundary, and failure prevention.

## Skill Contracts

### `gaam`

Use this as the front door when the prompt is broad: "assess this", "design an agent", "review this PR", or "help with GAAM". It routes to exactly one focused skill and announces that choice. If you already know the correct skill, call it directly.

Example:

```text
Use gaam to decide how to handle this request: review this support-agent PR against GAAM L6.
```

### `gaam-assess`

Use this to classify reality. It scans all levels L1-L10 and reports the highest fully satisfied prefix. It still records later evidence, but later evidence does not raise the observed level when an earlier boundary is missing.

Best prompts include:

- the workflow being assessed;
- the time period or release being assessed;
- the claimed level, if someone made one;
- where evidence may live, including docs, tests, telemetry, tickets, dashboards, or external systems.

Example:

```text
Use gaam-assess to classify the support triage workflow. Claimed level is L5. Evidence may be in docs/, tests/, observability dashboards, and the ticketing integration. Use evidence only and list every missing-boundary search.
```

### `gaam-design`

Use this before building. The output is a production design brief, not a brainstorm. It should state what the agent may do, what it may not do, which controls are active at the target level, what evidence must be produced, and what would force reassessment.

Best prompts include:

- target GAAM level;
- user or work-item population;
- allowed and excluded authority;
- data sources and side-effect surfaces;
- security, compliance, reliability, and cost constraints.

Example:

```text
Use gaam-design to design a GAAM L6 account-update agent. It may read customer profile and policy data, draft an update, and execute one approved side-effecting action. It may not decide eligibility or bypass reviewer approval.
```

### `gaam-implement`

Use this when the desired GAAM capability should land in a repo. The skill first searches for semantic equivalents, then either strengthens existing code or designs the smallest missing piece. It requires a functional-signature test before implementation.

Best prompts include:

- the target pattern ID or level boundary;
- the workflow and authority boundary;
- files or packages likely involved;
- whether the agent should edit code or produce a plan only.

Example:

```text
Use gaam-implement to add L6-one-shot-action-authority for the account-update workflow. Edit code if needed. Preserve existing service names and add the functional-signature test first.
```

### `gaam-review`

Use this before trusting a GAAM claim. It verifies the claim against artifacts, not just the design doc. Missing findings must include the conceptual-equivalence search that was performed before deciding the capability is absent.

Best prompts include:

- the claimed level and workflow scope;
- the PR, branch, or artifact set to review;
- evidence pack locations;
- explicit merge or release criteria.

Example:

```text
Use gaam-review to verify this PR's GAAM L6 claim for account updates. Treat differently named approval, authority, telemetry, and recovery artifacts as possible equivalents, but block the PR if the exact-action approval binding is not evidenced.
```

## Prompt Recipes

| Goal | Prompt |
| --- | --- |
| Baseline a repo | `Use gaam-assess to classify this repo's observed GAAM level. Use evidence only. Continue through L10 and separate observed level from partial higher-level evidence.` |
| Design one level up | `Use gaam-design to design the smallest safe path from observed L<n> to target L<n+1> for <workflow>. Include active controls, evidence, authority boundaries, and stop conditions.` |
| Plan without edits | `Use gaam-implement to plan the required GAAM pattern entries for <workflow>. Do not edit files yet. Include file touch list and functional-signature tests.` |
| Implement a specific capability | `Use gaam-implement to implement <pattern-id> for <workflow>. Preserve local names. Write the functional-signature test first.` |
| Review a PR | `Use gaam-review to check this PR's claimed GAAM L<n> compliance. List conceptual-equivalence searches before marking anything missing.` |
| Validate an evidence pack | `Use gaam-review to validate this evidence pack for <workflow> at GAAM L<n>. Verify controls, patterns, telemetry, approvals, incidents, and residual gaps.` |

## Explicit Skill Names

Most tools load skills automatically from the prompt. When you want to be explicit, use the compact skill name:

```text
Use gaam-assess to classify this repo's observed GAAM level.
Use gaam-design to design a claims-processing agent at GAAM L6.
Use gaam-implement to plan L5 read-only tool manifests and audit evidence.
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
   `Use gaam-assess to classify <workflow>. Use evidence only.`
2. Pick a target level:
   `Use gaam-design to design the smallest safe path from observed L<n> to target L<n+1>.`
3. Plan implementation:
   `Use gaam-implement to plan the required GAAM pattern entries. Do not edit files yet.`
4. Implement one bounded capability:
   `Use gaam-implement to implement <pattern-id>. Write the functional-signature test first.`
5. Review before merge:
   `Use gaam-review to verify this PR against claimed GAAM L<n>.`

## Sample Output Shapes

`gaam-assess` produces an evidence report:

```markdown
# GAAM Assessment

- Canon versions: gaam-levels v3.0.0, controls v3.0.0, patterns v3.0.0, synonyms v3.0.0
- Claimed level: unstated
- Observed level: L2
- Claim context: workflow=support triage; scope=customer support tickets; period=current main branch; allowed/excluded authority=analysis only/no side effects; owner=support platform
- Confidence: medium - workflow artifacts exist, but no L3 retrieval evidence was found

## Terminology and conceptual mapping
| User-team structure/name | GAAM semantic anchor | Equivalent capability/evidence |
| --- | --- | --- |
| support run dossier | Evidence & Assurance | run, review, eval, audit, and approval evidence exported together |

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
gaam:
  target_level: L6
  canon_versions: { gaam_levels: "3.0.0", controls: "3.0.0", patterns: "3.0.0", synonyms: "3.0.0" }
claim:
  workflow: account update
  scope: support-agent updates to verified customer account fields
  allowed_authority: read customer profile and policy data; execute one approved account-update action
  excluded_authority: eligibility decisions, bulk updates, reviewer bypass, and autonomous closure
  owner: support platform
controls:
  - gaam_anchor: Threat & Adversarial Resilience
    local_name: hostile-input and approval-tamper gate
    evidence: detection events, signature checks, and adversarial eval results
  - gaam_anchor: Delegated Authority & Access
    local_name: one-shot account-update authority
    evidence: action-bound authority grant consumed exactly once
patterns:
  - level: L6
    pattern: L6-one-shot-action-authority
    functional_signature: approved action authority is action-bound and consumed once
    test_asserts: same grant cannot execute twice or execute a different action
open_questions:
  - Which account-update actions are eligible for L6 approval?
  - Which local approval artifact is the audit source of truth?
```

`gaam-review` produces merge-oriented findings:

```markdown
# GAAM Review

- Canon versions: gaam-levels v3.0.0, controls v3.0.0, patterns v3.0.0, synonyms v3.0.0
- Claimed level: L6
- Verified level: L5
- Claim context: workflow=account update; scope=support-agent updates; period=this PR; allowed/excluded authority=one approved action/no reviewer bypass; owner=support platform
- Verdict: NEEDS-FIX

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
