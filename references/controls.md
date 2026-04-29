---
canon_version: 1.0.0
last_reviewed: 2026-04-29
---

# Enterprise Control Categories

Nine control categories. Each control accumulates: once activated at AMM level *N*, it stays active at every higher level. The `Activated at AMM levels:` field in each section is the canonical activation set; tests validate it against the v1 matrix.

## Adversarial Awareness

- **What it does:** Detects and mitigates prompt injection, jailbreak attempts, supply-chain provenance failures, and adversarial inputs. Maintains a replay buffer of incidents for regression testing.
- **Evidence it produces:**
  - Per-input classifier scores (injection, jailbreak, suspicious provenance).
  - Refusal records with the triggering input class and the action taken.
  - Adversarial-eval suites that replay prior incidents.
  - Provenance records for every model artifact and tool definition.
- **Failure it prevents:** Silent compromise where an attacker steers the agent through crafted input or substrate, with no forensic trail and no protection against the same vector tomorrow.
- **Activated at AMM levels:** L4, L5, L6, L7, L8, L9, L10

## Agent Control Tower

- **What it does:** Inventories every agent in the system with owner, lifecycle stage, and runtime health. Provides the operator surface that lets a human pause, revoke, or roll back any agent.
- **Evidence it produces:**
  - An agent inventory with owner, lifecycle, and health per agent.
  - Operator action logs (pause, revoke, restart) with actor and reason.
  - Per-agent runtime health metrics over time.
  - A change log that ties operator actions to the agent's runtime state.
- **Failure it prevents:** Shadow agents running without ownership, no runtime visibility, and no kill switch when an agent misbehaves.
- **Activated at AMM levels:** L6, L7, L8, L9, L10

## Compliance Evidence Pack

- **What it does:** Aggregates run records, approval records, eval records, limitation statements, and rollback records into an exportable evidence bundle that an auditor can verify.
- **Evidence it produces:**
  - Signed run records with actor, decision, and outcome.
  - Approval records linking proposed changes to approvers.
  - Eval results bound to the artifact under test.
  - Limitation statements declaring what the agent does not do.
  - Rollback records and rollback-test results.
- **Failure it prevents:** Audit findings that the team cannot answer, because the evidence was never assembled or was scattered across systems.
- **Activated at AMM levels:** L4, L5, L6, L7, L8, L9, L10

## Credential and Delegated Access

- **What it does:** Issues scoped, time-bound credentials to agents. Tracks delegation chains. Revokes credentials on demand or on policy.
- **Evidence it produces:**
  - Per-credential issue records with scope, lease, and principal.
  - Delegation-chain records linking the human authority to the agent action.
  - Revocation records with timestamp and reason.
  - A schema-validated `actor` / `principal` field on every action that resolves to a real identity.
- **Failure it prevents:** Standing credentials with no expiry, agents acting as the wrong principal, and revocation that does not actually stop in-flight work.
- **Activated at AMM levels:** L5, L6, L7, L8, L9, L10

## Data Governance

- **What it does:** Classifies data, redacts sensitive content at boundaries, enforces retention and residency, and records data movement.
- **Evidence it produces:**
  - Classification labels on inputs and outputs.
  - Redaction records (what was redacted, by which rule, where).
  - Retention metadata on every persisted artifact.
  - Residency declarations for stored content and model context.
- **Failure it prevents:** Sensitive data leaving the boundary, unknown-classification content reaching the model, and data sitting in storage past its retention window.
- **Activated at AMM levels:** L2, L3, L4, L5, L6, L7, L8, L9, L10

## Protocol Conformance

- **What it does:** Validates that adapters and agent boundaries conform to their documented protocols (MCP, A2A, OpenAPI, custom schemas). Versions contracts and rejects shapes that do not match.
- **Evidence it produces:**
  - Schema versions for every interface the agent exposes or consumes.
  - Conformance test results per adapter.
  - Rejection records for non-conforming traffic.
  - A contract diff log on every contract version bump.
- **Failure it prevents:** Silent contract drift, untyped boundary crossings, and integration failures that surface only in production.
- **Activated at AMM levels:** L3, L4, L5, L6, L7, L8, L9, L10

## Incident Response

- **What it does:** Detects, contains, and replays incidents involving the agent. Holds runbooks, named on-call owners, and a postmortem workflow.
- **Evidence it produces:**
  - Detection signals (alert thresholds, anomaly classes) recorded per agent.
  - Containment records — pauses, revocations, rollbacks taken in response.
  - Replay artifacts that reproduce the incident in a sandbox.
  - Postmortems linking incident to root cause to corrective action.
- **Failure it prevents:** Incidents that cannot be contained because nobody owns the response, and recurrence because the team never replays the failure.
- **Activated at AMM levels:** L6, L7, L8, L9, L10

## OpenTelemetry Mapping

- **What it does:** Maps agent activity to portable OpenTelemetry traces, metrics, and logs. Every tool call, model call, and step transition is observable across the same telemetry pipeline as the rest of the platform.
- **Evidence it produces:**
  - Spans per agent step with `agent.tool_call_id`, `agent.run_id`, `agent.principal` attributes.
  - Metrics for run count, step latency, error rate, model token usage.
  - Structured logs with `correlation_id` linking model, tool, and review records.
  - A documented mapping from agent semantics to OTel semantic conventions.
- **Failure it prevents:** Black-box agents that cannot be debugged, scaled, or compared across services.
- **Activated at AMM levels:** L5, L6, L7, L8, L9, L10

## Value and Cost Management

- **What it does:** Tracks cost (compute, model, tool calls), latency, and outcomes against business value. Enforces budgets and surfaces value-vs-spend.
- **Evidence it produces:**
  - Cost records per run, per agent, per principal.
  - Latency distributions per step type.
  - Outcome metrics tied to business KPIs the agent is meant to move.
  - Budget records with burn rate and cap.
- **Failure it prevents:** Runaway spend, unmeasured outcomes, and inability to answer "is this agent worth its cost."
- **Activated at AMM levels:** L6, L7, L8, L9, L10
