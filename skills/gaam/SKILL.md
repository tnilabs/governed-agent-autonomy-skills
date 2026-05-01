---
name: gaam
description: Use when building, changing, reviewing, or assessing AI-agent software with agent workflows, agent tool use, agent retrieval, delegated actions, approvals, autonomous task execution, agent handoffs, GAAM, agent governance, or agentic maturity
---

# Using Governed Agent Autonomy Model Skills

This gateway routes AI-agent and GAAM-relevant work. Pick one sibling and announce it in the literal form ``Using `<sibling-skill>` to <purpose>``.

## Trigger boundary

Use for AI software that retrieves knowledge, reads scoped context, calls tools, drafts or takes actions, uses approvals, coordinates handoffs, or carries an autonomy/governance claim. Skip ordinary non-agent changes.

## Routing

Pick the sibling whose trigger best fits the user's intent. Use the bare directory name in the announcement.

| User intent | Sibling |
| --- | --- |
| Assess an existing agent, readiness, maturity, audit, or due-diligence question | `gaam-assess` |
| Design a new agent workflow, tool/retrieval/action boundary, or target level | `gaam-design` |
| Implement or refactor agent code for retrieval, tools, approvals, delegated action, or a pattern/level | `gaam-implement` |
| Review a PR, change, claim, or evidence pack for an agent workflow | `gaam-review` |

## Hard rule

Do not produce assessment, design, implementation, or review output without first invoking the matching sibling. The gateway routes only.

## References

Reference material lives in each focused skill's bundled `references/` directory. Root `references/` files are kept in sync for humans and tests.
