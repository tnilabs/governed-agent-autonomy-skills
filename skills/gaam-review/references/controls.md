---
canon_version: 2.0.0
last_reviewed: 2026-04-30
---

# Enterprise Control Categories

Ten control categories from `../governed-agent-autonomy/controls/`. Controls
are cumulative: once a control activates at GAAM level N, it remains active
at every higher level. L1 and L2 are preparation levels; they name data,
process, risk, and ownership before agentic controls become load-bearing.

Control headings and example record names are semantic anchors, not required
strings. A deployment satisfies a control when local artifacts prove the same
capability, evidence, runtime boundary, and failure prevention.

**Lookup rule for agents.** For a target or claimed GAAM level, include every
control whose `Activated at GAAM levels` line contains that level. Do not
infer from the heading order alone.

| Level | Active controls |
| --- | --- |
| L1 | None |
| L2 | None |
| L3 | Data, Context & Memory Governance |
| L4 | Threat & Adversarial Resilience, Evidence & Assurance, Data, Context & Memory Governance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L5 | Threat & Adversarial Resilience, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L6 | Threat & Adversarial Resilience, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Incident Response & Recovery, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L7 | Threat & Adversarial Resilience, Agent Registry & Lifecycle, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Incident Response & Recovery, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L8 | Threat & Adversarial Resilience, Agent Registry & Lifecycle, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Incident Response & Recovery, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L9 | Threat & Adversarial Resilience, Agent Registry & Lifecycle, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Incident Response & Recovery, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L10 | Threat & Adversarial Resilience, Agent Registry & Lifecycle, Evidence & Assurance, Delegated Authority & Access, Data, Context & Memory Governance, Tool & Protocol Safety, Incident Response & Recovery, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |

## Threat & Adversarial Resilience

- **What it does:** Detects and mitigates prompt injection, hostile inputs,
  poisoned evidence, tampered approvals, signed-card spoofing, memory
  poisoning, and adversarial regressions. L4 starts by labeling hostile
  input before it reaches the model; L9 makes the adversarial corpus
  load-bearing for autonomy.
- **Evidence it produces:**
  - `InjectionDetection` records for external input, retrieved evidence, and
    tool output.
  - Provenance-framed prompt markers and source verification status.
  - Signed approval, goal, agent-card, and release-gate verification results.
  - Adversarial eval corpus results, red-team findings, and release-gate
    regression records.
- **Failure it prevents:** Silent compromise where crafted input, tampered
  substrate, poisoned memory, or weakened eval coverage steers the agent
  without a forensic trail.
- **Activated at GAAM levels:** L4, L5, L6, L7, L8, L9, L10

## Agent Registry & Lifecycle

- **What it does:** Inventories agents, owners, versions, risk tiers,
  lifecycle state, runtime health, allowed scopes, allowed peers, pause
  state, revocations, and release lifecycle. It becomes load-bearing when
  agents outlive one run and own durable work.
- **Evidence it produces:**
  - Goal, halt, resolution, and run records with agent identity.
  - Signed `AgentCard` registry entries and routing plans.
  - Pause, revocation, dead-letter, and lifecycle transition records.
  - Release, retirement, and deprecation evidence tied to proposals.
- **Failure it prevents:** Shadow agents, stale agents, missing owners,
  missing kill switches, and incident teams unable to enumerate affected
  agents.
- **Activated at GAAM levels:** L7, L8, L9, L10

## Evidence & Assurance

- **What it does:** Bundles run, review, eval, approval, audit, rollback,
  handoff, eligibility, release, limitation, and value evidence into the
  self-contained record auditors inspect.
- **Evidence it produces:**
  - `enterprise_evidence` blocks with implementation ID, model/prompt,
    evidence IDs, review state, and side-effect boundary.
  - Audit records, approval records, rollback metadata, validation reports,
    signed agent cards, typed handoffs, and release bundles.
  - Proposal outcomes, release decisions, promoted regression tests, and
    adversarial regression results.
- **Failure it prevents:** Compliance review depending on scattered logs,
  remembered decisions, unverifiable approvals, or code reading instead of a
  self-contained evidence bundle.
- **Activated at GAAM levels:** L4, L5, L6, L7, L8, L9, L10

## Delegated Authority & Access

- **What it does:** Issues narrow, time-bound, auditable authority to agents
  and runs. Read grants appear at L5; action-bound write leases and
  revocation paths mature at higher levels.
- **Evidence it produces:**
  - Scoped read grants and audit records with actor, scope, status, and run.
  - One-shot `CredentialLease` records for approved writes.
  - Signed agent identity, delegation, revocation, and on-behalf-of records.
  - Dynamic policy and proposal records that refine or retire authority.
- **Failure it prevents:** Blanket credentials, wrong-principal action,
  stale delegation, reuse of write authority, and in-flight work ignoring
  revocation.
- **Activated at GAAM levels:** L5, L6, L7, L8, L9, L10

## Data, Context & Memory Governance

- **What it does:** Carries classification, sensitivity, provenance,
  redaction, retention, residency, tenant isolation, and memory policy across
  every boundary where data moves.
- **Evidence it produces:**
  - Knowledge-document classification, review status, sensitivity, coverage,
    and provenance attestation.
  - External-output safety checks and leak-term validation results.
  - Redaction decisions on tool outputs, audit records, traces, and memory.
  - Memory-write validation and tenant-scoped dead-letter or counter records.
- **Failure it prevents:** Restricted sources entering model context without
  handling metadata, PII leaking into drafts/logs/traces, unbounded memory
  retention, and cross-tenant data exposure.
- **Activated at GAAM levels:** L3, L4, L5, L6, L7, L8, L9, L10

## Tool & Protocol Safety

- **What it does:** Keeps protocol surfaces derived from the same manifests,
  schemas, and contracts the runtime enforces. MCP, A2A, framework-native
  tools, OpenAPI, and custom adapters fail closed on drift.
- **Evidence it produces:**
  - Tool manifests with input/output schemas, `permission_scope`, and
    `side_effect_class`.
  - MCP `tools/list` / `tools/call` conformance results.
  - Approval-token, write-surface, A2A card, handoff-envelope, and
    eligibility-schema validation records.
  - Contract diff and rejection records for non-conforming traffic.
- **Failure it prevents:** Protocol adapters exposing capabilities the
  runtime would refuse, stale schemas, write tools on read-only surfaces, and
  peer agents accepting unsigned or untyped handoffs.
- **Activated at GAAM levels:** L5, L6, L7, L8, L9, L10

## Incident Response & Recovery

- **What it does:** Converts agent failures into detectable, containable,
  replayable, and recoverable events. L6 starts with rollback/compensation
  metadata; L9 adds global pause and dead-letter handling.
- **Evidence it produces:**
  - Rollback plans, idempotent replay records, one-shot lease consumption,
    and write lifecycle records.
  - Durable orchestration checkpoints and typed halt/stop reasons.
  - Global pause records, dead-lettered work, revocation events, replay
    artifacts, and postmortems.
  - Proposal and regression-test records for corrective changes.
- **Failure it prevents:** Duplicate writes on retry, unrecoverable side
  effects, missing containment, lost escalations, and recurring incidents
  without regression coverage.
- **Activated at GAAM levels:** L6, L7, L8, L9, L10

## Runtime Isolation & Execution Safety

- **What it does:** Bounds what agent runtimes can read, write, execute,
  connect to, retain, emit, and clean up. It covers sandboxing, filesystem
  and network limits, temporary workspaces, artifact capture, code-execution
  boundaries, replay artifacts, cleanup, and pause/revocation honoring.
- **Evidence it produces:**
  - Runtime policy and workspace boundary records tied to run, goal, tool,
    handoff, and release identifiers.
  - Filesystem, network, subprocess, timeout, size, retry, and cleanup
    decisions.
  - Artifact manifests, redaction and retention state, replay pointers, and
    containment records for limit violations.
  - Isolation evidence for autonomous workers and improvement-loop release
    candidates.
- **Failure it prevents:** Broad host access, stale workspace state,
  undeclared network reach, unsafe generated-code execution, artifact leaks,
  retry loops, cross-agent authority bleed, and autonomous work continuing
  after pause or revocation.
- **Activated at GAAM levels:** L4, L5, L6, L7, L8, L9, L10

## Observability & Telemetry

- **What it does:** Defines portable traces, metrics, and logs for agent
  runs, retrieval, tool calls, approvals, handoffs, policy gates, memory,
  validation, stop reasons, and release lifecycle. Export may be
  deployment-owned; the record-to-telemetry mapping is the control claim.
- **Evidence it produces:**
  - `RunRecord`, `AuditRecord`, `ApprovalRecord`, `ToolAction`,
    `RollbackPlan`, `InjectionDetection`, handoff, pause, eligibility, and
    release trace projections.
  - Span attributes for prompt version, evidence IDs, side-effect boundary,
    scope, redaction, approval, lease, idempotency, payload hash, validator
    decision, SLO burn, proposal ID, and gate outcome.
  - Correlation IDs joining model, retrieval, tool, review, incident, and
    release records.
- **Failure it prevents:** Agent event islands, traces that answer no audit
  question, broken joins between governance records, and sensitive data
  entering observability through the side door.
- **Activated at GAAM levels:** L4, L5, L6, L7, L8, L9, L10

## Value, Cost & Reliability

- **What it does:** Tracks cost, latency, outcomes, review load, retry
  pressure, escalation, SLO burn, and before/after value. L4-L6 produce
  provider/run metadata; L7 makes budget and outcome measures load-bearing.
- **Evidence it produces:**
  - Human-baseline cost and outcome measures.
  - Provider/model identity, read-tool inventory, write lifecycle, budget
    caps, retry caps, and halt records.
  - Tenant-scoped cost and SLO counters.
  - Value metric rollups and expected/actual improvement deltas on proposals.
- **Failure it prevents:** Auto-resolution masking correction or escalation
  regressions, invisible spend, retry loops without progress, and changes
  that improve one metric while harming another.
- **Activated at GAAM levels:** L4, L5, L6, L7, L8, L9, L10
