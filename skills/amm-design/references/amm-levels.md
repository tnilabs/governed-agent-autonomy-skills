---
canon_version: 1.3.1
last_reviewed: 2026-04-30
---

# Agentic Maturity Model - Levels

Ten capability levels for production-grade AI agents, aligned to the source
AMM implementation. Each level adds one capability boundary and carries
forward comparable work, fixtures, contracts, controls, and lessons. Level
claims are made on evidence: artifacts, controls, tests, telemetry, and
replayable records.

Level descriptions, exit criteria, and record/schema names are semantic
anchors, not required strings. A system can satisfy a requirement through
local vocabulary, services, workflows, external stores, or evidence shapes
when they prove the same capability boundary and prevent the same failure.

## L1 - Unstructured AI use

**Intent.** The current manual or unmanaged AI baseline is made visible.
People may paste work into generic LLMs, but there is no governed assistant,
tool access, approval, audit, or policy gate.

**Exit criteria.**
- Baseline work items record manual time, sources checked, handoffs, outcomes,
  failures, risks, and unmanaged prompt examples.
- Failure categories are typed enough for later levels to map, measure, and
  close them.
- Adversarial-shaped failures are tagged distinctly so L2 can turn them into
  threat-model surfaces.
- Nothing is presented as improved; L1 is measurement, not remediation.

**Common confusion.** L1 is not "no AI use." It is unmanaged use with enough
measurement that later improvement cannot move the denominator.

## L2 - Process definition

**Intent.** The human process becomes explicit before automation: workflow
stages, owners, policies, templates, validation checks, L1-failure mappings,
and threat-model surfaces.

**Exit criteria.**
- Workflow stages have owners, inputs, outputs, handoffs, and exit criteria.
- Policy rules attach to stages instead of floating as prose.
- Every L1 failure maps to the stage or policy intended to catch it.
- A typed threat model names later agent attack surfaces, actors,
  motivations, mitigations, and out-of-scope boundaries.
- Humans have run the documented workflow on representative work items.

**Common confusion.** L2 is still not automated. It is the explicit substrate
that later knowledge, prompts, tools, approvals, and agents inherit.

## L3 - Knowledge grounding

**Intent.** L2 process material becomes AI-ready retrieval material. L3 stops
at retrieval: stable sources, metadata, coverage links, retrieval API, golden
evals, candidate eval promotion, and provenance attestation.

**Exit criteria.**
- Every retrievable document has stable evidence ID, owner, source type,
  sensitivity label, review status, and provenance status.
- Coverage links tie evidence IDs back to baseline work items, failure labels,
  workflow stages, and policies.
- Golden retrieval evals prove required evidence is retrievable for
  representative questions.
- Observed-query signals remain candidate-only until a human eval owner
  promotes them.
- Retrieval results preserve classification and provenance metadata.

**Common confusion.** L3 is not a governed assistant and does not answer
work items. It builds the retrieval contract L4 consumes.

## L4 - Human-guided assistance

**Intent.** The first governed assistant uses L3 retrieval to draft work
artifacts from cited evidence and stops at human review. No send action, tool
writes, approval authority, memory, or autonomous closure is allowed.

**Exit criteria.**
- Per work item, the assistant produces intake or routing, stakeholder-safe
  response draft, internal note, validation checklist, and run record.
- Every output records `pending_review`; side effects remain disabled.
- Prompt context uses explicit trust frames for system, external input, retrieved
  evidence, and tool output.
- External-facing output passes a typed safety/leak check before acceptance.
- Adversarial input and retrieved-evidence matches produce
  `InjectionDetection` records and lower-trust framing.

**Common confusion.** L4 is an assistant, not an agent that decides or
publishes. If external-facing output ships without human review, the system is
not L4-compliant.

## L5 - Read-only tools

**Intent.** The assistant gains scoped read-only operational context through
typed tools. It can look but cannot change anything. Tools are audited,
redacted, sanitized, protocol-conformant, and still feed the L4 review
boundary.

**Exit criteria.**
- Read tools have typed manifests with input schema, output schema,
  `permission_scope`, and read-only `side_effect_class`.
- Each run gets a scoped read grant; out-of-scope calls are refused.
- Every read call emits an audit record, including actor, scope, status,
  protocol/native surface, and redacted output.
- Tool output is sanitized before model context; raw output remains audit
  only.
- MCP or other protocol exposure is derived from the internal manifest and
  fails closed on drift.
- Framework-native tool adapters pass conformance against the shared engine.

**Common confusion.** L5 is not autonomous tool choice and not write access.
The runtime refuses write-capable manifests at this level.

## L6 - Approved write actions

**Intent.** One specific pre-approved write per work item may execute. The model
recommends; the runtime assembles the executable action, verifies approval
binding, issues a one-shot lease, enforces idempotency, records rollback
metadata, and blocks unsafe external-facing writes.

**Exit criteria.**
- Runtime-owned action assembly determines `tool_id` and arguments from typed
  sources; model recommendations are review evidence, not executable
  authority.
- Every executed write has a signed approval record bound to the exact action
  by hash, a one-shot credential lease, an idempotency key, a `ToolAction`,
  and a `RollbackPlan`.
- Signature verification runs before binding checks where signed approvals
  are configured.
- Replays return the prior `ToolAction` without mutating state again.
- External-facing writes run the safety block before approval resolution.

**Common confusion.** L6 does not introduce unattended policy autonomy. The
gate checks durable approval and exact binding; L9 is where policy replaces
routine human approval.

## L7 - Goal-directed execution

**Intent.** One producing agent owns end-to-end completion of one eligible
work package within a signed goal. The model loop proposes next steps; the
runtime decides allowed actions, completion, stop reasons, escalation, budget,
and memory validity.

**Exit criteria.**
- Goals are signed at creation with immutable scope, allowed tools, budgets,
  expiry, required outputs, and success criteria.
- Completion checks use runtime-owned predicate registry entries, not model
  self-report.
- Closed typed stop reasons cover success, uncertainty, policy risk,
  validation failure, tool failure, no progress, budget exhaustion, and
  escalation.
- Multi-dimensional retry/budget caps are enforced.
- Memory writes pass the seven-stage validator; the model reads redacted
  tenant-scoped content only.
- Write actions still flow through L6 approval.

**Common confusion.** L7 is the first task-owning agent, but it is not
multi-agent coordination, routine unattended autonomy, or self-improvement.

## L8 - Coordinated agents

**Intent.** Specialized agents coordinate through deterministic runtime-owned
routing, signed agent cards, typed handoff envelopes, load-bearing validator
veto, and durable orchestration state.

**Exit criteria.**
- Roles are separated: orchestration, triage, research, resolution,
  communication, validation, and escalation are distinct agents or workflow
  nodes with contracts.
- Every agent has a signed card declaring identity, version, owner, risk tier,
  allowed tools, allowed peers, scopes, eval status, and lifecycle state.
- Routing plan, handoff envelope, payload hash, expiry, and single-use
  consumption are validated before cross-agent work.
- Validator decisions bind to the exact artifact reviewed; veto/revise/
  escalate decisions are not advisory.
- Checkpoints persist orchestration state, tool calls, approval state, and
  idempotency so resume does not duplicate side effects.

**Common confusion.** L8 is not "multiple prompts with personas." The runtime
owns route, peer identity, typed handoffs, validator authority, and durable
resume.

## L9 - Policy-gated autonomy

**Intent.** Eligible low-risk work can run without routine human approval.
Deterministic policy, signed eligibility, SLO/cost budgets, dynamic
revocation, global pause, dead-letter handling, and adversarial corpus gates
bound the autonomy.

**Exit criteria.**
- Every autonomous run starts with a signed eligibility decision and every
  allow criterion must pass.
- High-risk, ambiguous, or policy-sensitive work escalates with evidence.
- Global pause is human-operated; workers read it during execution and halt
  within a bounded window.
- Dead-lettered work remains inspectable, replayable, and tenant-isolated.
- SLO, cost, retry, and latency budgets are tracked and enforced.
- Dynamic credential revocation is honored before write boundaries.
- Adversarial corpus freshness and threat-class coverage are startup gates.

**Common confusion.** L9 does not let the agent choose eligibility,
self-unpause, skip write-boundary rechecks, or run without typed halts.

## L10 - Governed improvement

**Intent.** Operational signals become governed improvements. The system may
propose changes, but production-impacting changes require signed proposals,
human review, regression tests, release gates, and adversarial per-class
robustness checks.

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
- Memory cannot become an ungoverned feedback channel.

**Common confusion.** L10 is not silent self-modification or "we run evals."
It is governed engineering practice with evidence, signatures, tests, human
review, and adversarial release gates.
