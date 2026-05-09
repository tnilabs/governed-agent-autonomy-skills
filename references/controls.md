---
canon_version: 6.0.0
last_reviewed: 2026-05-08
---

# Enterprise Control Categories

Ten control categories for GAAM workflows. Controls are cumulative: once a
control activates at GAAM level N, it remains active at every higher level.
L0 names data, process, risk, and ownership before production assistance.
L1 introduces reviewed assistance with bounded execution. Higher levels add
scoped reads, approved actions, task ownership, agent coordination,
policy-gated autonomy, and governed improvement.

Control headings are semantic anchors. Example artifact or record names are
non-normative context cues, not GAAM requirements. A deployment satisfies a
control when local artifacts prove the same workflow context, authority
boundary, capability, evidence semantics, runtime boundary, and failure
prevention.

**Lookup rule for agents.** For a target or claimed GAAM level, include every
control whose `Activated at GAAM levels` line contains that level. Do not
infer from the heading order alone.

**Priority rule for agents.** Report findings in this order: authority gates
that block the claim, scale gates that block broader rollout or promotion,
maturity-depth backlog, then evidence gaps. A pilot is a narrower claim, not
fewer controls. P0-style authority-gate gaps are not waived for production
GAAM claims.

**Authority reclassification rule.** First determine actual authority. If the
system produces production drafts or recommendations for human review, the
candidate level is at least L1. If it reads live production systems, the
candidate level is at least L2. If it prepares or executes durable side
effects, at least L3. If it owns queue work or long-running task completion,
at least L4. If it coordinates agents through handoffs, at least L5. If it
acts without routine per-action approval, at least L6. If it proposes or
promotes production behavior changes, at least L7.

**Risk escalation rule.** Sensitive data, customer-visible channels, regulated
or consequential decisions, security response, money movement, high volume,
high cost, persistent memory, and autonomy can promote scale gates into
authority gates. An exclusion counts only when runtime scope enforces it.

### Canonical Control IDs

Use names as semantic anchors. IDs are shorthand only after this mapping is
loaded.

| ID | Control | First operationally required level |
| --- | --- | --- |
| C1 | Data, Context & Memory Governance | L0 |
| C2 | Threat & Adversarial Resilience | L1 |
| C3 | Evidence & Assurance | L1 |
| C4 | Runtime Isolation & Execution Safety | L1 |
| C5 | Observability & Telemetry | L1 |
| C6 | Value, Cost & Reliability | L1 |
| C7 | Delegated Authority & Access | L2 |
| C8 | Tool & Protocol Safety | L2 |
| C9 | Incident Response & Recovery | L3 |
| C10 | Agent Registry & Lifecycle | L4 |

### Activation Matrix

| Level | Active controls |
| --- | --- |
| L0 | Data, Context & Memory Governance |
| L1 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability |
| L2 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety |
| L3 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety, Incident Response & Recovery |
| L4 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety, Incident Response & Recovery, Agent Registry & Lifecycle |
| L5 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety, Incident Response & Recovery, Agent Registry & Lifecycle |
| L6 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety, Incident Response & Recovery, Agent Registry & Lifecycle |
| L7 | Data, Context & Memory Governance, Threat & Adversarial Resilience, Evidence & Assurance, Runtime Isolation & Execution Safety, Observability & Telemetry, Value, Cost & Reliability, Delegated Authority & Access, Tool & Protocol Safety, Incident Response & Recovery, Agent Registry & Lifecycle |

## Threat & Adversarial Resilience

- **What it does:** Detects and mitigates prompt injection, hostile inputs,
  poisoned evidence, tampered approvals, signed-card spoofing, memory
  poisoning, and adversarial regressions. L1 starts by labeling hostile input
  before it reaches the model; L6 makes the adversarial corpus operationally
  required for autonomy.
- **Evidence it produces:**
  - Threat-detection evidence for external input, retrieved evidence, and tool
    output.
  - Provenance-framed prompt markers and source verification status.
  - Signed approval, goal, agent-card, and release-gate verification results.
  - Adversarial eval corpus results, red-team findings, and release-gate
    regression records.
- **Failure it prevents:** Silent compromise where crafted input, tampered
  substrate, poisoned memory, or weakened eval coverage steers the agent
  without a forensic trail.
- **Activated at GAAM levels:** L1, L2, L3, L4, L5, L6, L7

## Agent Registry & Lifecycle

- **What it does:** Inventories agents, owners, versions, risk tiers,
  lifecycle state, runtime health, allowed scopes, allowed peers, pause
  state, revocations, and release lifecycle. It becomes operationally required
  when agents outlive one run and own durable work.
- **Evidence it produces:**
  - Goal, halt, resolution, and run records with agent identity.
  - Signed or otherwise verifiable agent identity, capability, and routing
    records.
  - Pause, revocation, dead-letter, and lifecycle transition records.
  - Release, retirement, and deprecation evidence tied to proposals.
- **Failure it prevents:** Shadow agents, stale agents, missing owners,
  missing kill switches, and incident teams unable to enumerate affected
  agents.
- **Activated at GAAM levels:** L4, L5, L6, L7

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
- **Activated at GAAM levels:** L1, L2, L3, L4, L5, L6, L7

## Delegated Authority & Access

- **What it does:** Issues narrow, time-bound, auditable authority to agents
  and runs. Read grants appear at L2; action-bound authority grants and
  revocation paths mature at higher levels.
- **Evidence it produces:**
  - Scoped read grants and audit records with actor, scope, status, and run.
  - One-shot action-authority records for approved side-effecting actions.
  - Signed agent identity, delegation, revocation, and on-behalf-of records.
  - Dynamic policy and proposal records that refine or retire authority.
- **Failure it prevents:** Blanket credentials, wrong-principal action,
  stale delegation, reuse of side-effecting authority, and in-flight work
  ignoring revocation.
- **Activated at GAAM levels:** L2, L3, L4, L5, L6, L7

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
- **Activated at GAAM levels:** L0, L1, L2, L3, L4, L5, L6, L7

## Tool & Protocol Safety

- **What it does:** Keeps tool and protocol surfaces derived from the same
  manifests, schemas, and contracts the runtime enforces. Protocol examples
  such as MCP, A2A, OpenAPI, framework-native tools, and custom adapters fail
  closed on drift.
- **Evidence it produces:**
  - Tool manifests with input/output schemas, `permission_scope`, and
    `side_effect_class`.
  - Protocol conformance results for exposed tool surfaces.
  - Approval-token, side-effecting surface, peer identity, handoff, and
    eligibility validation records.
  - Contract diff and rejection records for non-conforming traffic.
- **Failure it prevents:** Protocol adapters exposing capabilities the
  runtime would refuse, stale schemas, write tools on read-only surfaces, and
  peer agents accepting unsigned or untyped handoffs.
- **Activated at GAAM levels:** L2, L3, L4, L5, L6, L7

## Incident Response & Recovery

- **What it does:** Converts agent failures into detectable, containable,
  replayable, and recoverable events. L3 starts with rollback/compensation
  metadata; L6 adds global pause and dead-letter handling.
- **Evidence it produces:**
  - Rollback plans, idempotent replay records, one-shot authority consumption,
    and action lifecycle records.
  - Durable orchestration checkpoints and typed halt/stop reasons.
  - Global pause records, dead-lettered work, revocation events, replay
    artifacts, and postmortems.
  - Proposal and regression-test records for corrective changes.
- **Failure it prevents:** Duplicate side effects on retry, unrecoverable side
  effects, missing containment, lost escalations, and recurring incidents
  without regression coverage.
- **Activated at GAAM levels:** L3, L4, L5, L6, L7

## Runtime Isolation & Execution Safety

- **What it does:** Bounds what agent runtimes can read, write, execute,
  connect to, retain, emit, and clean up. L1 requires bounded execution
  consistent with reviewed assistance: declared runtime policy, disabled side
  effects, constrained workspaces/artifacts, and permitted evidence surfaces.
  Strong sandboxing, network isolation, parser isolation, tenant isolation,
  or dedicated execution environments are scale or authority gates when the
  claim exposes untrusted execution, broad egress, tenant-sensitive data,
  regulated workflows, higher volume, or autonomous work.
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
- **Activated at GAAM levels:** L1, L2, L3, L4, L5, L6, L7

## Observability & Telemetry

- **What it does:** Defines portable traces, metrics, and logs for agent
  runs, retrieval, tool calls, approvals, handoffs, policy gates, memory,
  validation, stop reasons, and release lifecycle. Export may be
  deployment-owned; the record-to-telemetry mapping is the control claim.
- **Evidence it produces:**
  - Run, audit, approval, action, rollback, threat-detection, handoff, pause,
    eligibility, and release trace projections.
  - Span attributes for prompt version, evidence IDs, side-effect boundary,
    scope, redaction, approval, authority grant, idempotency, payload hash,
    validator decision, SLO burn, proposal ID, and gate outcome.
  - Correlation IDs joining model, retrieval, tool, review, incident, and
    release records.
- **Failure it prevents:** Agent event islands, traces that answer no audit
  question, broken joins between governance records, and sensitive data
  entering observability through the side door.
- **Activated at GAAM levels:** L1, L2, L3, L4, L5, L6, L7

## Value, Cost & Reliability

- **What it does:** Tracks cost, latency, outcomes, review load, retry
  pressure, escalation, SLO burn, and before/after value. L1-L3 produce
  provider/run metadata; L4 makes budget and outcome measures operationally
  required.
- **Evidence it produces:**
  - Human-baseline cost and outcome measures.
  - Provider/model identity, read-tool inventory, action lifecycle, budget
    caps, retry caps, and halt records.
  - Tenant-scoped cost and SLO counters.
  - Value metric rollups and expected/actual improvement deltas on proposals.
- **Failure it prevents:** Auto-resolution masking correction or escalation
  regressions, invisible spend, retry loops without progress, and changes
  that improve one metric while harming another.
- **Activated at GAAM levels:** L1, L2, L3, L4, L5, L6, L7
