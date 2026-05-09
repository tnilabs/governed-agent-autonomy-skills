---
name: gaam
description: Use when building, changing, reviewing, or assessing AI-agent software with agent workflows, agent tool use, agent retrieval, delegated actions, approvals, autonomous task execution, agent handoffs, GAAM, agent governance, or agentic maturity
---

# Using Governed Agent Autonomy Model Skills

Route GAAM work. Announce ``Using `<sibling-skill>` to <purpose>``.

## Trigger boundary

Use for AI software that retrieves knowledge, reads scoped context, calls tools, drafts/takes actions, uses approvals, coordinates handoffs, or carries autonomy/governance claims. Skip ordinary non-agent changes.

## Level rule

Never assume L7 or any target level. For assessment/review, treat an unstated claim as unstated and verify evidence. For design/implementation, ask for target level or authority boundary before writing.

## Routing

Pick the sibling matching intent. Use its bare directory name.

| User intent | Sibling |
| --- | --- |
| Assess an existing agent, readiness, maturity, audit, or due-diligence question | `gaam-assess` |
| Design a new agent workflow, tool/retrieval/action boundary, or target level | `gaam-design` |
| Implement or refactor agent code for retrieval, tools, approvals, delegated action, or a pattern/level | `gaam-implement` |
| Review a PR, change, claim, or evidence pack for an agent workflow | `gaam-review` |

## Hard rule

Do not produce assessment, design, implementation, or review output without first invoking the matching sibling. The gateway routes only.
