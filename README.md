# governed-agent-autonomy-skills

Skills that help coding agents assess, design, implement, and review enterprise AI agents against the Governed Agent Autonomy Model (GAAM).

This repo is standalone. The GAAM levels, controls, capability patterns, synonym rules, and detection guidance ship with the skills. Installed skills do not fetch canon from another repository at runtime.

## What You Get

- Evidence-first assessment: classify what a workflow actually supports, not what a team claims.
- Plain design briefs: turn an agent idea into target level, authority boundary, controls, evidence, tests, and open questions.
- Implementation discipline: add GAAM capabilities to existing code with functional-signature tests first.
- Pre-merge review: verify claimed levels against artifacts, not slideware.
- Naming-agnostic matching: local services, schemas, tickets, logs, dashboards, and event streams can satisfy GAAM when they prove the same function.

GAAM names are trace handles, not required names in your code. The skills search for semantic equivalents: workflow context, authority boundary, capability, evidence semantics, runtime boundary, and prevented failure.

## Skills

| Skill | Use It When | What It Produces |
| --- | --- | --- |
| `gaam` | Your request mentions GAAM, agent governance, agent compliance, or a level, but you have not chosen the exact task. | A route to one focused skill. It does not do the work itself. |
| `gaam-assess` | You need the observed GAAM level of an existing workflow, repo, or agent system. | L1-L10 evidence report, observed level, lowest failing boundary, partial higher-level evidence, and semantic gaps. |
| `gaam-design` | You are designing a new agent workflow or planning a move to a target level. | Target-level design brief with allowed/excluded authority, active controls, patterns, evidence, tests, and open questions. |
| `gaam-implement` | You want to add or strengthen a GAAM capability in code. | Implementation record with existing-capability survey, file touch list, functional-signature test, code plan, and verification gates. |
| `gaam-review` | You are reviewing a PR, change set, evidence pack, or claimed level. | Merge-oriented review with pass/fail findings, recorded conceptual-equivalence searches, blockers, and follow-ups. |

## Skill Details

### `gaam`

Use this as the front door when the task is broad. It chooses one focused skill and announces the choice in the form `Using <skill> to <purpose>`.

Give it:

- the natural-language task;
- the workflow or repo if known;
- the level or claim if known.

Bad prompts:

- `Use gaam to assess and design and implement the whole thing.`
- `Use gaam to write the final review.` The gateway only routes.

### `gaam-assess`

Use this to classify reality. It scans L1 through L10 and reports the highest fully satisfied prefix. Later evidence is still recorded, but it does not raise the observed level when an earlier boundary is missing.

Give it:

- workflow being assessed;
- scope, period, and claimed level if any;
- where evidence may live: code, docs, tests, telemetry, dashboards, tickets, or external systems;
- known exclusions, such as systems the repo does not contain.

Expected output:

- canon versions used;
- claim context;
- observed level;
- evidence per level;
- lowest failing boundary;
- partial higher-level evidence;
- semantic gaps and exact searches performed.

Bad prompts:

- `What level is this repo?` No workflow, scope, or evidence locations.
- `They use LangGraph, so call it L8.` Framework choice is not a level.
- `Trust the team's L7 claim.` Self-claim is not evidence.

### `gaam-design`

Use this before building. The output is a production design brief, not a brainstorm.

Give it:

- target GAAM level;
- workflow and work-item scope;
- allowed authority and excluded authority;
- owner and reassessment triggers;
- data sources, side-effect surfaces, risk tolerance, reliability needs, and cost constraints.

Expected output:

- `gaam-agent.yaml`-shaped brief;
- active controls for the target level;
- all required pattern entries through the target level;
- terminology map from GAAM anchors to local names;
- evidence pack requirements;
- threat assumptions, exit criteria, and open questions.

Bad prompts:

- `Design an L8 agent.` Missing workflow and authority boundary.
- `We'll add controls later.` Controls are part of the level claim.
- `Use these exact GAAM record names.` GAAM does not require specific record names.

### `gaam-implement`

Use this when a GAAM capability should land in a codebase. The skill first searches for local equivalents, then strengthens what exists or designs the smallest missing piece.

Give it:

- target pattern ID or level boundary;
- workflow and authority boundary;
- files or packages likely involved;
- whether edits are allowed or the output should be plan-only.

Expected output:

- existing-capability survey;
- user-team mapping to GAAM anchors;
- file touch list;
- functional-signature test that lands first;
- implementation steps;
- contract changes and verification gates.

Bad prompts:

- `Just add the code, skip tests.` Functional-signature test comes first.
- `Rename our local services to GAAM names.` Preserve local names and map them.
- `Add approval binding but skip recovery metadata.` Pattern requirements are not optional decoration.

### `gaam-review`

Use this before trusting a GAAM claim. It checks artifacts, not just the design brief. A missing finding is invalid unless the skill first records the conceptual-equivalence or artifact search it performed.

Give it:

- claimed level and workflow scope;
- PR, branch, diff, or artifact locations;
- evidence pack location;
- merge acceptance criteria.

Expected output:

- verified level;
- control activation verdicts;
- pattern integration verdicts;
- missing or not-satisfied findings with searches and locations;
- threat-model deltas;
- follow-up tasks;
- final verdict.

Bad prompts:

- `Read the design doc and say if it looks right.` Review checks artifacts.
- `Mark it missing if names do not match GAAM.` Different names can be equivalent.
- `Skip the search; this PR is small.` Missing findings require recorded searches.

## Prompt Recipes

| Goal | Prompt |
| --- | --- |
| Baseline a workflow | `Use gaam-assess to classify the <workflow> GAAM level. Use evidence only. Continue through L10 and separate observed level from partial higher-level evidence.` |
| Design one level up | `Use gaam-design to design the smallest safe path from observed L<n> to target L<n+1> for <workflow>. Include authority boundaries, controls, evidence, tests, and stop conditions.` |
| Plan without edits | `Use gaam-implement to plan the required GAAM pattern entries for <workflow>. Do not edit files yet. Include file touch list and functional-signature tests.` |
| Implement one capability | `Use gaam-implement to implement <pattern-id> for <workflow>. Preserve local names. Write the functional-signature test first.` |
| Review a PR | `Use gaam-review to check this PR's claimed GAAM L<n> compliance. List conceptual-equivalence searches before marking anything missing.` |
| Validate an evidence pack | `Use gaam-review to validate this evidence pack for <workflow> at GAAM L<n>. Verify controls, patterns, telemetry, approvals, recovery, and residual gaps.` |

## GAAM Levels Supported

Each level includes all prior levels. A claim at L6 requires L1 through L6 to be satisfied.

| Level | Name | Plain Meaning |
| --- | --- | --- |
| L1 | Unmanaged AI Baseline | Measure current manual or unmanaged AI work so improvement claims have a real baseline. |
| L2 | Process & Policy Contract | Make the human workflow explicit: stages, owners, policies, templates, validations, and threat model. |
| L3 | Grounded Knowledge | Build reviewed, classified, retrievable knowledge with coverage mapping and golden retrieval evals. |
| L4 | Reviewed Assistance | AI drafts from cited evidence and stops at human review. No side effects. |
| L5 | Scoped Read Access | AI gets typed, scoped, audited read-only tool access. Still no side-effecting actions. |
| L6 | Approved Action | One specific approved side-effecting action may execute with exact binding, one-shot authority, idempotency, and recovery metadata. |
| L7 | Bounded Task Agency | An agent owns a bounded task package under signed goal, budget, stop reason, and memory controls. |
| L8 | Verified Agent Coordination | Multiple agents coordinate through verified identities, typed handoffs, validator decisions, and durable checkpoints. |
| L9 | Policy-Gated Autonomy | Eligible low-risk work can run without routine approval, gated by signed policy, pause, dead-letter, and adversarial evaluation. |
| L10 | Governed Improvement Loop | Improvements become reviewed proposals with evidence, regression tests, safety gates, and release decisions. |

L1-L3 are preparation evidence. Reliable runtime assessment starts at L4, where review boundaries, evidence, telemetry, and control surfaces become observable.

## Controls Supported

Controls activate at a level and remain active above it.

| Control | Introduced | Plain Meaning |
| --- | --- | --- |
| Data, Context & Memory Governance | L3 | Control classification, provenance, redaction, retention, residency, tenant boundaries, context assembly, and memory behavior. |
| Threat & Adversarial Resilience | L4 | Detect hostile input, prompt injection, poisoning, tampering, and adversarial regressions before they gain authority. |
| Evidence & Assurance | L4 | Produce defensible run, review, eval, audit, approval, limitation, rollback, handoff, and release evidence. |
| Runtime Isolation & Execution Safety | L4 | Bound filesystem, network, subprocess, workspace, artifact, retry, cleanup, and code-execution behavior. |
| Observability & Telemetry | L4 | Join model, retrieval, tool, review, approval, incident, cost, and release signals with correlation IDs. |
| Value, Cost & Reliability | L4 | Track cost, latency, retry, SLO, outcome, review burden, and risk-adjusted value. |
| Delegated Authority & Access | L5 | Issue scoped read grants, one-shot action authority, delegation, revocation, and on-behalf-of evidence. |
| Tool & Protocol Safety | L5 | Keep tools and protocol surfaces derived from runtime contracts and fail closed on drift. |
| Incident Response & Recovery | L6 | Support rollback, compensation, replay, pause, dead-letter, containment, and postmortem evidence. |
| Agent Registry & Lifecycle | L7 | Track agent identity, owner, version, risk tier, lifecycle state, health, pause, revocation, and deprecation. |

## Example Outputs

`gaam-assess`:

```markdown
# GAAM Assessment

- Canon versions: gaam-levels v3.0.0, controls v3.0.0, patterns v3.0.0, synonyms v3.0.0
- Claimed level: L5
- Observed level: L2
- Claim context: workflow=support triage; scope=customer support tickets; period=current main; allowed/excluded authority=analysis only/no side effects; owner=support platform
- Assessment band note: L1-L3 are preparation evidence; reliable runtime assessment starts at L4.
- Confidence: medium - workflow artifacts exist, but no L3 retrieval evidence was found

## Lowest failing boundary
- L3 grounded knowledge - add reviewed knowledge index, coverage map, and golden retrieval evals

## Partial higher-level evidence
- L5 scoped grants exist in `src/auth/grants.ts`, but L3/L4 are incomplete, so they do not raise the observed level
```

`gaam-design`:

```yaml
gaam:
  target_level: L6
  canon_versions: { gaam_levels: "3.0.0", controls: "3.0.0", patterns: "3.0.0", synonyms: "3.0.0" }
claim:
  workflow: account update
  scope: support-agent updates to verified customer account fields
  allowed_authority: read profile and policy data; execute one approved account-update action
  excluded_authority: eligibility decisions, bulk updates, reviewer bypass, autonomous closure
  owner: support platform
controls:
  - gaam_anchor: Delegated Authority & Access
    local_name: one-shot account-update authority
    evidence: action-bound authority grant consumed exactly once
patterns:
  - level: L6
    pattern: L6-one-shot-action-authority
    functional_signature: approved action authority is action-bound and consumed once
    test_asserts: same grant cannot execute twice or execute a different action
```

`gaam-implement`:

```markdown
# Implementation Record: L6-one-shot-action-authority

- Pattern entry: L6-one-shot-action-authority
- Claim context: workflow=account update; scope=support-agent account updates; allowed/excluded authority=one approved action/no reviewer bypass; owner=support platform
- User-team mapping: account update approval ticket -> exact-action approval evidence

## Functional-signature test
- Same authority grant cannot execute twice.
- Same authority grant cannot execute a different action payload.
- Expired or revoked authority fails closed.
```

`gaam-review`:

```markdown
# GAAM Review: PR-1042

- Claimed level: L6
- Verified level: L5
- Verdict: NEEDS-FIX

## Missing / not-satisfied findings
- BLOCKER: approved actions are not bound to the exact action payload.
  - Signals searched: binding hash, approval ledger, reviewer signoff, action digest, equivalent approval workflow
  - Locations: src/actions/execute.ts, tests/actions/
  - Required fix: verify signed approval and bind by digest before issuing one-shot authority
```

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
- [`references/synonyms.md`](references/synonyms.md): alternative names, conceptual-equivalence rules, and detection signals.

Focused skills also include local copies of those reference files so installed-plugin hosts can read the canon even when they restrict access outside a skill directory. Tests enforce that the copies match the root references exactly.

For headless Claude Code validation, plugin skill references may need the plugin cache added as a readable directory:

```bash
claude -p "Use gaam-assess to classify this repo" \
  --settings ~/.claude/settings.json \
  --add-dir ~/.claude/plugins/cache \
  --allowedTools Read,Glob,Grep
```

## Refresh

| Tool | Update Command |
| --- | --- |
| Claude Code | `/plugin marketplace update governed-agent-autonomy-skills` then `/plugin update governed-agent-autonomy-skills` |
| Codex CLI / App | `cd ~/.codex/governed-agent-autonomy-skills && git pull`, then restart Codex |
| Cursor | `cd ~/.cursor/governed-agent-autonomy-skills-src && git pull`, then reload Cursor |
| OpenCode | Restart OpenCode, or pin/update the `#vX.Y.Z` suffix in `opencode.json` |
| Gemini CLI | `gemini extensions update governed-agent-autonomy-skills` |
| Copilot CLI | `copilot plugin update governed-agent-autonomy-skills@governed-agent-autonomy-skills` |

## Non-Goals

This is not a runtime, CLI, model integration, or framework. It does not execute agents. It gives coding agents a compact GAAM operating discipline and the canon needed to apply it.

It is not a literal-name checklist. A local event stream, schema, service, ticket, log, dashboard, or external evidence store can satisfy a GAAM item when it proves the same function.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. GAAM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
