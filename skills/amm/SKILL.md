---
name: amm
description: Use when a task mentions AMM, Agentic Maturity Model, AMM levels, agentic maturity, enterprise agent design, enterprise agent review, agent governance, or agent compliance assessment
---

# Using Agentic Maturity Model Skills

This is the gateway. AMM-relevant work routes through one of four sibling skills. The gateway picks one and announces the choice in the literal form ``Using `<sibling-skill>` to <purpose>``; the host's native skill resolution loads the chosen sibling.

## Routing

Pick the sibling whose trigger best fits the user's intent. Use the bare directory name in the announcement.

| User intent                                              | Sibling         |
|----------------------------------------------------------|-----------------|
| "What AMM level are we at?", audit, due-diligence review | `amm-assess`    |
| "Design an enterprise agent", new product idea           | `amm-design`    |
| "Apply pattern X", "implement L5 read-only tools"        | `amm-implement` |
| "Review this PR for AMM compliance", evidence-pack check | `amm-review`    |

## Hard rule

Do not produce assessment, design, implementation, or review output without first invoking the matching sibling. The discipline (synonym-guided matching, control activation map, exit criteria, output templates) lives in the siblings; the gateway routes only.

## Canon

Canonical AMM, control, pattern, and synonym-map material lives in each focused skill's bundled `references/` directory. Root `references/` files are kept in sync for humans and tests. The plugin does not fetch from external sources.
