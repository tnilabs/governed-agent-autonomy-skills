---
canon_version: 1.1.0
last_reviewed: 2026-04-29
---

# Synonyms and Detection Signals

Assess and review skills consult this file before claiming a control or
pattern is missing. Controls and patterns are functional categories, not
names. A user system has the capability if it produces the evidence and
prevents the failure under any local naming.

Every entry has a functional signature, at least three alternative names, and
at least three detection-signal categories.

## Controls

### Adversarial Awareness

- **Functional signature:** hostile input, substrate tampering, poisoning, and adversarial-regression defenses - produces detection, provenance, verification, red-team, and eval records - prevents silent compromise.
- **Alternative names:** prompt guard, jailbreak detector, prompt firewall, security middleware, adversarial eval gate, red-team corpus
- **Detection signals:**
  - Files/dirs: `adversarial/`, `guards/`, `security/`, `threat_model`, `red_team`, `eval_corpus`
  - Schemas/deps: `injection-detection`, `security-finding`, `adversarial-eval-corpus`, signing libraries
  - Code/log shapes: `InjectionDetection`, `SecurityFinding`, `signature_invalid`, `adversarial_eval_passed`, `prompt_blocked`

### Agent Control Tower

- **Functional signature:** agent inventory, lifecycle, health, owner, pause, revocation, and release state - produces registry and operator records - prevents shadow agents and missing kill switches.
- **Alternative names:** agent registry, control plane, ops dashboard, admin console, agent fleet, lifecycle registry
- **Detection signals:**
  - Files/dirs: `agent_registry/`, `control_plane/`, `ops/`, `admin/`, `lifecycle/`
  - Schemas/deps: `agent-card`, `routing-plan`, `halt-record`, `global-pause-flag`
  - Code/log shapes: `AgentCard`, `agent_registered`, `agent_paused`, `risk_tier`, `lifecycle_state`

### Compliance Evidence Pack

- **Functional signature:** self-contained bundle of run, review, eval, audit, approval, rollback, handoff, eligibility, and release evidence - produces defensible audit artifacts - prevents audit-by-memory.
- **Alternative names:** evidence bundle, audit pack, attestation pack, compliance report, audit export, run dossier
- **Detection signals:**
  - Files/dirs: `evidence/`, `compliance/`, `audit_export/`, `attestations/`, `reports/`
  - Schemas/deps: `run-record`, `human-review-record`, `approval-record`, `release-decision`
  - Code/log shapes: `enterprise_evidence`, `control_summary`, `evidence_id`, `attestation_signature`, `release_bundle`

### Credential and Delegated Access

- **Functional signature:** scoped grants, one-shot leases, delegation chains, principal binding, and revocation - produces authority records - prevents blanket credentials and wrong-principal action.
- **Alternative names:** scoped credentials, delegated auth, identity broker, on-behalf-of, lease broker, RBAC
- **Detection signals:**
  - Files/dirs: `access/`, `auth/`, `iam/`, `leases/`, `delegation/`, `principals/`
  - Schemas/deps: `credential-lease`, `credential-revocation-event`, `approval-record`, `casbin`, `oso`
  - Code/log shapes: `CredentialLease`, `issue_read_grant`, `lease_consumed`, `actor`, `principal`, `revoked`

### Data Governance

- **Functional signature:** classification, provenance, redaction, retention, residency, tenant isolation, and memory policy - produces data-handling records - prevents leakage and unbounded data retention.
- **Alternative names:** data classification, DLP, privacy guard, PII redaction, retention policy, data residency
- **Detection signals:**
  - Files/dirs: `data_governance/`, `privacy/`, `redaction/`, `dlp/`, `memory/`, `knowledge-index`
  - Schemas/deps: `provenance-attestation`, `memory-record`, `redaction`, `presidio`, `scrubadub`
  - Code/log shapes: `classification`, `sensitivity`, `redacted_output`, `retention`, `tenant_id`, `pii_redacted`

### Protocol Conformance

- **Functional signature:** protocol surfaces are derived from runtime contracts and fail closed on drift - produces conformance and rejection records - prevents adapters lying about capabilities.
- **Alternative names:** schema conformance, MCP validator, A2A conformance, contract testing, adapter validation, protocol guard
- **Detection signals:**
  - Files/dirs: `protocol_conformance/`, `mcp/`, `a2a/`, `schemas/`, `contracts/`, `adapters/`
  - Schemas/deps: `tool-action`, `agent-card`, `handoff-envelope`, `jsonschema`, `openapi`
  - Code/log shapes: `tools/list`, `validate_against_schema`, `contract_violation`, `requires_approval`, `side_effect_class`

### Incident Response

- **Functional signature:** failures are detected, paused, replayed, rolled back, compensated, dead-lettered, and converted into tests - produces containment and recovery evidence - prevents recurrence and unrecoverable side effects.
- **Alternative names:** incident management, runbook, rollback, dead letter queue, kill switch, postmortem
- **Detection signals:**
  - Files/dirs: `incident/`, `rollback/`, `dead_letter/`, `runbooks/`, `postmortems/`, `replay/`
  - Schemas/deps: `rollback-plan`, `dead-lettered-case`, `global-pause-flag`, `halt-record`
  - Code/log shapes: `RollbackPlan`, `ToolAction`, `global_pause`, `dead_letter_added`, `replay_started`, `postmortem`

### OpenTelemetry Mapping

- **Functional signature:** agent records map to portable OTel traces, metrics, and logs - produces span attributes and correlation IDs - prevents custom event islands.
- **Alternative names:** OTel mapping, tracing, observability, distributed tracing, telemetry pipeline, span mapper
- **Detection signals:**
  - Files/dirs: `telemetry/`, `otel/`, `tracing/`, `observability/`, `metrics/`
  - Schemas/deps: `trace-record`, `run-record`, `opentelemetry-api`, `opentelemetry-sdk`
  - Code/log shapes: `trace_id`, `span_id`, `correlation_id`, `agent.run_id`, `agent.tool_call_id`, `release_trace_records`

### Value and Cost Management

- **Functional signature:** cost, latency, budget, retry, outcome, SLO, and value deltas are measured against the business baseline - produces cost/value records - prevents spend and outcome drift.
- **Alternative names:** finops, cost tracking, budget guard, value metrics, unit economics, SLO budget
- **Detection signals:**
  - Files/dirs: `cost/`, `budget/`, `slo/`, `value/`, `finops/`, `metrics/`
  - Schemas/deps: `cost-record`, `slo-band`, `goal-record`, `resolution-package`
  - Code/log shapes: `budget_exhausted`, `slo_burn`, `cost_usd`, `value_metric_rollup`, `retry_budget`

## Patterns

### L1-baseline-failure-cataloguing

- **Functional signature:** typed baseline failure catalogue with manual cost/risk/adversarial tags - produces comparable L1 evidence - prevents unfalsifiable improvement claims.
- **Alternative names:** baseline catalog, failure inventory, current-state measurement, unmanaged prompt baseline, manual-work baseline
- **Detection signals:**
  - Files/dirs: `baseline_cases/`, `level_01/`, `prompts/`, `baseline-report`
  - Schemas/deps: baseline case fixtures, risk labels, failure labels
  - Code/log shapes: `failure_category`, `manual_time`, `handoffs`, `adversarial_failure_modes`

### L2-process-as-substrate

- **Functional signature:** explicit workflow, owners, policies, templates, validation, and L1 failure mappings - produces process substrate - prevents automating undocumented habits.
- **Alternative names:** human process contract, SOP substrate, workflow map, process controls, policy-stage mapping
- **Detection signals:**
  - Files/dirs: `human_process/`, `workflow.yaml`, `policies.yaml`, `templates/`, `level-01-baseline-to-process`
  - Schemas/deps: process report fixtures, policy rule IDs, stage schemas
  - Code/log shapes: `stage_id`, `owner`, `exit_criteria`, `policy_id`, `baseline_failure_process_links`

### L2-threat-model-as-substrate

- **Functional signature:** typed threat model with stable surface IDs and mitigations - produces references for later defenses - prevents disconnected reactive security.
- **Alternative names:** threat model, risk surface catalog, adversarial surface map, abuse-case register, security model
- **Detection signals:**
  - Files/dirs: `threat-model.yaml`, `threat_model`, `security/`, `level_02/`
  - Schemas/deps: `threat-model.schema`, actors, mitigations, surface IDs
  - Code/log shapes: `surface_id`, `actor`, `motivation`, `mitigations`, `out_of_scope`

### L3-knowledge-coverage-map

- **Functional signature:** knowledge docs map to cases, failures, stages, and policies - produces coverage evidence - prevents irrelevant or incomplete corpora.
- **Alternative names:** coverage map, knowledge matrix, evidence coverage, corpus mapping, policy-evidence map
- **Detection signals:**
  - Files/dirs: `knowledge-coverage`, `knowledge_base/`, `knowledge-index`, `level_03/evals`
  - Schemas/deps: coverage fixtures, evidence IDs, retrieval eval definitions
  - Code/log shapes: `evidence_id`, `case_id`, `failure_label`, `stage_id`, `policy_id`

### L3-golden-retrieval-evals

- **Functional signature:** reviewed retrieval evals versioned with corpus; observed signals stay candidate-only - produces retrieval quality gate - prevents unreviewed live-query drift.
- **Alternative names:** golden evals, retrieval tests, seed eval set, corpus evals, search relevance checks
- **Detection signals:**
  - Files/dirs: `retrieval-evals`, `retrieval-signals`, `evals/`, `level_03/`
  - Schemas/deps: eval fixtures, promoted/candidate status, reviewer fields
  - Code/log shapes: `golden`, `observed_query`, `candidate`, `promoted`, `reviewed_by`

### L3-provenance-attested-source

- **Functional signature:** retrievable sources carry classification, review status, and provenance attestation - produces source trust metadata - prevents silently quoting unverified sources.
- **Alternative names:** source attestation, provenance metadata, signed source, classified corpus, evidence provenance
- **Detection signals:**
  - Files/dirs: `provenance`, `knowledge-index`, `asset_documents`, `knowledge_indexer`
  - Schemas/deps: `provenance-attestation`, content digest, issuer, signature
  - Code/log shapes: `verification_status`, `review_status`, `sensitivity`, `source_id`, `content_digest`

### L4-pending-review-boundary

- **Functional signature:** all assistant outputs stop at human review with side effects disabled - produces review/run evidence - prevents unreviewed outputs shipping.
- **Alternative names:** review boundary, HITL gate, pending review, draft gate, human review state
- **Detection signals:**
  - Files/dirs: `review/`, `human_review`, `level_04`, `assistant_output`
  - Schemas/deps: `human-review-record`, `run-record`, review status enums
  - Code/log shapes: `pending_review`, `side_effects_allowed=false`, `review_status`, `HumanReviewRecord`

### L4-provenance-framed-prompt-assembly

- **Functional signature:** prompt context uses explicit trust frames - produces provenance markers - prevents untrusted text from becoming instructions.
- **Alternative names:** framed prompt, trust framing, provenance framing, prompt assembly, source-framed context
- **Detection signals:**
  - Files/dirs: `framing`, `prompt_assembly`, `adversarial`, `level_04`
  - Schemas/deps: provenance records, prompt providers, source metadata
  - Code/log shapes: `[system]`, `[customer message]`, `[retrieved evidence`, `verified=`, `source_frame`

### L4-customer-safe-output-check

- **Functional signature:** customer drafts pass typed leak/safety checks before review - produces validation records - prevents sensitive/internal text leakage.
- **Alternative names:** customer safety check, leak checker, output guard, response validator, customer-visible gate
- **Detection signals:**
  - Files/dirs: `data/`, `validation`, `customer_safe`, `assistant_output`
  - Schemas/deps: validation report, leak terms, customer response schema
  - Code/log shapes: `ValidationReport`, `customer_visible`, `leak_terms`, `blocks_acceptance`, `internal_marker`

### L4-adversarial-input-labeling

- **Functional signature:** hostile input is labeled and framed lower-trust - produces injection detections - prevents instruction override from gaining authority.
- **Alternative names:** injection labeling, prompt-injection detector, hostile input labeler, lower-trust labeling, attack classifier
- **Detection signals:**
  - Files/dirs: `adversarial/detection`, `patterns/v1`, `injection`, `level_04`
  - Schemas/deps: `injection-detection`, pattern library, detector version
  - Code/log shapes: `InjectionDetection`, `action=label`, `source_frame`, `instruction_override`, `pattern_id`

### L5-typed-tool-manifest-with-scope

- **Functional signature:** tools declare schemas, scope, and read-only side-effect class - produces manifests - prevents untyped or write-capable L5 tools.
- **Alternative names:** tool manifest, scoped tools, typed tools, read-tool manifest, tool schema registry
- **Detection signals:**
  - Files/dirs: `tools/read-tools`, `tool_registry`, `manifests`, `level_05/tools`
  - Schemas/deps: tool action schemas, input/output schemas, protocol conformance
  - Code/log shapes: `permission_scope`, `side_effect_class`, `read_only`, `input_schema`, `output_schema`

### L5-scoped-grant-per-run

- **Functional signature:** each run gets a scoped read grant required by the registry - produces grant/audit evidence - prevents blanket read authority.
- **Alternative names:** read grant, scoped grant, per-run lease, delegated read access, narrow credential
- **Detection signals:**
  - Files/dirs: `access/`, `leases`, `tool_registry`, `level_05`
  - Schemas/deps: grant records, audit records, identity broker
  - Code/log shapes: `issue_read_grant`, `scope`, `run_id`, `grant_id`, `outside_grant`

### L5-read-tool-audit-redaction

- **Functional signature:** read calls emit audit records and redacted model-visible output - produces auditable redaction - prevents silent data egress.
- **Alternative names:** tool audit, audit redaction, redacted tool output, read audit, tool call log
- **Detection signals:**
  - Files/dirs: `tool_registry`, `audit`, `redaction`, `level_05`
  - Schemas/deps: `audit-record`, redaction policies, data governance helpers
  - Code/log shapes: `AuditRecord`, `redacted_output`, `actor`, `args_hash`, `result_hash`

### L5-mcp-conformance-derived-from-manifest

- **Functional signature:** MCP tool surface derives from internal manifest - produces conformance evidence - prevents protocol drift.
- **Alternative names:** MCP conformance, manifest-derived MCP, protocol adapter check, tools-list validator, MCP drift test
- **Detection signals:**
  - Files/dirs: `mcp_adapter`, `protocol_conformance`, `level_05_server`, `mcp/`
  - Schemas/deps: MCP tool schemas, manifest schemas, conformance tests
  - Code/log shapes: `tools/list`, `tools/call`, `mcp_exposure_status`, `manifest`, `conformance`

### L5-tool-output-sanitization

- **Functional signature:** upstream tool output is sanitized and instruction-shaped fragments are labeled - produces sanitized payload and detections - prevents tool-output injection.
- **Alternative names:** tool sanitizer, output sanitizer, tool injection guard, confused-deputy guard, control-char stripping
- **Detection signals:**
  - Files/dirs: `sanitization`, `tool-output`, `adversarial`, `level_05/examples`
  - Schemas/deps: injection detection records, sanitizer utilities
  - Code/log shapes: `control_character`, `instruction_override`, `sanitized_payload`, `raw_output`, `redacted_output`

### L5-native-tool-conformance

- **Functional signature:** framework-native tools share one engine and conformance harness - produces comparable audit records - prevents adapter bypass.
- **Alternative names:** native tool conformance, adapter conformance, framework tool parity, shared tool engine, tool parity harness
- **Detection signals:**
  - Files/dirs: `implementations/*/level_05`, `framework_tracks`, `tool_registry`
  - Schemas/deps: provider matrix, framework conformance tests, audit records
  - Code/log shapes: `native_tool`, `framework`, `conformance`, `audit_record`, `shared_engine`

### L6-model-recommends-runtime-assembles

- **Functional signature:** runtime assembles executable writes while model recommendation is review evidence - produces divergence records - prevents model-authored writes.
- **Alternative names:** runtime assembly, deterministic action assembly, model recommends, write assembler, action templating
- **Detection signals:**
  - Files/dirs: `level_06`, `native_runtime`, `write-tools`, `action_templates`
  - Schemas/deps: tool action schema, approval schema, ticket/action fixtures
  - Code/log shapes: `proposed_action`, `runtime_assembled`, `model_recommendation`, `arguments_digest`, `divergence`

### L6-approval-binding-hash

- **Functional signature:** approval is consumed only when binding hash matches exact action - produces gate evidence - prevents approval substitution.
- **Alternative names:** binding hash, approval binding, action binding, approval gate, exact-action approval
- **Detection signals:**
  - Files/dirs: `approvals`, `level_06/inputs`, `approval-binding`, `native_runtime`
  - Schemas/deps: `approval-record`, canonical JSON, hash utilities
  - Code/log shapes: `binding`, `binding_hash`, `gate_status`, `approval_consumed`, `arguments_digest`

### L6-one-shot-credential-lease

- **Functional signature:** approved write lease is action-bound and consumed once - produces lease records - prevents replayed write authority.
- **Alternative names:** one-shot lease, write lease, action lease, temporary credential, leased authority
- **Detection signals:**
  - Files/dirs: `access/leases`, `credential-lease`, `writes`, `level_06`
  - Schemas/deps: `credential-lease`, lease store, write registry
  - Code/log shapes: `CredentialLease`, `lease_id`, `consumed_at`, `action_id`, `idempotency_key`

### L6-idempotent-write-replay

- **Functional signature:** same idempotency key returns prior action without mutation - produces replay record - prevents duplicate writes.
- **Alternative names:** idempotent replay, retry protection, duplicate write guard, replay-safe write, idempotency gate
- **Detection signals:**
  - Files/dirs: `idempotency`, `writes`, `incident`, `level_06/examples`
  - Schemas/deps: `tool-action`, idempotency store, rollback plan
  - Code/log shapes: `idempotency_key`, `prior_tool_action`, `replay`, `already_executed`, `no_new_mutation`

### L6-rollback-metadata-on-every-write

- **Functional signature:** executed writes carry typed rollback or correction plan - produces recovery metadata - prevents unrecoverable side effects.
- **Alternative names:** rollback plan, recovery metadata, compensation path, correction plan, write recovery
- **Detection signals:**
  - Files/dirs: `rollback`, `incident`, `writes`, `level_06`
  - Schemas/deps: `rollback-plan`, `tool-action`, incident helpers
  - Code/log shapes: `RollbackPlan`, `correction_path`, `reverse`, `compensate`, `append_only_correction`

### L6-signed-approval-record

- **Functional signature:** approval payloads are signed and verified before binding - produces signature gate status - prevents at-rest tampering.
- **Alternative names:** signed approval, approval signature, Ed25519 approval, approval attestation, signed gate
- **Detection signals:**
  - Files/dirs: `signing`, `adversarial_keys`, `approvals`, `level_06`
  - Schemas/deps: Ed25519 signing, key registry, approval records
  - Code/log shapes: `signature_invalid`, `key_id`, `canonical_json`, `rotated`, `revoked`

### L6-customer-safety-block-gate

- **Functional signature:** customer-visible writes run safety gate before approval resolution - produces block gate status - prevents approved unsafe customer text.
- **Alternative names:** customer write safety, safety block, leak block gate, customer-visible gate, write output guard
- **Detection signals:**
  - Files/dirs: `customer_safety`, `data`, `level_06`, `approval_gate`
  - Schemas/deps: validation reports, data governance checks, approval records
  - Code/log shapes: `customer_safety_block`, `customer_visible`, `safety_check`, `short_circuit`, `leak_terms`

### L7-signed-goal-with-immutable-scope

- **Functional signature:** signed goal fixes scope, budget, expiry, and allowed tools - produces goal verification records - prevents scope widening.
- **Alternative names:** signed goal, immutable goal, goal contract, scoped objective, task contract
- **Detection signals:**
  - Files/dirs: `goals`, `level_07/inputs`, `goal-record`, `signed_goals`
  - Schemas/deps: `goal-record`, signing utilities, key registry
  - Code/log shapes: `Goal`, `signature`, `allowed_tool_scopes`, `expires_at`, `scope_modified`

### L7-success-criteria-predicate-registry

- **Functional signature:** runtime-owned predicates decide completion from evidence - produces predicate eval records - prevents model self-granting done.
- **Alternative names:** predicate registry, success criteria registry, runtime predicates, completion checks, invariant registry
- **Detection signals:**
  - Files/dirs: `predicates`, `goals/predicates`, `success_criteria`, `level_07`
  - Schemas/deps: goal records, predicate definitions, runtime evidence
  - Code/log shapes: `predicate_id`, `eval_predicate`, `goal_complete`, `runtime_evidence`, `DECLARE_DONE`

### L7-task-agent-stop-reasons

- **Functional signature:** closed stop reasons and budgets govern loop exits - produces halt/resolution records - prevents unbounded or untyped agent loops.
- **Alternative names:** stop reasons, halt reasons, typed stops, budget halt, escalation classifier
- **Detection signals:**
  - Files/dirs: `stop_reasons`, `budget`, `progress`, `escalation`, `level_07`
  - Schemas/deps: `halt-record`, `resolution-package`, budget helpers
  - Code/log shapes: `StopReason`, `budget_exhausted`, `no_progress`, `tool_failure`, `classify_escalation`

### L7-memory-write-validation

- **Functional signature:** memory writes pass seven-stage validation and reads are redacted/tenant-scoped - produces memory records - prevents poisoning and leakage.
- **Alternative names:** memory validator, memory guard, memory policy, tenant-scoped memory, memory DLP
- **Detection signals:**
  - Files/dirs: `memory`, `validators`, `memory-record`, `level_07/examples`
  - Schemas/deps: `memory-record`, PII detector, retention policy
  - Code/log shapes: `MemoryRecord`, `content_redacted`, `source_frame`, `tenant_id`, `retention`, `persistent`

### L8-signed-a2a-card

- **Functional signature:** signed agent cards verify peer identity and capabilities - produces registry/security records - prevents spoofed peers.
- **Alternative names:** signed agent card, A2A card, peer identity card, agent manifest, signed capability card
- **Detection signals:**
  - Files/dirs: `agent_cards`, `agents`, `level_08/inputs`, `a2a`
  - Schemas/deps: `agent-card`, signing helpers, security findings
  - Code/log shapes: `AgentCard`, `card_verification`, `capabilities`, `allowed_peers`, `SecurityFinding`

### L8-validator-veto-handoff

- **Functional signature:** validator role binds decision to artifact and can veto route - produces validation/handoff evidence - prevents advisory validation.
- **Alternative names:** validator veto, validation handoff, reviewer agent, artifact-bound validation, veto gate
- **Detection signals:**
  - Files/dirs: `validator`, `handoff`, `validation-decision`, `level_08`
  - Schemas/deps: `validation-decision`, `handoff-envelope`, artifact hash
  - Code/log shapes: `validator_veto`, `ValidationDecision`, `payload_hash`, `artifact_hash`, `revise_or_escalate`

### L8-durable-orchestration-state

- **Functional signature:** orchestration checkpoints resume without duplicate side effects - produces durable state - prevents crash replay damage.
- **Alternative names:** durable orchestration, checkpointed workflow, resumable state, orchestration checkpoint, crash resume
- **Detection signals:**
  - Files/dirs: `checkpoint`, `orchestrator`, `sqlite_checkpoint`, `level_08/examples`
  - Schemas/deps: `orchestration-checkpoint`, durable store, idempotency keys
  - Code/log shapes: `OrchestrationCheckpoint`, `resume`, `checkpoint_id`, `tool_calls`, `approval_state`

### L9-policy-eligibility-gate

- **Functional signature:** signed eligibility schema gates autonomous execution and escalates ineligible work - produces eligibility decisions - prevents self-authorized autonomy.
- **Alternative names:** policy gate, eligibility gate, autonomy policy, eligibility schema, autonomous allowlist
- **Detection signals:**
  - Files/dirs: `policy`, `eligibility`, `level_09/inputs`, `worker`
  - Schemas/deps: `eligibility-schema`, `eligibility-decision`, policy signing
  - Code/log shapes: `EligibilityDecision`, `allowed=false`, `auto_escalate`, `allow_criteria`, `policy_attestation`

### L9-global-pause-and-dead-letter

- **Functional signature:** global pause halts autonomous workers and dead-letters work for replay - produces pause/DLQ records - prevents ignored kill switches and lost cases.
- **Alternative names:** global pause, kill switch, dead letter queue, autonomous halt, pause flag
- **Detection signals:**
  - Files/dirs: `global_pause`, `dead_letter`, `policy/queue`, `level_09/examples`
  - Schemas/deps: `global-pause-flag`, `dead-lettered-case`, queue lease
  - Code/log shapes: `GlobalPauseFlag`, `DeadLetteredCase`, `paused`, `dead_letter_added`, `queue_lease`

### L9-continuous-adversarial-eval-corpus

- **Functional signature:** autonomous startup requires fresh adversarial corpus and red-team findings promote coverage - produces eval/freshness records - prevents stale safety gates.
- **Alternative names:** adversarial corpus, red-team corpus, continuous safety evals, autonomy eval gate, corpus freshness gate
- **Detection signals:**
  - Files/dirs: `adversarial_corpus`, `red_team`, `level_09/examples`, `policy`
  - Schemas/deps: `adversarial-eval-corpus`, `red-team-finding`, eval results
  - Code/log shapes: `corpus_freshness`, `required_threat_classes`, `startup_gate`, `red_team_finding`, `coverage_missing`

### L10-evidence-backed-improvement-proposal

- **Functional signature:** operational signals become signed PR-shaped proposals with evidence, tests, review, and risk - produces proposal lifecycle records - prevents side-channel self-modification.
- **Alternative names:** improvement proposal, governed proposal, PR-shaped change, evidence-backed change, proposal pipeline
- **Detection signals:**
  - Files/dirs: `proposals`, `level_10/inputs`, `improvement-proposal`, `change_control`
  - Schemas/deps: `improvement-proposal`, `proposal-review`, `proposal-waiver`
  - Code/log shapes: `source_run_ids`, `regression_tests`, `proposal_signature`, `reviewer_signoff`, `payload_digest`

### L10-adversarial-release-gate

- **Functional signature:** candidate release checks per-threat-class adversarial regression against signed baselines - produces release and waiver records - prevents aggregate score masking.
- **Alternative names:** release gate, adversarial gate, eval gate, safety regression gate, governed rollout
- **Detection signals:**
  - Files/dirs: `release_gate`, `adversarial_evals`, `candidate-release`, `level_10/examples`
  - Schemas/deps: `candidate-release`, `eval-baseline`, `release-decision`, parity tests
  - Code/log shapes: `per_class`, `baseline_signature`, `release_gate_inconsistent`, `waivable=false`, `promotion_blocked`
