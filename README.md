# governed-agent-autonomy-skills

Call it governance, production readiness, or just not getting surprised later: AI agents need clear answers for what they can do, what they must prove, who reviews them, and how recovery works.

Those questions usually show up after the risky part has already shipped. These skills move them into the build path, so authority, evidence, review, and recovery boundaries get handled while the agent is still being designed and coded.

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

To avoid saying `Use gaam...` every time, add this to your repo's `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or equivalent project instruction file:

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

## Direct Prompts

Explicit prompts still work. Keep them short. Name the workflow and the level if you know it.

```text
Use gaam-assess to assess the support triage workflow.
Use gaam-design to design an L6 account update agent.
Use gaam-implement to add one-shot approved action authority to the account update workflow.
Use gaam-review to review this PR for claimed L6.
```

## Example Outputs

Real output should name evidence, gaps, and next steps.

```markdown
# GAAM Assessment: Support Routing

- Claimed level: L5
- Observed level: L4
- Gap: customer lookup uses a shared admin grant, not a workflow-scoped read grant.
- Searched: workflow docs, retrieval tests, runtime tools, audit events.
- Next step: add a support-routing read grant and audit event before claiming L5.
```

```yaml
workflow: customer email change
target: L6 approved action
agent_may:
  - execute one approved email update
agent_must_not:
  - decide eligibility
  - reuse the same approval
required_evidence:
  - approval is bound to customer id and new email
  - expired, revoked, and already-used approvals fail closed
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
