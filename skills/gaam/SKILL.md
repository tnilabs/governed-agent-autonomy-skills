---
name: gaam
description: Use when a task mentions GAAM, Governed Agent Autonomy Model, GAAM levels, agentic maturity, enterprise agent design, enterprise agent review, agent governance, or agent compliance assessment
---

# Using Governed Agent Autonomy Model Skills

This is the gateway. GAAM-relevant work routes through one of four sibling skills. The gateway picks one and announces the choice in the literal form ``Using `<sibling-skill>` to <purpose>``; the host's native skill resolution loads the chosen sibling.

## Routing

Pick the sibling whose trigger best fits the user's intent. Use the bare directory name in the announcement.

| User intent                                              | Sibling         |
|----------------------------------------------------------|-----------------|
| "What GAAM level are we at?", audit, due-diligence review | `gaam-assess`    |
| "Design an enterprise agent", new product idea           | `gaam-design`    |
| "Apply pattern X", "implement L5 scoped read access"        | `gaam-implement` |
| "Review this PR for GAAM compliance", evidence-pack check | `gaam-review`    |

## Hard rule

Do not produce assessment, design, implementation, or review output without first invoking the matching sibling. The discipline (conceptual-equivalence matching, control activation map, exit criteria, output templates) lives in the siblings; the gateway routes only.

## Canon

Canonical GAAM, control, pattern, and synonym-map material lives in each focused skill's bundled `references/` directory. Root `references/` files are kept in sync for humans and tests. The plugin does not fetch from external sources.
