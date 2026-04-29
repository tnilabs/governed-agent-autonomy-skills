---
name: using-agentic-blueprints
description: Use when a task mentions AMM, Agentic Maturity Model, AMM levels, agentic maturity, enterprise agent design, enterprise agent review, agent governance, or agent compliance assessment
---

# Using Agentic Blueprints Skills

This is the gateway. AMM-relevant work routes through one of four sibling skills. The gateway picks one and announces the choice in the literal form ``Using `<sibling-skill>` to <purpose>``; the host's native skill resolution loads the chosen sibling.

## Routing

Pick the sibling whose trigger best fits the user's intent. Use the bare directory name in the announcement.

| User intent                                              | Sibling                        |
|----------------------------------------------------------|--------------------------------|
| "What AMM level are we at?", audit, due-diligence review | `assessing-amm-level`          |
| "Design an enterprise agent", new product idea           | `designing-enterprise-agent`   |
| "Apply pattern X", "implement L5 read-only tools"        | `implementing-amm-patterns`    |
| "Review this PR for AMM compliance", evidence-pack check | `reviewing-enterprise-agent`   |

## Hard rule

Do not produce assessment, design, implementation, or review output without first invoking the matching sibling. The discipline (rosetta-driven recognition, control activation map, exit criteria, output templates) lives in the siblings; the gateway routes only.

## Canon

Canonical AMM, control, pattern, and rosetta material lives in `references/amm-levels.md`, `references/controls.md`, `references/patterns.md`, and `references/rosetta.md`. Siblings load them on demand. The plugin does not fetch from external sources.
