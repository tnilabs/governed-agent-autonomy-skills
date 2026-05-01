---
canon_version: 3.2.0
last_reviewed: 2026-05-01
---

# Pattern Entries per GAAM Level

This index describes reusable GAAM capability patterns.
Each GAAM level has one H2 section. Each pattern has one H3 entry with a
functional signature, the enterprise controls it exercises, and the assertion
a reviewer or implementer should prove.

Pattern IDs and test wording are trace handles. Example artifact, record, or
schema names are non-normative context cues, not GAAM requirements.
Equivalent local implementations satisfy a pattern when they fit the workflow
context, produce the same evidence semantics, enforce the same authority and
runtime boundaries, and prevent the same failure.

**Lookup rule for agents.** For target or claimed level L<n>, include every
pattern entry under sections L1 through L<n> inclusive. Do not include only
the entries introduced at L<n>; earlier substrate and control patterns carry
forward.

## L1 - Unmanaged AI Baseline

### L1-baseline-failure-cataloguing

- **Functional signature:** typed failure catalogue for current unmanaged work - produces baseline work items with manual cost, handoff, risk, failure, and adversarial tags - prevents later levels from claiming improvement against a cherry-picked or undefined baseline
- **Controls activated:** None
- **Test asserts:** baseline rows have typed failure categories, manual-cost fields, risk/adversarial tags, and stable IDs reused by later levels.

## L2 - Process & Policy Contract

### L2-process-as-substrate

- **Functional signature:** human workflow stages, owners, policies, templates, validations, and L1-failure mappings, with any AI-generated process suggestions treated as human-reviewed review material - produces versioned process artifacts - prevents automating undocumented habits or treating process drafts as production judgment
- **Controls activated:** None
- **Test asserts:** every stage has owner/input/output/handoff/exit criteria, every policy attaches to a stage, every L1 failure maps to a stage or policy, and AI process-review output cannot become source of truth without human review.

### L2-threat-model-as-substrate

- **Functional signature:** typed threat model with stable surface IDs, actors, motivations, mitigations, and out-of-scope boundaries - produces reusable surface references for L4-L10 defenses - prevents defenses from being added after incidents with no shared model
- **Controls activated:** None
- **Test asserts:** every threat surface has stable ID, declared actor, motivation, mitigation, and later defenses reference those IDs.

## L3 - Grounded Knowledge

### L3-knowledge-coverage-map

- **Functional signature:** coverage links from knowledge documents to work items, failure labels, workflow stages, and policies - produces an evidence-to-process map for governed retrieval - prevents broad corpora that do not cover the actual work or retrieval that answers disposition questions
- **Controls activated:** Data, Context & Memory Governance
- **Test asserts:** every retrievable document maps to at least one work item, failure, stage, or policy using typed IDs.

### L3-golden-retrieval-evals

- **Functional signature:** reviewed retrieval evals versioned with the corpus and candidate observed-query signals kept untrusted - produces golden eval fixtures and promotion records - prevents live-query drift from becoming authoritative
- **Controls activated:** Data, Context & Memory Governance
- **Test asserts:** golden evals are reviewed/versioned, observed signals are candidate-only, and promotion requires human review.

### L3-provenance-attested-source

- **Functional signature:** retrievable documents carry classification, sensitivity, review status, and provenance attestation - produces source metadata that survives retrieval - prevents silently quoting unverified or restricted sources and keeps source finding separate from production drafting
- **Controls activated:** Data, Context & Memory Governance
- **Test asserts:** retrieval results preserve classification, review status, evidence ID, and provenance status for every chunk.

## L4 - Reviewed Assistance

### L4-pending-review-boundary

- **Functional signature:** assistant outputs stop at `pending_review` with side effects disabled - produces human review records and run records - prevents drafts from being sent or mutated before review
- **Controls activated:** Evidence & Assurance, Observability & Telemetry, Value, Cost & Reliability
- **Test asserts:** every assistant output has `pending_review`, `side_effects_allowed=false`, and blocking validation errors.

### L4-provenance-framed-prompt-assembly

- **Functional signature:** model context is assembled into explicit trust frames for system, external input, retrieved evidence, and tool output - produces stable provenance markers - prevents attacker-controlled text from being treated as instructions
- **Controls activated:** Threat & Adversarial Resilience, Data, Context & Memory Governance, Observability & Telemetry
- **Test asserts:** external input and retrieved evidence appear only in lower-trust frames with verification metadata and a system trust-boundary directive.

### L4-customer-safe-output-check

- **Functional signature:** typed leak/safety check runs on external-facing drafts before review - produces validation records - prevents internal markers, evidence IDs, or sensitive fields from reaching recipients
- **Controls activated:** Data, Context & Memory Governance, Evidence & Assurance
- **Test asserts:** external-facing drafts with leak terms fail acceptance rather than producing warnings.

### L4-adversarial-input-labeling

- **Functional signature:** pattern-library matches on hostile external input or retrieved evidence are labeled as threat-detection evidence, not silently ignored - produces lower-trust framing decisions - prevents instruction override from entering model context as authority
- **Controls activated:** Threat & Adversarial Resilience, Observability & Telemetry
- **Test asserts:** matches produce typed detection records with source frame, pattern, action=`label`, and versioned detector metadata.

## L5 - Scoped Read Access

### L5-typed-tool-manifest-with-scope

- **Functional signature:** read tools declare input/output schemas, `permission_scope`, and `side_effect_class` - produces versioned manifests - prevents untyped or write-capable tools from entering the L5 surface
- **Controls activated:** Tool & Protocol Safety, Delegated Authority & Access
- **Test asserts:** write-capable manifests are refused at L5 and every accepted tool has schema, scope, and read-only side-effect class.

### L5-scoped-grant-per-run

- **Functional signature:** each run receives a scoped read grant and registry calls require matching scope - produces delegation/audit evidence - prevents blanket credentials and out-of-scope reads
- **Controls activated:** Delegated Authority & Access, Evidence & Assurance
- **Test asserts:** tool calls without a matching grant fail and grants are recorded on the audit trail.

### L5-read-tool-audit-redaction

- **Functional signature:** every read-tool call emits audit evidence and sends only redacted output to the model - produces actor/scope/status/protocol/native-tool evidence - prevents silent data egress through tool results
- **Controls activated:** Data, Context & Memory Governance, Evidence & Assurance, Observability & Telemetry, Delegated Authority & Access
- **Test asserts:** every read call records actor, scope, args/result digest or redacted output, status, and the model receives the redacted payload.

### L5-mcp-conformance-derived-from-manifest

- **Functional signature:** MCP exposure is derived from the internal manifest and conformance fails closed on drift - produces tool and protocol safety results - prevents stale protocol surfaces from advertising unsafe capabilities
- **Controls activated:** Tool & Protocol Safety, Evidence & Assurance
- **Test asserts:** MCP `tools/list` matches manifest name/scope/input schema and rejects drift between internal and protocol surfaces.

### L5-tool-output-sanitization

- **Functional signature:** tool outputs are sanitized for control characters and instruction-pattern fragments before model context - produces redacted payload plus detection records - prevents confused-deputy attacks through upstream tool data
- **Controls activated:** Threat & Adversarial Resilience, Data, Context & Memory Governance, Observability & Telemetry
- **Test asserts:** sanitized output strips control characters, labels instruction fragments, and keeps raw output audit-only.

### L5-native-tool-conformance

- **Functional signature:** one shared tool engine feeds framework-native tool surfaces and a conformance harness compares outputs - produces native-tool evidence on audit records - prevents framework adapters from bypassing registry policy
- **Controls activated:** Tool & Protocol Safety, Evidence & Assurance, Observability & Telemetry
- **Test asserts:** equivalent inputs across native framework adapters produce aligned audit records and policy decisions.

## L6 - Approved Action

### L6-model-recommends-runtime-assembles

- **Functional signature:** model recommends an action while runtime authoritatively assembles `tool_id` and arguments from typed templates - produces divergence audit evidence - prevents model-authored side effects
- **Controls activated:** Evidence & Assurance, Tool & Protocol Safety, Delegated Authority & Access
- **Test asserts:** executable actions use runtime-assembled arguments and model/runtime divergence is logged without changing execution.

### L6-approval-binding-hash

- **Functional signature:** approval evidence binds to the exact runtime-assembled action via recomputable hash - produces approval gate decisions - prevents reusing a valid-looking approval for a different side effect
- **Controls activated:** Evidence & Assurance, Delegated Authority & Access, Incident Response & Recovery, Observability & Telemetry
- **Test asserts:** approval is consumed only when binding hash matches; invalid gates do not consume action authority.

### L6-one-shot-action-authority

- **Functional signature:** approved actions receive one action-bound, time-bound authority grant consumed exactly once - produces authority issue/consume evidence - prevents replay or broad side-effect authority
- **Controls activated:** Delegated Authority & Access, Incident Response & Recovery, Evidence & Assurance
- **Test asserts:** authority grant action ID and idempotency key must match the call and the same grant cannot be consumed twice.

### L6-idempotent-action-replay

- **Functional signature:** repeated idempotency key returns the prior action result without fresh mutation - produces replay evidence - prevents duplicate side effects during retries
- **Controls activated:** Incident Response & Recovery, Evidence & Assurance, Observability & Telemetry
- **Test asserts:** a replay does not consume fresh authority and does not mutate state again.

### L6-recovery-metadata-on-every-action

- **Functional signature:** every executed side-effecting action carries rollback or compensation metadata with reverse, append-only correction, or follow-up correction path - produces recovery metadata - prevents incident response improvising after mutation
- **Controls activated:** Incident Response & Recovery, Evidence & Assurance, Observability & Telemetry
- **Test asserts:** every executed action has a recovery path whose correction type is one of the allowed typed paths.

### L6-signed-approval-evidence

- **Functional signature:** approval evidence is signed over canonical payload and verified before binding checks - produces signature verification evidence - prevents at-rest approval tampering
- **Controls activated:** Threat & Adversarial Resilience, Evidence & Assurance, Delegated Authority & Access
- **Test asserts:** invalid, rotated, or revoked signing keys fail cleanly before binding and authority consumption.

### L6-customer-safety-block-gate

- **Functional signature:** external-facing actions run the L4 safety check before approval resolution - produces first-class block gate status - prevents approved actions from leaking unsafe recipient-facing text
- **Controls activated:** Data, Context & Memory Governance, Evidence & Assurance, Incident Response & Recovery
- **Test asserts:** unsafe external-facing actions short-circuit to `customer_safety_block` regardless of approval validity.

## L7 - Bounded Task Agency

### L7-signed-goal-with-immutable-scope

- **Functional signature:** task agent runs from a signed goal whose scope, budget, expiry, and allowed tools are immutable - produces goal verification records - prevents scope widening and self-granted authority
- **Controls activated:** Agent Registry & Lifecycle, Delegated Authority & Access, Value, Cost & Reliability, Evidence & Assurance
- **Test asserts:** post-signing scope changes, expired goals, and tool calls outside signed scope fail verification.

### L7-success-criteria-predicate-registry

- **Functional signature:** goals reference runtime-owned machine-checkable predicates by ID - produces predicate evaluation records - prevents model self-report from deciding completion
- **Controls activated:** Agent Registry & Lifecycle, Evidence & Assurance, Observability & Telemetry
- **Test asserts:** completion runs against runtime evidence and inline/freeform predicate logic in goals is refused.

### L7-task-agent-stop-reasons

- **Functional signature:** closed typed stop reasons and multi-dimensional budgets govern completion, retry, escalation, failure, and no-progress halts - produces halt and resolution records - prevents endless loops and untyped stops
- **Controls activated:** Agent Registry & Lifecycle, Value, Cost & Reliability, Incident Response & Recovery, Observability & Telemetry
- **Test asserts:** stop reasons are from the closed enum, budget exhaustion halts, no-progress halts fire, and escalation is a first-class outcome.

### L7-memory-write-validation

- **Functional signature:** memory writes pass a seven-stage validation pipeline before persistence and reads expose only redacted tenant-scoped content - produces memory validation records - prevents memory poisoning and cross-tenant leakage
- **Controls activated:** Data, Context & Memory Governance, Threat & Adversarial Resilience, Incident Response & Recovery, Observability & Telemetry
- **Test asserts:** poisoning patterns block persistence, source frame is runtime-set, cross-tenant writes fail, and persistent retention requires L10 review.

## L8 - Verified Agent Coordination

### L8-signed-a2a-card

- **Functional signature:** peer agent cards are signed with immutable capabilities and verified before handoff - produces agent-card registry and security-finding records - prevents spoofed peers and capability widening
- **Controls activated:** Agent Registry & Lifecycle, Tool & Protocol Safety, Threat & Adversarial Resilience, Delegated Authority & Access
- **Test asserts:** unsigned, stale, or capability-widened cards fail before any handoff.

### L8-validator-veto-handoff

- **Functional signature:** separate validator role can reject, revise, or escalate coordinated output and its decision binds to the exact artifact - produces validation decisions and handoff evidence - prevents advisory-only validation
- **Controls activated:** Evidence & Assurance, Tool & Protocol Safety, Agent Registry & Lifecycle, Threat & Adversarial Resilience
- **Test asserts:** validator and producer are separate roles and a veto changes route or halts acceptance.

### L8-durable-orchestration-state

- **Functional signature:** coordinated workflow state persists across failure and resumes without duplicate side effects - produces signed checkpoints - prevents crash recovery from replaying actions or losing approvals
- **Controls activated:** Incident Response & Recovery, Agent Registry & Lifecycle, Observability & Telemetry, Evidence & Assurance
- **Test asserts:** checkpoints include tool calls and approval state; resume continues from checkpoint without duplicate mutation.

## L9 - Policy-Gated Autonomy

### L9-policy-eligibility-gate

- **Functional signature:** autonomous workers run only when signed eligibility schema allows every criterion and ineligible work auto-escalates - produces eligibility decisions - prevents agents from choosing their own autonomy boundary
- **Controls activated:** Agent Registry & Lifecycle, Delegated Authority & Access, Tool & Protocol Safety, Value, Cost & Reliability, Evidence & Assurance
- **Test asserts:** eligibility is typed/signed, every allow criterion must pass, and ineligible work items escalate with evidence.

### L9-global-pause-and-dead-letter

- **Functional signature:** human-operated global pause halts autonomous workers and dead-letters work for replay - produces pause audit and dead-letter records - prevents ignored kill switches and lost autonomous work
- **Controls activated:** Incident Response & Recovery, Agent Registry & Lifecycle, Data, Context & Memory Governance, Observability & Telemetry, Evidence & Assurance
- **Test asserts:** paused workers stop within a bounded window and dead-lettered work remains inspectable with tenant isolation.

### L9-continuous-adversarial-eval-corpus

- **Functional signature:** autonomy startup and release checks require a versioned adversarial corpus and red-team findings feed corpus entries - produces adversarial eval and freshness records - prevents autonomous systems from running on stale safety coverage
- **Controls activated:** Threat & Adversarial Resilience, Incident Response & Recovery, Evidence & Assurance, Value, Cost & Reliability
- **Test asserts:** corpus freshness is a hard gate and schema/threat-class expansion without corpus coverage refuses startup.

## L10 - Governed Improvement Loop

### L10-evidence-backed-improvement-proposal

- **Functional signature:** failures and feedback become signed PR-shaped proposals with source runs, affected assets, typed diff, regression tests, expected metric improvement, and risk assessment - produces proposal, review, and transition records - prevents side-channel or chat-shaped self-modification
- **Controls activated:** Evidence & Assurance, Agent Registry & Lifecycle, Value, Cost & Reliability, Incident Response & Recovery, Data, Context & Memory Governance
- **Test asserts:** proposals without source runs, regression tests, reviewer signoff, or payload-digest binding are refused.

### L10-adversarial-release-gate

- **Functional signature:** candidate changes compare per-threat-class adversarial scores against signed baselines before release - produces release decisions, waiver records, and promoted tests - prevents aggregate functional gains from hiding safety regressions
- **Controls activated:** Threat & Adversarial Resilience, Evidence & Assurance, Incident Response & Recovery, Value, Cost & Reliability, Observability & Telemetry
- **Test asserts:** functional improvement with adversarial regression fails; non-waivable threat classes cannot be overridden; audit recompute catches inconsistent gate outcomes.
