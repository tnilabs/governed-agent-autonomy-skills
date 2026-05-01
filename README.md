# governed-agent-autonomy-skills

Skills for coding agents that work with the Governed Agent Autonomy Model (GAAM).

Use them when you want an AI coding agent to:

- assess what GAAM level an agent workflow is actually at;
- design a new agent workflow for a target level;
- implement a GAAM capability in code;
- review a PR or evidence pack against a claimed level.

Core model repo: [tnilabs/governed-agent-autonomy](https://github.com/tnilabs/governed-agent-autonomy)

This skills repo is standalone. It ships its own GAAM level, control, pattern, and synonym references. Installed skills do not fetch anything from the core model repo at runtime.

## Skills

| Skill | Use For | Output |
| --- | --- | --- |
| `gaam` | Router when you are not sure which skill to use. | Chooses one focused skill. |
| `gaam-assess` | Find the real GAAM level of a workflow. | Evidence report, observed level, first missing boundary. |
| `gaam-design` | Design a workflow for a target GAAM level. | Design brief with authority, controls, evidence, tests. |
| `gaam-implement` | Add a GAAM capability to a repo. | Implementation plan or code changes with tests first. |
| `gaam-review` | Review a PR, change, or evidence pack. | Pass/fail review with blockers and searched evidence. |

GAAM names are labels, not required class names. Your code can call things whatever it wants. The skills look for equivalent behavior: same workflow, authority boundary, evidence, runtime boundary, and failure prevention.

## How To Prompt

Keep prompts short. Name the workflow and the level if you know it.

```text
Use gaam-assess to assess the support triage workflow.
```

```text
Use gaam-design to design an L6 account update agent.
```

```text
Use gaam-implement to add L6-one-shot-action-authority.
```

```text
Use gaam-review to review this PR for claimed L6.
```

Add context when useful:

```text
Workflow: account updates.
Claimed level: L6.
Evidence may be in src/actions, tests/actions, docs/security, and telemetry dashboards.
Do not assume names must match GAAM.
```

## What Each Skill Needs

### `gaam-assess`

Give it:

- workflow name;
- claimed level, if any;
- where to look for evidence;
- known out-of-repo evidence, such as dashboards or tickets.

It checks all levels L1 through L10. The observed level is the highest complete prefix. If L3 is missing but L6-looking code exists, the observed level is still L2 and the L6-looking code is reported as partial higher-level evidence.

### `gaam-design`

Give it:

- target level;
- what the agent may do;
- what the agent must not do;
- data sources and tools;
- owner and risk constraints.

It returns a design brief: target level, authority boundary, active controls, required patterns, evidence, tests, and open questions.

### `gaam-implement`

Give it:

- target pattern or level;
- workflow boundary;
- files/packages to inspect;
- whether it should edit code or only plan.

It searches for existing equivalents first. If code is missing, it writes the functional-signature test before implementation.

### `gaam-review`

Give it:

- claimed level;
- workflow scope;
- PR or artifact locations;
- evidence pack location, if one exists.

It checks artifacts, not just the design doc. A missing finding must include what was searched before calling it missing.

## GAAM Levels

Each level includes the previous levels.

| Level | Name | Developer Meaning |
| --- | --- | --- |
| L1 | Unmanaged AI Baseline | Measure today's manual or unmanaged AI work. |
| L2 | Process & Policy Contract | Write down the human workflow, owners, policies, and threat model. |
| L3 | Grounded Knowledge | Use reviewed, classified knowledge with retrieval tests. |
| L4 | Reviewed Assistance | AI drafts only. Human review is required. No side effects. |
| L5 | Scoped Read Access | AI can use scoped, audited, read-only tools. |
| L6 | Approved Action | AI can execute one exact approved action with replay and recovery controls. |
| L7 | Bounded Task Agency | AI owns a bounded task under signed goal, budget, and stop rules. |
| L8 | Verified Agent Coordination | Multiple agents coordinate through verified identities and typed handoffs. |
| L9 | Policy-Gated Autonomy | Low-risk eligible work can run through signed policy gates. |
| L10 | Governed Improvement Loop | Improvements go through proposals, tests, reviews, and release gates. |

L1-L3 are setup evidence. Runtime assessment becomes much more concrete at L4.

## Controls

Controls turn on at a level and stay on after that.

| Control | Starts | Developer Meaning |
| --- | --- | --- |
| Data, Context & Memory Governance | L3 | Control data, context, redaction, retention, tenants, and memory. |
| Threat & Adversarial Resilience | L4 | Handle prompt injection, poisoning, tampering, and adversarial tests. |
| Evidence & Assurance | L4 | Keep auditable proof of runs, reviews, evals, approvals, and releases. |
| Runtime Isolation & Execution Safety | L4 | Bound filesystem, network, subprocess, workspace, cleanup, and retries. |
| Observability & Telemetry | L4 | Correlate model, retrieval, tool, approval, incident, cost, and release events. |
| Value, Cost & Reliability | L4 | Track latency, cost, retries, SLOs, outcomes, and reliability. |
| Delegated Authority & Access | L5 | Use scoped grants, one-shot action authority, revocation, and delegation. |
| Tool & Protocol Safety | L5 | Keep tool and protocol surfaces aligned with runtime contracts. |
| Incident Response & Recovery | L6 | Support rollback, compensation, replay, pause, dead-letter, and postmortems. |
| Agent Registry & Lifecycle | L7 | Track agent identity, owner, version, risk tier, health, pause, and deprecation. |

## Example Outputs

`gaam-assess`:

```markdown
# GAAM Assessment

- Claimed level: L5
- Observed level: L2
- Workflow: support triage
- Lowest failing boundary: L3 Grounded Knowledge

## Partial Higher-Level Evidence
- L5 scoped grants exist in src/auth/grants.ts, but L3 and L4 are incomplete.
```

`gaam-design`:

```yaml
gaam:
  target_level: L6
claim:
  workflow: account update
  allowed_authority: execute one approved account-update action
  excluded_authority: eligibility decisions, bulk updates, reviewer bypass
controls:
  - gaam_anchor: Delegated Authority & Access
    local_name: one-shot account-update authority
patterns:
  - pattern: L6-one-shot-action-authority
```

`gaam-implement`:

```markdown
# Implementation Record: L6-one-shot-action-authority

- Workflow: account update
- Test first: same authority grant cannot execute twice
- Test first: same authority grant cannot execute a different action
- Test first: expired or revoked authority fails closed
```

`gaam-review`:

```markdown
# GAAM Review: PR-1042

- Claimed level: L6
- Verified level: L5
- Verdict: NEEDS-FIX

## Blocker
- Approved actions are not bound to the exact action payload.
- Searched: binding hash, approval ledger, reviewer signoff, action digest.
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

The skills read bundled Markdown references:

- [`references/gaam-levels.md`](references/gaam-levels.md)
- [`references/controls.md`](references/controls.md)
- [`references/patterns.md`](references/patterns.md)
- [`references/synonyms.md`](references/synonyms.md)

Focused skills also include local copies of those references for plugin hosts that restrict file access.

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

This is not a runtime, CLI, model integration, or framework. It does not execute agents.

This is not a literal-name checklist. Local names are fine when the behavior and evidence are equivalent.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. GAAM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
