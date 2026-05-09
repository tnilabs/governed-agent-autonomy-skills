---
canon_version: 6.0.0
last_reviewed: 2026-05-08
---

# Governed Agent Autonomy Model - Levels

Eight capability levels for production-grade AI agents. Each level adds one
public capability boundary and carries forward comparable work, fixtures,
contracts, controls, and lessons. Level claims are made on evidence:
artifacts, controls, tests, telemetry, and replayable records.

Level descriptions, exit criteria, and example artifact names are context
cues, not required strings. GAAM does not require specific record or schema
names. A system satisfies a requirement through local vocabulary, services,
workflows, external stores, or evidence shapes when they prove the same
workflow context, authority boundary, evidence semantics, runtime boundary,
and prevented failure.

Priority language separates mandatory claim blockers from useful maturity work.
An authority gate blocks the level claim. A scale gate blocks broader rollout,
higher-risk scope, higher volume, or promotion. Maturity depth is backlog that
must be reassessed when risk changes. A pilot is a smaller claim, not fewer
controls.

## L0 - Foundation

**Intent.** The organization makes current work, process, policy, threat
surfaces, and approved knowledge explicit before production assistance. People
may use AI to inspect baselines, draft process material, or support retrieval
coverage work, but AI output remains human-reviewed substrate and never becomes
production work judgment.

**Exit criteria.**
- Baseline work items record manual time, sources checked, handoffs, outcomes,
  failures, risks, and unmanaged prompt examples.
- Failure categories are typed enough for later levels to map, measure, and
  close them.
- Adversarial-shaped failures are tagged distinctly so later controls can turn
  them into threat-model surfaces and eval coverage.
- Workflow stages have owners, inputs, outputs, handoffs, and exit criteria.
- Policy rules attach to stages instead of floating as prose.
- Every baseline failure maps to the stage or policy intended to catch it.
- A typed threat model names later agent attack surfaces, actors,
  motivations, mitigations, and out-of-scope boundaries.
- Evidence ownership, minimal artifact versioning, and validation checks are
  present for the process contract.
- AI-produced process, schema, template, policy, or threat-model suggestions
  are human-reviewed before they become source of truth.
- Every retrievable document has stable evidence ID, owner, source type,
  sensitivity label, review status, and provenance status.
- Coverage links tie evidence IDs back to baseline work items, failure labels,
  workflow stages, and policies.
- Corpus manifest/version and documented gap dispositions exist for the claim
  period.
- Golden retrieval evals prove required evidence is retrievable for
  representative questions.
- Observed-query signals remain candidate-only until a human eval owner
  promotes them.
- Retrieval results preserve classification and provenance metadata.
- Retrieval output is limited to approved source references, snippets,
  metadata, and coverage signals.
- No AI output is used as a production work recommendation, routing decision,
  customer-facing draft, live operational read, or action.

**Common confusion.** L0 is not "no AI use." It is foundation work with enough
measurement, process, threat modeling, and governed source coverage that later
automation cannot move the denominator.

## L1 - Reviewed Assistance

**Intent.** The first governed assistant uses approved foundation sources to
draft work artifacts from cited evidence and stops at human review. No live
operational read, send action, side-effecting tool action, approval authority,
memory write, autonomous closure, or agent handoff is allowed.

**Exit criteria.**
- Per work item, the assistant produces intake or routing, stakeholder-safe
  response draft, internal note, validation checklist, and run record.
- Every output records `pending_review`; side effects remain disabled.
- Run records join work item, context, sources, output, reviewer, validation
  results, model/provider or deployment identity, prompt/template version, and
  runtime policy version; provider opacity is recorded as residual risk.
- Prompt context uses explicit trust frames for system, external input,
  retrieved evidence, and tool output.
- External-facing output passes a typed safety/leak check before acceptance.
- Adversarial input and retrieved-evidence matches produce threat-detection
  evidence and lower-trust framing.
- Runtime policy bounds workspace, artifact retention, disabled side effects,
  and permitted network or retrieval surfaces for the assistant claim.
- Stronger sandboxing, network isolation, parser isolation, tenant isolation,
  or dedicated execution environments are scale or authority gates when the
  claim involves untrusted code/content execution, tenant-sensitive data,
  broad egress, regulated workflows, or higher-risk deployment.

**Common confusion.** L1 is an assistant, not an agent that decides or
publishes. If external-facing output ships without human review, the system is
not L1-compliant.

## L2 - Scoped Read Access

**Intent.** The assistant gains scoped read-only operational context through
typed tools. It can look but cannot change anything. Tools are audited,
redacted, sanitized, protocol-conformant, and still feed the L1 review
boundary.

**Exit criteria.**
- Read tools have typed manifests with input schema, output schema,
  `permission_scope`, and read-only `side_effect_class`.
- Each run gets a scoped read grant; out-of-scope calls are refused.
- Every read call emits an audit record, including actor, scope, status,
  protocol/native surface, and redacted output.
- Tenant, data-class, and purpose boundaries are enforced where supported, and
  hidden side effects in read paths are analyzed.
- Tool output is sanitized before model context; raw output remains audit
  only.
- MCP or other protocol exposure is derived from the internal manifest and
  fails closed on drift.
- Framework-native tool adapters pass conformance against the shared engine.

**Common confusion.** L2 is not autonomous tool choice and not write access.
The runtime refuses write-capable manifests at this level.

## L3 - Approved Action

**Intent.** One specific pre-approved side-effecting action per work item may
execute. The model recommends; the runtime assembles the executable action,
verifies approval binding, issues one-shot authority, enforces idempotency,
records recovery metadata, and blocks unsafe external-facing actions.

**Exit criteria.**
- Runtime-owned action assembly determines `tool_id` and arguments from typed
  sources; model recommendations are review evidence, not executable
  authority.
- Every executed side-effecting action has approval evidence bound to the
  exact action by digest, one-shot action authority, an idempotency key,
  execution evidence, and rollback or compensation metadata.
- Containment and affected-object identification are always available; each
  write class has rollback, compensation, or explicit irreversible-side-effect
  treatment with residual-risk evidence.
- Signature verification runs before binding checks where signed approvals
  are configured.
- Replays return the prior action result without mutating state again.
- External-facing actions run the safety block before approval resolution.

**Common confusion.** L3 does not introduce unattended policy autonomy. The
gate checks durable approval and exact binding; L6 is where policy replaces
routine human approval.

## L4 - Bounded Task Agency

**Intent.** One producing agent owns end-to-end completion of one eligible
work package within a signed goal. The model loop proposes next steps; the
runtime decides allowed actions, completion, stop reasons, escalation, budget,
and memory validity.

**Exit criteria.**
- Goals are signed at creation with immutable scope, allowed tools, budgets,
  expiry, required outputs, and success criteria.
- Task-owning agents have registry entries, run-state visibility, and queue
  leases where queued work is owned.
- Completion checks use runtime-owned predicate registry entries, not model
  self-report.
- Closed typed stop reasons cover success, uncertainty, policy risk,
  validation failure, tool failure, no progress, budget exhaustion, and
  escalation.
- Multi-dimensional retry/budget caps are enforced.
- Memory writes pass the seven-stage validator; the model reads redacted
  tenant-scoped content only.
- Side-effecting actions still flow through L3 approval.

**Common confusion.** L4 is the first task-owning agent, but it is not
multi-agent coordination, routine unattended autonomy, or self-improvement.

## L5 - Verified Agent Coordination

**Intent.** Specialized agents coordinate through deterministic runtime-owned
routing, signed agent cards, typed handoff envelopes, runtime-enforced
validator veto, and durable orchestration state.

**Exit criteria.**
- Roles are separated: orchestration, triage, research, resolution,
  communication, validation, and escalation are distinct agents or workflow
  nodes with contracts.
- Every agent has a signed card declaring identity, version, owner, risk tier,
  allowed tools, allowed peers, scopes, eval status, and lifecycle state.
- Routing plan, handoff envelope, payload hash, expiry, and single-use
  consumption are validated before cross-agent work.
- Hop limits, cycle detection, aggregate budgets, durable checkpoints,
  idempotent resume, and dead-letter ownership are enforced.
- Validator decisions bind to the exact artifact reviewed; veto/revise/
  escalate decisions are not advisory.
- Checkpoints persist orchestration state, tool calls, approval state, and
  idempotency so resume does not duplicate side effects.

**Common confusion.** L5 is not "multiple prompts with personas." The runtime
owns route, peer identity, typed handoffs, validator authority, and durable
resume.

## L6 - Policy-Gated Autonomy

**Intent.** Eligible low-risk work can run without routine human approval.
Deterministic policy, signed eligibility, SLO/cost budgets, dynamic
revocation, global pause, dead-letter handling, and adversarial corpus gates
bound the autonomy.

**Exit criteria.**
- Every autonomous run starts with a signed eligibility decision and every
  allow criterion must pass using deterministic typed eligibility over
  source-backed facts, not model confidence alone.
- High-risk, ambiguous, or policy-sensitive work escalates with evidence.
- Global pause is human-operated; workers read it during execution and halt
  within a bounded window.
- Dead-lettered work remains inspectable, replayable, and tenant-isolated.
- SLO, cost, retry, and latency budgets are tracked and enforced.
- Dynamic credential revocation is honored before side-effect boundaries.
- Adversarial corpus freshness and threat-class coverage are startup gates.

**Common confusion.** L6 does not let the agent choose eligibility,
self-unpause, skip side-effect boundary rechecks, or run without typed halts.

## L7 - Governed Improvement Loop

**Intent.** Operational signals become governed improvement loops. The system
may propose changes, but production-impacting changes require signed
proposals, human review, regression tests, release gates, and adversarial
per-class robustness checks.

**Exit criteria.**
- Improvement proposals are PR-shaped artifacts with source run IDs, signal
  fingerprint, problem statement, affected assets, typed diff, regression
  tests, expected metric improvement, and risk assessment.
- Proposals, reviews, waivers, release decisions, promoted tests, and
  transitions are signed separately with payload-digest binding.
- Human review is mandatory before acceptance.
- Release gate compares per-threat-class candidate scores against signed
  baselines; aggregate gains cannot hide adversarial regressions.
- Failed gates block release; recovery is revise, withdraw, or typed waiver
  only where the dimension is waivable.

**Common confusion.** L7 is not silent self-modification or "we run evals."
It is a signed improvement proposal and release-control loop.
