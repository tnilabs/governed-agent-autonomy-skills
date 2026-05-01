---
canon_version: 3.1.0
last_reviewed: 2026-05-01
---

# Synonyms and Detection Signals

Assess and review skills consult this file before claiming a control or
pattern is missing. Controls and patterns are functional categories, not
names. A user system has the capability if it produces the evidence and
prevents the failure under any local naming.

Every entry has a functional signature, at least three alternative names, and
at least four detection-signal categories, including conceptual equivalents.

## Conceptual Equivalence Rules

Use synonyms as clues, not as a string-matching checklist. A user system
satisfies a control or pattern when its local structure has the same functional
meaning: it fits the same workflow context, carries the same authority
boundary, produces the same evidence semantics, blocks the same failure mode,
and enforces the same runtime boundary. Different file names, schema names,
record names, service boundaries, framework primitives, or workflow shapes can
be equivalent.
Canonical GAAM names are semantic anchors. Example artifact names are non-normative context cues, not required strings. GAAM does not define required record names.
Names such as approval evidence, action authority grant, tool event, audit
event, or evidence pack are examples of evidence shapes; equivalent local events,
schemas, logs, tickets, services, or external systems can satisfy them.
Mark evidence `partial` when only some parts of the functional signature exist.
Record the local name or structure, the GAAM item it maps to, and the reason the
mapping is equivalent or not.

## Controls

### Threat & Adversarial Resilience

- **Functional signature:** hostile input, substrate tampering, poisoning, and adversarial-regression defenses - produces detection, provenance, verification, red-team, and eval records - prevents silent compromise.
- **Alternative names:** prompt guard, jailbreak detector, prompt firewall, security middleware, adversarial eval gate, red-team corpus, safety classifier, input trust boundary, attack replay suite, substrate integrity check
- **Detection signals:**
  - Files/dirs: `adversarial/`, `guards/`, `security/`, `threat_model`, `red_team`, `eval_corpus`
  - Context/evidence cues: threat detections, security findings, adversarial evaluation results, signature verification
  - Code/log shapes: `threat_detected`, `security_finding`, `signature_invalid`, `adversarial_eval_passed`, `prompt_blocked`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Agent Registry & Lifecycle

- **Functional signature:** agent inventory, lifecycle, health, owner, pause, revocation, and release state - produces registry and operator records - prevents shadow agents and missing kill switches.
- **Alternative names:** agent registry, control plane, ops dashboard, admin console, agent fleet, lifecycle registry, operator console, agent inventory, autonomy control plane, runtime pause panel
- **Detection signals:**
  - Files/dirs: `agent_registry/`, `control_plane/`, `ops/`, `admin/`, `lifecycle/`
  - Context/evidence cues: verifiable agent identity, routing authority, halt decisions, pause state
  - Code/log shapes: `agent_identity`, `agent_registered`, `agent_paused`, `risk_tier`, `lifecycle_state`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Evidence & Assurance

- **Functional signature:** self-contained bundle of run, review, eval, audit, approval, rollback, handoff, eligibility, and release evidence - produces defensible audit artifacts - prevents audit-by-memory.
- **Alternative names:** evidence bundle, audit pack, attestation pack, compliance report, audit export, run dossier, assurance packet, evidence dossier, examiner packet, control evidence export
- **Detection signals:**
  - Files/dirs: `evidence/`, `compliance/`, `audit_export/`, `attestations/`, `reports/`
  - Context/evidence cues: run evidence, human review evidence, approval evidence, release decisions
  - Code/log shapes: `enterprise_evidence`, `control_summary`, `evidence_id`, `attestation_signature`, `release_bundle`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Delegated Authority & Access

- **Functional signature:** scoped grants, one-shot action authority, delegation chains, principal binding, and revocation - produces authority records - prevents blanket credentials and wrong-principal action.
- **Alternative names:** scoped credentials, delegated auth, identity broker, on-behalf-of, authority broker, RBAC, temporary authority, principal-bound token, capability grant, action grant
- **Detection signals:**
  - Files/dirs: `access/`, `auth/`, `iam/`, `authority/`, `delegation/`, `principals/`
  - Context/evidence cues: authority grants, credential revocation events, approval evidence, policy engines
  - Code/log shapes: `authority_grant`, `issue_read_grant`, `grant_consumed`, `actor`, `principal`, `revoked`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Data, Context & Memory Governance

- **Functional signature:** classification, provenance, redaction, retention, residency, tenant isolation, and memory policy - produces data-handling records - prevents leakage and unbounded data retention.
- **Alternative names:** data classification, DLP, privacy guard, PII redaction, retention policy, data residency, source trust metadata, tenant isolation, corpus governance, memory governance
- **Detection signals:**
  - Files/dirs: `data_governance/`, `privacy/`, `redaction/`, `dlp/`, `memory/`, `knowledge-index`
  - Context/evidence cues: source provenance, memory evidence, redaction decisions, privacy scanners
  - Code/log shapes: `classification`, `sensitivity`, `redacted_output`, `retention`, `tenant_id`, `pii_redacted`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Tool & Protocol Safety

- **Functional signature:** protocol surfaces are derived from runtime contracts and fail closed on drift - produces conformance and rejection records - prevents adapters lying about capabilities.
- **Alternative names:** schema conformance, MCP validator, A2A conformance, contract testing, adapter validation, protocol guard, surface parity, manifest-derived API, protocol drift gate, adapter contract
- **Detection signals:**
  - Files/dirs: `protocol_conformance/`, `mcp/`, `a2a/`, `schemas/`, `contracts/`, `adapters/`
  - Context/evidence cues: tool action contracts, peer identity, handoff envelopes, schema validators
  - Code/log shapes: `tools/list`, `validate_against_schema`, `contract_violation`, `requires_approval`, `side_effect_class`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Incident Response & Recovery

- **Functional signature:** failures are detected, paused, replayed, rolled back, compensated, dead-lettered, and converted into tests - produces containment and recovery evidence - prevents recurrence and unrecoverable side effects.
- **Alternative names:** incident management, runbook, rollback, dead letter queue, kill switch, postmortem, containment workflow, replay harness, compensation plan, recovery ledger
- **Detection signals:**
  - Files/dirs: `incident/`, `rollback/`, `dead_letter/`, `runbooks/`, `postmortems/`, `replay/`
  - Context/evidence cues: recovery plans, dead-lettered work, pause state, halt decisions
  - Code/log shapes: `rollback_path`, `action_result`, `global_pause`, `dead_letter_added`, `replay_started`, `postmortem`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Runtime Isolation & Execution Safety

- **Functional signature:** runtime authority, workspace, filesystem, network, subprocess, artifact, retry, cleanup, and replay boundaries are enforced - produces isolation and execution evidence - prevents broad host access and unsafe autonomous execution.
- **Alternative names:** sandbox policy, execution guard, runtime containment, workspace isolation, network egress policy, artifact lifecycle, code execution boundary, job isolation, worker sandbox, environment guard
- **Detection signals:**
  - Files/dirs: `sandbox/`, `runtime/`, `execution/`, `workspaces/`, `artifacts/`, `isolation/`, `egress/`
  - Context/evidence cues: runtime policy evidence, artifact manifests, sandbox libraries, container profiles, seccomp, network policy, job ownership claims
  - Code/log shapes: `workspace_id`, `sandbox_id`, `network_denied`, `filesystem_scope`, `cleanup_completed`, `artifact_manifest`, `execution_limit_exceeded`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Observability & Telemetry

- **Functional signature:** agent records map to portable traces, metrics, logs, and events - produces operation attributes and correlation IDs - prevents custom event islands.
- **Alternative names:** telemetry mapping, tracing, observability, distributed tracing, telemetry pipeline, span mapper, run correlation, trace bridge, metric export, agent telemetry mapping
- **Detection signals:**
  - Files/dirs: `telemetry/`, `tracing/`, `observability/`, `metrics/`, `events/`
  - Context/evidence cues: trace events, run evidence, telemetry SDKs, tracing libraries, event schemas
  - Code/log shapes: `trace_id`, `span_id`, `correlation_id`, `agent.run_id`, `agent.tool_call_id`, `release_trace_records`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### Value, Cost & Reliability

- **Functional signature:** cost, latency, budget, retry, outcome, SLO, and value deltas are measured against the business baseline - produces cost/value records - prevents spend and outcome drift.
- **Alternative names:** finops, cost tracking, budget guard, value metrics, unit economics, SLO budget, spend guardrail, latency budget, outcome ledger, ROI evidence
- **Detection signals:**
  - Files/dirs: `cost/`, `budget/`, `slo/`, `value/`, `finops/`, `metrics/`
  - Context/evidence cues: cost evidence, SLO bands, goal evidence, resolution outcomes
  - Code/log shapes: `budget_exhausted`, `slo_burn`, `cost_usd`, `value_metric_rollup`, `retry_budget`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

## Patterns

### L1-baseline-failure-cataloguing

- **Functional signature:** typed baseline work-item failure catalogue with manual cost/risk/adversarial tags - produces comparable L1 evidence - prevents unfalsifiable improvement claims.
- **Alternative names:** baseline catalog, failure inventory, current-state measurement, unmanaged prompt baseline, manual-work baseline
- **Detection signals:**
  - Files/dirs: `baseline_cases/`, `level_01/`, `prompts/`, `baseline-report`
  - Context/evidence cues: baseline work-item fixtures, risk labels, failure labels
  - Code/log shapes: `failure_category`, `manual_time`, `handoffs`, `adversarial_failure_modes`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L2-process-as-substrate

- **Functional signature:** explicit workflow, owners, policies, templates, validation, and L1 failure mappings - produces process substrate - prevents automating undocumented habits.
- **Alternative names:** human process contract, SOP substrate, workflow map, process controls, policy-stage mapping
- **Detection signals:**
  - Files/dirs: `human_process/`, `workflow.yaml`, `policies.yaml`, `templates/`, `level-01-baseline-to-process`
  - Context/evidence cues: process reports, policy rule IDs, stage definitions
  - Code/log shapes: `stage_id`, `owner`, `exit_criteria`, `policy_id`, `baseline_failure_process_links`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L2-threat-model-as-substrate

- **Functional signature:** typed threat model with stable surface IDs and mitigations - produces references for later defenses - prevents disconnected reactive security.
- **Alternative names:** threat model, risk surface catalog, adversarial surface map, abuse-case register, security model
- **Detection signals:**
  - Files/dirs: `threat-model.yaml`, `threat_model`, `security/`, `level_02/`
  - Context/evidence cues: threat-model structure, actors, mitigations, surface IDs
  - Code/log shapes: `surface_id`, `actor`, `motivation`, `mitigations`, `out_of_scope`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L3-knowledge-coverage-map

- **Functional signature:** knowledge docs map to work items, failures, stages, and policies - produces coverage evidence - prevents irrelevant or incomplete corpora.
- **Alternative names:** coverage map, knowledge matrix, evidence coverage, corpus mapping, policy-evidence map
- **Detection signals:**
  - Files/dirs: `knowledge-coverage`, `knowledge_base/`, `knowledge-index`, `level_03/evals`
  - Context/evidence cues: coverage fixtures, evidence IDs, retrieval eval definitions
  - Code/log shapes: `evidence_id`, `case_id`, `failure_label`, `stage_id`, `policy_id`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L3-golden-retrieval-evals

- **Functional signature:** reviewed retrieval evals versioned with corpus; observed signals stay candidate-only - produces retrieval quality gate - prevents unreviewed live-query drift.
- **Alternative names:** golden evals, retrieval tests, seed eval set, corpus evals, search relevance checks
- **Detection signals:**
  - Files/dirs: `retrieval-evals`, `retrieval-signals`, `evals/`, `level_03/`
  - Context/evidence cues: eval fixtures, promoted/candidate status, reviewer fields
  - Code/log shapes: `golden`, `observed_query`, `candidate`, `promoted`, `reviewed_by`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L3-provenance-attested-source

- **Functional signature:** retrievable sources carry classification, review status, and provenance attestation - produces source trust metadata - prevents silently quoting unverified sources.
- **Alternative names:** source attestation, provenance metadata, signed source, classified corpus, evidence provenance
- **Detection signals:**
  - Files/dirs: `provenance`, `knowledge-index`, `asset_documents`, `knowledge_indexer`
  - Context/evidence cues: source provenance, content digest, issuer, signature
  - Code/log shapes: `verification_status`, `review_status`, `sensitivity`, `source_id`, `content_digest`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L4-pending-review-boundary

- **Functional signature:** all assistant outputs stop at human review with side effects disabled - produces review/run evidence - prevents unreviewed outputs shipping.
- **Alternative names:** review boundary, HITL gate, pending review, draft gate, human review state
- **Detection signals:**
  - Files/dirs: `review/`, `human_review`, `level_04`, `assistant_output`
  - Context/evidence cues: human review evidence, run evidence, review status
  - Code/log shapes: `pending_review`, `side_effects_allowed=false`, `review_status`, `HumanReviewRecord`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L4-provenance-framed-prompt-assembly

- **Functional signature:** prompt context uses explicit trust frames - produces provenance markers - prevents untrusted text from becoming instructions.
- **Alternative names:** framed prompt, trust framing, provenance framing, prompt assembly, source-framed context
- **Detection signals:**
  - Files/dirs: `framing`, `prompt_assembly`, `adversarial`, `level_04`
  - Context/evidence cues: provenance evidence, prompt providers, source metadata
  - Code/log shapes: `[system]`, `[external input]`, `[customer message]`, `[retrieved evidence`, `verified=`, `source_frame`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L4-customer-safe-output-check

- **Functional signature:** external-facing drafts pass typed leak/safety checks before review - produces validation records - prevents sensitive/internal text leakage.
- **Alternative names:** external-output safety check, leak checker, output guard, response validator, external-facing gate
- **Detection signals:**
  - Files/dirs: `data/`, `validation`, `external_output`, `customer_safe`, `assistant_output`
  - Context/evidence cues: validation reports, leak terms, external response structure
  - Code/log shapes: `ValidationReport`, `external_facing`, `customer_visible`, `leak_terms`, `blocks_acceptance`, `internal_marker`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L4-adversarial-input-labeling

- **Functional signature:** hostile input is labeled and framed lower-trust - produces injection detections - prevents instruction override from gaining authority.
- **Alternative names:** injection labeling, prompt-injection detector, hostile input labeler, lower-trust labeling, attack classifier
- **Detection signals:**
  - Files/dirs: `adversarial/detection`, `patterns/v1`, `injection`, `level_04`
  - Context/evidence cues: injection detections, pattern library, detector version
  - Code/log shapes: `threat_detected`, `action=label`, `source_frame`, `instruction_override`, `pattern_id`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-typed-tool-manifest-with-scope

- **Functional signature:** tools declare schemas, scope, and read-only side-effect class - produces manifests - prevents untyped or write-capable L5 tools.
- **Alternative names:** tool manifest, scoped tools, typed tools, read-tool manifest, tool schema registry
- **Detection signals:**
  - Files/dirs: `tools/read-tools`, `tool_registry`, `manifests`, `level_05/tools`
  - Context/evidence cues: tool action contracts, input/output structures, tool and protocol safety
  - Code/log shapes: `permission_scope`, `side_effect_class`, `read_only`, `input_schema`, `output_schema`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-scoped-grant-per-run

- **Functional signature:** each run gets a scoped read grant required by the registry - produces grant/audit evidence - prevents blanket read authority.
- **Alternative names:** read grant, scoped grant, per-run authority, delegated read access, narrow credential
- **Detection signals:**
  - Files/dirs: `access/`, `grants`, `tool_registry`, `level_05`
  - Context/evidence cues: grant evidence, audit evidence, identity broker
  - Code/log shapes: `issue_read_grant`, `scope`, `run_id`, `grant_id`, `outside_grant`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-read-tool-audit-redaction

- **Functional signature:** read calls emit audit records and redacted model-visible output - produces auditable redaction - prevents silent data egress.
- **Alternative names:** tool audit, audit redaction, redacted tool output, read audit, tool call log
- **Detection signals:**
  - Files/dirs: `tool_registry`, `audit`, `redaction`, `level_05`
  - Context/evidence cues: audit evidence, redaction policies, data, context, and memory governance helpers
  - Code/log shapes: `audit_event`, `redacted_output`, `actor`, `args_hash`, `result_hash`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-mcp-conformance-derived-from-manifest

- **Functional signature:** MCP tool surface derives from internal manifest - produces conformance evidence - prevents protocol drift.
- **Alternative names:** MCP conformance, manifest-derived MCP, protocol adapter check, tools-list validator, MCP drift test
- **Detection signals:**
  - Files/dirs: `mcp_adapter`, `protocol_conformance`, `level_05_server`, `mcp/`
  - Context/evidence cues: MCP tool schemas, manifest structures, conformance tests
  - Code/log shapes: `tools/list`, `tools/call`, `mcp_exposure_status`, `manifest`, `conformance`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-tool-output-sanitization

- **Functional signature:** upstream tool output is sanitized and instruction-shaped fragments are labeled - produces sanitized payload and detections - prevents tool-output injection.
- **Alternative names:** tool sanitizer, output sanitizer, tool injection guard, confused-deputy guard, control-char stripping
- **Detection signals:**
  - Files/dirs: `sanitization`, `tool-output`, `adversarial`, `level_05/examples`
  - Context/evidence cues: injection detections, sanitizer utilities
  - Code/log shapes: `control_character`, `instruction_override`, `sanitized_payload`, `raw_output`, `redacted_output`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L5-native-tool-conformance

- **Functional signature:** framework-native tools share one engine and conformance harness - produces comparable audit records - prevents adapter bypass.
- **Alternative names:** native tool conformance, adapter conformance, framework tool parity, shared tool engine, tool parity harness
- **Detection signals:**
  - Files/dirs: `implementations/*/level_05`, `framework_tracks`, `tool_registry`
  - Context/evidence cues: provider matrix, framework conformance tests, audit evidence
  - Code/log shapes: `native_tool`, `framework`, `conformance`, `audit_record`, `shared_engine`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-model-recommends-runtime-assembles

- **Functional signature:** runtime assembles executable actions while model recommendation is review evidence - produces divergence records - prevents model-authored side effects.
- **Alternative names:** runtime assembly, deterministic action assembly, model recommends, action assembler, action templating
- **Detection signals:**
  - Files/dirs: `level_06`, `native_runtime`, `action_tools`, `action_templates`
  - Context/evidence cues: tool action structure, approval structure, ticket/action fixtures
  - Code/log shapes: `proposed_action`, `runtime_assembled`, `model_recommendation`, `arguments_digest`, `divergence`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-approval-binding-hash

- **Functional signature:** approval is consumed only when binding hash matches exact action - produces gate evidence - prevents approval substitution.
- **Alternative names:** binding hash, approval binding, action binding, approval gate, exact-action approval
- **Detection signals:**
  - Files/dirs: `approvals`, `level_06/inputs`, `approval-binding`, `native_runtime`
  - Context/evidence cues: approval evidence, canonical JSON, hash utilities
  - Code/log shapes: `binding`, `binding_hash`, `gate_status`, `approval_consumed`, `arguments_digest`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-one-shot-action-authority

- **Functional signature:** approved action authority is action-bound and consumed once - produces authority grant records - prevents replayed side-effect authority.
- **Alternative names:** one-shot authority, action grant, temporary action authority, temporary credential, delegated action authority
- **Detection signals:**
  - Files/dirs: `access/authority`, `action_grants`, `actions`, `level_06`
  - Context/evidence cues: authority grant store, action registry, idempotency store
  - Code/log shapes: `action_authority_grant`, `grant_id`, `consumed_at`, `action_id`, `idempotency_key`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-idempotent-action-replay

- **Functional signature:** same idempotency key returns prior action without mutation - produces replay record - prevents duplicate side effects.
- **Alternative names:** idempotent replay, retry protection, duplicate action guard, replay-safe action, idempotency gate
- **Detection signals:**
  - Files/dirs: `idempotency`, `actions`, `incident`, `level_06/examples`
  - Context/evidence cues: tool action evidence, idempotency store, recovery plan
  - Code/log shapes: `idempotency_key`, `prior_tool_action`, `replay`, `already_executed`, `no_new_mutation`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-recovery-metadata-on-every-action

- **Functional signature:** executed side-effecting actions carry typed rollback, compensation, or correction paths - produces recovery metadata - prevents unrecoverable side effects.
- **Alternative names:** rollback plan, recovery metadata, compensation path, correction plan, action recovery
- **Detection signals:**
  - Files/dirs: `rollback`, `incident`, `actions`, `level_06`
  - Context/evidence cues: recovery plans, tool action evidence, incident helpers
  - Code/log shapes: `rollback_path`, `correction_path`, `reverse`, `compensate`, `append_only_correction`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-signed-approval-evidence

- **Functional signature:** approval payloads are signed and verified before binding - produces signature gate status - prevents at-rest tampering.
- **Alternative names:** signed approval, approval signature, Ed25519 approval, approval attestation, signed gate
- **Detection signals:**
  - Files/dirs: `signing`, `adversarial_keys`, `approvals`, `level_06`
  - Context/evidence cues: Ed25519 signing, key registry, approval evidence
  - Code/log shapes: `signature_invalid`, `key_id`, `canonical_json`, `rotated`, `revoked`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L6-customer-safety-block-gate

- **Functional signature:** external-facing actions run safety gate before approval resolution - produces block gate status - prevents approved unsafe recipient-facing text.
- **Alternative names:** external action safety, safety block, leak block gate, external-facing gate, action output guard
- **Detection signals:**
  - Files/dirs: `external_output_safety`, `customer_safety`, `data`, `level_06`, `approval_gate`
  - Context/evidence cues: validation reports, data, context, and memory governance checks, approval evidence
  - Code/log shapes: `external_safety_block`, `customer_safety_block`, `external_facing`, `customer_visible`, `safety_check`, `short_circuit`, `leak_terms`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L7-signed-goal-with-immutable-scope

- **Functional signature:** signed goal fixes scope, budget, expiry, and allowed tools - produces goal verification records - prevents scope widening.
- **Alternative names:** signed goal, immutable goal, goal contract, scoped objective, task contract
- **Detection signals:**
  - Files/dirs: `goals`, `level_07/inputs`, `goal-record`, `signed_goals`
  - Context/evidence cues: goal evidence, signing utilities, key registry
  - Code/log shapes: `Goal`, `signature`, `allowed_tool_scopes`, `expires_at`, `scope_modified`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L7-success-criteria-predicate-registry

- **Functional signature:** runtime-owned predicates decide completion from evidence - produces predicate eval records - prevents model self-granting done.
- **Alternative names:** predicate registry, success criteria registry, runtime predicates, completion checks, invariant registry
- **Detection signals:**
  - Files/dirs: `predicates`, `goals/predicates`, `success_criteria`, `level_07`
  - Context/evidence cues: goal evidence, predicate definitions, runtime evidence
  - Code/log shapes: `predicate_id`, `eval_predicate`, `goal_complete`, `runtime_evidence`, `DECLARE_DONE`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L7-task-agent-stop-reasons

- **Functional signature:** closed stop reasons and budgets govern loop exits - produces halt/resolution records - prevents unbounded or untyped agent loops.
- **Alternative names:** stop reasons, halt reasons, typed stops, budget halt, escalation classifier
- **Detection signals:**
  - Files/dirs: `stop_reasons`, `budget`, `progress`, `escalation`, `level_07`
  - Context/evidence cues: halt decisions, resolution outcomes, budget helpers
  - Code/log shapes: `StopReason`, `budget_exhausted`, `no_progress`, `tool_failure`, `classify_escalation`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L7-memory-write-validation

- **Functional signature:** memory writes pass seven-stage validation and reads are redacted/tenant-scoped - produces memory records - prevents poisoning and leakage.
- **Alternative names:** memory validator, memory guard, memory policy, tenant-scoped memory, memory DLP
- **Detection signals:**
  - Files/dirs: `memory`, `validators`, `memory-record`, `level_07/examples`
  - Context/evidence cues: memory evidence, PII detector, retention policy
  - Code/log shapes: `memory_write`, `content_redacted`, `source_frame`, `tenant_id`, `retention`, `persistent`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L8-signed-a2a-card

- **Functional signature:** signed agent cards verify peer identity and capabilities - produces registry/security records - prevents spoofed peers.
- **Alternative names:** signed agent card, A2A card, peer identity card, agent manifest, signed capability card
- **Detection signals:**
  - Files/dirs: `agent_cards`, `agents`, `level_08/inputs`, `a2a`
  - Context/evidence cues: peer identity evidence, signing helpers, security findings
  - Code/log shapes: `agent_identity`, `peer_verification`, `capabilities`, `allowed_peers`, `security_finding`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L8-validator-veto-handoff

- **Functional signature:** validator role binds decision to artifact and can veto route - produces validation/handoff evidence - prevents advisory validation.
- **Alternative names:** validator veto, validation handoff, reviewer agent, artifact-bound validation, veto gate
- **Detection signals:**
  - Files/dirs: `validator`, `handoff`, `validation-decision`, `level_08`
  - Context/evidence cues: validation decisions, handoff envelopes, artifact hash
  - Code/log shapes: `validator_veto`, `ValidationDecision`, `payload_hash`, `artifact_hash`, `revise_or_escalate`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L8-durable-orchestration-state

- **Functional signature:** orchestration checkpoints resume without duplicate side effects - produces durable state - prevents crash replay damage.
- **Alternative names:** durable orchestration, checkpointed workflow, resumable state, orchestration checkpoint, crash resume
- **Detection signals:**
  - Files/dirs: `checkpoint`, `orchestrator`, `sqlite_checkpoint`, `level_08/examples`
  - Context/evidence cues: orchestration checkpoints, durable store, idempotency keys
  - Code/log shapes: `OrchestrationCheckpoint`, `resume`, `checkpoint_id`, `tool_calls`, `approval_state`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L9-policy-eligibility-gate

- **Functional signature:** signed eligibility schema gates autonomous execution and escalates ineligible work - produces eligibility decisions - prevents self-authorized autonomy.
- **Alternative names:** policy gate, eligibility gate, autonomy policy, eligibility schema, autonomous allowlist
- **Detection signals:**
  - Files/dirs: `policy`, `eligibility`, `level_09/inputs`, `worker`
  - Context/evidence cues: eligibility policy, eligibility decisions, policy signing
  - Code/log shapes: `eligibility_decision`, `allowed=false`, `auto_escalate`, `allow_criteria`, `policy_attestation`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L9-global-pause-and-dead-letter

- **Functional signature:** global pause halts autonomous workers and dead-letters work for replay - produces pause/DLQ records - prevents ignored kill switches and lost work.
- **Alternative names:** global pause, kill switch, dead letter queue, autonomous halt, pause flag
- **Detection signals:**
  - Files/dirs: `global_pause`, `dead_letter`, `policy/queue`, `level_09/examples`
  - Context/evidence cues: pause state, dead-lettered work, queue claim
  - Code/log shapes: `global_pause`, `dead_lettered_work`, `paused`, `dead_letter_added`, `queue_lease`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L9-continuous-adversarial-eval-corpus

- **Functional signature:** autonomous startup requires fresh adversarial corpus and red-team findings promote coverage - produces eval/freshness records - prevents stale safety gates.
- **Alternative names:** adversarial corpus, red-team corpus, continuous safety evals, autonomy eval gate, corpus freshness gate
- **Detection signals:**
  - Files/dirs: `adversarial_corpus`, `red_team`, `level_09/examples`, `policy`
  - Context/evidence cues: adversarial eval corpus, red-team findings, eval results
  - Code/log shapes: `corpus_freshness`, `required_threat_classes`, `startup_gate`, `red_team_finding`, `coverage_missing`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L10-evidence-backed-improvement-proposal

- **Functional signature:** operational signals become signed PR-shaped proposals with evidence, tests, review, and risk - produces proposal lifecycle records - prevents side-channel self-modification.
- **Alternative names:** improvement proposal, governed proposal, PR-shaped change, evidence-backed change, proposal pipeline
- **Detection signals:**
  - Files/dirs: `proposals`, `level_10/inputs`, `improvement-proposal`, `change_control`
  - Context/evidence cues: improvement proposals, proposal reviews, proposal waivers
  - Code/log shapes: `source_run_ids`, `regression_tests`, `proposal_signature`, `reviewer_signoff`, `payload_digest`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ

### L10-adversarial-release-gate

- **Functional signature:** candidate release checks per-threat-class adversarial regression against signed baselines - produces release and waiver records - prevents aggregate score masking.
- **Alternative names:** release gate, adversarial gate, eval gate, safety regression gate, governed rollout
- **Detection signals:**
  - Files/dirs: `release_gate`, `adversarial_evals`, `candidate-release`, `level_10/examples`
  - Context/evidence cues: candidate releases, eval baselines, release decisions, parity tests
  - Code/log shapes: `per_class`, `baseline_signature`, `release_gate_inconsistent`, `waivable=false`, `promotion_blocked`
  - Conceptual equivalents: local structures that produce the same evidence, block the same failure mode, and enforce the same runtime boundary even when names, files, or framework primitives differ
