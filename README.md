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

## Non-Goals

This is not a runtime, CLI, model integration, or framework. It does not execute agents.

This is not a literal-name checklist. Local names are fine when the behavior and evidence are equivalent.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for validation and contribution rules.

## License

Code, scripts, plugin manifests, tests, and machine-readable integration files are licensed under Apache License 2.0. GAAM skill/reference prose and documentation are licensed under CC BY 4.0. See [`LICENSE`](LICENSE).
