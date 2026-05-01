# governed-agent-autonomy-skills

Skills for coding agents that design, build, assess, and review governed AI-agent workflows.

Use them when software work involves building an AI agent, or changing agent retrieval, tool use, scoped data access, delegated actions, approval gates, autonomous tasks, agent handoffs, or GAAM claims. The skills can be called directly, but they are more useful when your project instructions tell the coding agent to check the gateway automatically.

Core model repo: [tnilabs/governed-agent-autonomy](https://github.com/tnilabs/governed-agent-autonomy)

This skills repo is standalone. It ships its own GAAM level, control, pattern, and synonym references. Installed skills do not fetch anything from the core model repo at runtime.

## Skills

| Skill | Use For | Output |
| --- | --- | --- |
| `gaam` | Preflight router for AI-agent or GAAM-relevant work. | Chooses one focused skill. |
| `gaam-assess` | Assess an existing agent workflow, maturity claim, audit, or readiness gap. | Evidence report, observed level, first missing boundary. |
| `gaam-design` | Design an agent workflow, tool/retrieval/action boundary, or target-level specification. | Design brief with authority, controls, evidence, tests. |
| `gaam-implement` | Build or refactor agent code for retrieval, tools, approvals, delegated actions, or GAAM exit criteria. | Implementation plan or code changes with tests first. |
| `gaam-review` | Review an agent PR, change, claimed level, or evidence pack. | Pass/fail review with blockers and searched evidence. |

GAAM names are labels, not required class names. Your code can call things whatever it wants. The skills look for equivalent behavior: same workflow, authority boundary, evidence, runtime boundary, and failure prevention.

## Automatic Use

To avoid saying `Use gaam...` every time, add a rule like this to your repo's `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or equivalent project instruction file:

```markdown
## AI agent work

Before designing, implementing, or reviewing software that includes an AI agent,
agent workflow, tool use, retrieval, scoped data access, delegated action,
approval gate, autonomous task execution, or agent-to-agent handoff, check
whether the `gaam` skill applies.

If it applies, load `gaam` and let it route to `gaam-design`,
`gaam-implement`, `gaam-assess`, or `gaam-review`.

Do not use GAAM for ordinary software changes with no AI or agent workflow.
```

After that, normal software requests should be enough:

```text
Build a support routing agent that can read customer history and draft a reply.
```

```text
Add approval-gated email changes to the account update agent.
```

```text
Review this PR for the billing dispute agent.
```

Automatic use still depends on the host tool's skill matching and project-instruction behavior. The gateway trigger is broad enough for AI-agent work, but the project rule above makes the intended behavior explicit.

## Direct Prompts

Explicit prompts still work. Keep them short. Name the workflow and the level if you know it.

```text
Use gaam-assess to assess the support triage workflow.
```

```text
Use gaam-design to design an L6 account update agent.
```

```text
Use gaam-implement to add one-shot approved action authority to the account update workflow.
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

## What To Tell The Agent

You do not need to fill out a form. Start with the workflow and what you want the agent to do.

For assessment, name the workflow or repo area and any claimed level. The skill will look for evidence and report the level that is actually supported.

For design, describe what the agent should be allowed to do, what it must not do, what data and tools it can use, and who owns the risk.

For implementation, name the workflow and point to the relevant files or packages. Say whether you want code changes or only a plan. The skill should look for existing equivalents before adding new structures, then write behavior tests before implementation.

For review, point to the PR, diff, or evidence pack and say what claim is being checked. The skill should inspect artifacts, not just the design doc, and should name what it searched before saying something is missing.

## Example Outputs

These examples are shortened, but they show the kind of evidence the skills should name. Real output should say what was searched, what was found, what is missing, and what to do next.

### `gaam-assess`

```markdown
# GAAM Assessment: Support Ticket Routing

- Claimed level: L5
- Observed level: L4
- Workflow: classify inbound support tickets and draft routing notes
- Lowest failing boundary: L5 scoped read access

## Evidence Checked
- Workflow doc: docs/support-routing.md defines owner, review step, and escalation policy.
- Knowledge source: src/retrieval/supportKb.ts filters to reviewed help-center articles.
- Tests: tests/retrieval/supportKb.test.ts covers stale article exclusion.
- Runtime: src/agents/supportRouter.ts drafts a route recommendation but does not call ticketing APIs.

## Gap
- The agent can read customer records through src/tools/customerLookup.ts, but the grant is shared with the admin service and is not scoped to this workflow.

## Next Step
- Add a workflow-specific read grant and audit event before claiming L5.
```

### `gaam-design`

```yaml
workflow: customer email change
target: L6 approved action
agent_may:
  - validate a signed support approval
  - update exactly one customer's email address
  - write an audit record with the approval id and payload hash
agent_must_not:
  - decide whether the customer is eligible
  - change any other customer fields
  - reuse the same approval for a second update
required_evidence:
  - approval record is bound to the exact customer id and new email
  - expired, revoked, or already-used approvals fail closed
  - replay and rollback path is documented and tested
open_questions:
  - Which system owns approval revocation events?
  - Where should failed update attempts be monitored?
```

### `gaam-implement`

```markdown
# Implementation Plan: One-Use Approval For Email Changes

Workflow: customer email change
Files inspected: src/account/emailChange.ts, src/approvals/store.ts, tests/account/emailChange.test.ts

Tests to add first:
- rejects an approval whose payload hash does not match the requested email change
- rejects a second execution with the same approval id
- records a compensating action when the downstream profile update fails

Implementation steps:
- Add payload hash verification before calling updateCustomerEmail.
- Mark the approval consumed in the same transaction as the action record.
- Emit account.email_change.approved_action with approval id, actor, and result.
```

### `gaam-review`

```markdown
# GAAM Review: PR 1042

- Claimed level: L6
- Verified level: L5
- Verdict: NEEDS-FIX

## What Passed
- Approval is required before the account update endpoint runs.
- Approval ids are logged in the account_update_audit table.
- Revoked approvals are rejected by tests/accountUpdateApproval.test.ts.

## Blocker
- The approval is bound to the customer id, but not to the requested field changes. A reused approval could change a different email value.

## Searched
- src/account/updateAccount.ts for payload digest or field-level binding
- src/approvals/approvalLedger.ts for consumed-action records
- tests/accountUpdateApproval.test.ts for replay and mismatch coverage
- docs/runbooks/account-update-recovery.md for rollback evidence
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

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. GAAM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
