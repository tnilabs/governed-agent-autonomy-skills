---
canon_version: 1.0.0
last_reviewed: 2026-04-29
---

# Rosetta — Naming-Agnostic Recognition

This file is what assess and review skills consult before claiming a control or pattern is "missing." Every entry has:
- **Functional signature** — capability + evidence-it-produces + failure-it-prevents.
- **Alternative names** — common synonyms / project-internal names for the same capability (≥3).
- **Detection signals** — concrete things to grep / look up in a real codebase to surface the capability under any name (≥3 categories).

Controls and patterns are functional categories, not names. A user system has the capability if the evidence the capability produces is there — under any name.

## Controls

### Adversarial Awareness

- **Functional signature:** input-side filtering + jailbreak / prompt-injection detection + provenance checks + replay buffer of incidents — produces classifier scores, refusal records, replay artifacts — prevents silent compromise via crafted input or substrate.
- **Alternative names:** prompt guard, jailbreak detector, input filter, guardrails, security middleware, prompt firewall
- **Detection signals:**
  - Files/dirs: `security/`, `guards/`, `prompt_guard.py`, `injection/`, `jailbreak/`, `safety/`
  - Deps: `nemo-guardrails`, `presidio`, `guardrails-ai`, `pii-detector`, `llm-guard`
  - Code shapes: `@requires_safety`, middleware wrapping every model call, classifier-then-allow patterns
  - Log/dashboard keywords: `prompt_blocked`, `injection_detected`, `jailbreak_score`, `guard_refused`

### Agent Control Tower

- **Functional signature:** registry of every agent with owner / lifecycle / health + operator surface for pause / revoke / rollback — produces agent inventory, action logs, health metrics — prevents shadow agents and missing kill switches.
- **Alternative names:** ops dashboard, agent registry, control plane, operations console, admin panel, agent ops
- **Detection signals:**
  - Files/dirs: `ops/`, `console/`, `admin/`, `agent_registry/`, `control_plane/`
  - Deps: `prometheus-client`, `grafana-provisioning`, internal `agent-ops` packages
  - Code shapes: a service that owns `/agents` CRUD endpoints, kill-switch decorators, lifecycle-state enums
  - Log/dashboard keywords: `agent_registered`, `agent_paused`, `agent_health`, `Agent Inventory`

### Compliance Evidence Pack

- **Functional signature:** export of run / approval / eval / limitation / rollback records as a signed bundle — produces evidence_id, attestation, signature — prevents audit findings the team cannot answer.
- **Alternative names:** audit dump, compliance report, soc2 export, evidence bundle, attestation pack, audit trail export
- **Detection signals:**
  - Files/dirs: `compliance/`, `audit_export/`, `evidence/`, `attestations/`
  - Deps: `pyaudit`, `opa-bundle`, `cyclonedx`, internal `evidence-pack` packages
  - Code shapes: schema fields `evidence_id`, `attestation_signature`, `bundle_version`; nightly export jobs
  - Log/dashboard keywords: `evidence_exported`, `Compliance Status`, `attestation_signed`

### Credential and Delegated Access

- **Functional signature:** scoped, time-bound credentials with delegation chains and revocation — produces actor / principal records, lease metadata, revocation events — prevents standing credentials and wrong-principal action.
- **Alternative names:** rbac, scoped tokens, delegated auth, principal of action, on-behalf-of, identity broker
- **Detection signals:**
  - Files/dirs: `auth/`, `rbac/`, `iam/`, `delegation/`, `principals/`
  - Deps: `casbin`, `oso`, `cedar-py`, `oauthlib`, internal `identity-broker` packages
  - Code shapes: `@requires_role`, `actor: Principal`, lease objects with `expires_at`, on-behalf-of headers
  - Log/dashboard keywords: `credential_issued`, `lease_expired`, `revoked`, `actor=`, `principal=`

### Data Governance

- **Functional signature:** classification + redaction + retention + residency for every data path — produces classification labels, redaction records, retention metadata — prevents sensitive data leaving the boundary.
- **Alternative names:** dlp, pii redaction, data classification, retention policy, data residency, privacy guard
- **Detection signals:**
  - Files/dirs: `governance/`, `redaction/`, `dlp/`, `privacy/`, `pii/`, `data_policy/`
  - Deps: `presidio-analyzer`, `presidio-anonymizer`, `microsoft-presidio`, `scrubadub`
  - Code shapes: classification enums, redaction decorators, residency tags on storage clients
  - Log/dashboard keywords: `pii_redacted`, `classification=PUBLIC`, `retention_window`, `residency=eu`

### Protocol Conformance

- **Functional signature:** schema-versioned interfaces + adapter conformance tests + rejection of non-conforming traffic — produces schema versions, conformance results, rejection records — prevents silent contract drift.
- **Alternative names:** schema registry, contract testing, openapi conformance, mcp validator, a2a checker, interface versioning
- **Detection signals:**
  - Files/dirs: `schemas/`, `contracts/`, `openapi/`, `mcp/`, `a2a/`, `protocols/`
  - Deps: `pydantic`, `jsonschema`, `openapi-spec-validator`, `pact-python`, `mcp-server`
  - Code shapes: versioned schema imports, contract diff jobs, `validate_request_against_schema()` calls
  - Log/dashboard keywords: `schema_version`, `contract_violation`, `validation_failed`, `mcp_tool_registered`

### Incident Response

- **Functional signature:** detection + pause + containment + replay + postmortem workflow — produces detection signals, containment records, replay artifacts, postmortems — prevents repeat incidents.
- **Alternative names:** runbook, on-call rotation, incident management, kill switch, incident commander, postmortem template
- **Detection signals:**
  - Files/dirs: `runbooks/`, `incidents/`, `postmortems/`, `oncall/`, `ir/`
  - Deps: `pagerduty`, `opsgenie`, `incidentio`, internal incident-tooling
  - Code shapes: kill-switch flags, replay harnesses, named on-call routes, severity enums
  - Log/dashboard keywords: `incident_opened`, `paused_by_oncall`, `replay_started`, `postmortem_due`

### OpenTelemetry Mapping

- **Functional signature:** portable OTel spans / metrics / logs covering every step / tool / model call — produces span_id, agent.tool_call_id, correlation_id — prevents black-box agents.
- **Alternative names:** tracing, OTel spans, Datadog traces, distributed tracing, telemetry pipeline, observability layer
- **Detection signals:**
  - Files/dirs: `otel/`, `tracing/`, `telemetry/`, `observability/`
  - Deps: `opentelemetry-api`, `opentelemetry-sdk`, `opentelemetry-instrumentation-*`, `ddtrace`, `sentry-sdk`
  - Code shapes: `traceparent` headers propagated, span attrs `agent.tool_call_id` / `agent.run_id`, instrumentation initializers
  - Log/dashboard keywords: `span_started`, `trace_id`, `correlation_id`, `agent.tool_call_id`

### Value and Cost Management

- **Functional signature:** cost / latency / outcome tracking against business value with budget enforcement — produces cost records, latency distributions, outcome metrics, budget burn — prevents runaway spend and unmeasured outcomes.
- **Alternative names:** finops, budget tracking, unit economics, cost dashboard, value metrics, spend cap
- **Detection signals:**
  - Files/dirs: `cost/`, `billing/`, `finops/`, `budgets/`, `quotas/`
  - Deps: `aws-cost-explorer`, `gcp-billing`, internal `cost-attribution` packages
  - Code shapes: per-call cost accumulators, budget guards before model calls, KPI emit hooks
  - Log/dashboard keywords: `cost_usd`, `budget_burn`, `quota_exhausted`, `Spend vs Value`

## Patterns

### L3 — Retrieval & citations

- **Functional signature:** RAG retrieval with cited spans — produces (span_id, source_uri, citation_offset) per response — prevents fabricated facts from grounded queries.
- **Alternative names:** RAG, retrieval-augmented generation, grounded answering, source-cited responses, citation engine
- **Detection signals:**
  - Files/dirs: `rag/`, `retrieval/`, `embeddings/`, `corpus/`, `knowledge/`, `citations/`
  - Deps: `chromadb`, `weaviate`, `qdrant`, `faiss-cpu`, `llama-index`, `langchain-retrievers`
  - Code shapes: vector index init, `retrieve_then_generate()` flows, citation/span dataclasses
  - Log/dashboard keywords: `retrieval_recall`, `span_id`, `source_uri`, `citation_offset`

### L4 — Draft-and-review

- **Functional signature:** model produces drafts that traverse a review state machine (draft → reviewed → published) — produces a review record per draft — prevents unreviewed agent output from reaching customers.
- **Alternative names:** human-in-the-loop, review queue, approval workflow, draft mode, supervised generation
- **Detection signals:**
  - Files/dirs: `review/`, `drafts/`, `approvals/`, `queue/`, `hitl/`
  - Deps: `temporal`, `prefect`, `airflow`, internal review-queue packages
  - Code shapes: `ReviewState` enums, `reviewer_id` schema fields, `publish_if_reviewed()` gates
  - Log/dashboard keywords: `draft_created`, `review_decision`, `published_by`, `Review Queue`

### L5 — Read-only tools

- **Functional signature:** scoped read-only tool registry with audit-on-call and boundary redaction — produces an audit row per call (tool_call_id, actor, args_hash, result_hash, ts) — prevents unbounded tool surface and silent data egress.
- **Alternative names:** tool registry, MCP server, function calling allowlist, scoped tools, read-only tools, audited tools
- **Detection signals:**
  - Files/dirs: `tools/`, `tool_registry/`, `mcp/`, `function_calls/`
  - Deps: `mcp-server`, `openai-tools`, `langchain-tools`, framework-native tool decorators
  - Code shapes: `@tool` / `@readonly` decorators, audit-row structs, redaction middleware on tool results
  - Log/dashboard keywords: `tool_call_started`, `tool_call_completed`, `args_hash`, `Tool Audit`

### L6 — Approved writes

- **Functional signature:** two-step write with human approval, idempotency keys, and rollback metadata — produces a write record (request_id, approver_id, idempotency_key, rollback_token) — prevents irreversible mutations without human sign-off.
- **Alternative names:** approval workflow, change request, two-phase write, approved mutations, write gate, sandboxed writes
- **Detection signals:**
  - Files/dirs: `writes/`, `approvals/`, `change_requests/`, `mutations/`, `rollback/`
  - Deps: `temporal`, `step-functions`, internal approval-workflow packages
  - Code shapes: `propose_write()` then `execute_if_approved()`, idempotency-key middleware, rollback registries
  - Log/dashboard keywords: `write_proposed`, `approval_recorded`, `rollback_token`, `idempotency_key`

### L7 — Signed goals + runtime predicates

- **Functional signature:** goals signed at submission and validated by runtime predicates between steps — produces (goal_signature, predicate_eval_records) per run — prevents goal drift and untyped stops.
- **Alternative names:** signed goals, runtime invariants, predicate evaluation, typed stops, memory validation
- **Detection signals:**
  - Files/dirs: `goals/`, `predicates/`, `invariants/`, `signed_goals/`
  - Deps: `pynacl`, `cryptography`, internal goal-signing packages
  - Code shapes: `Goal` dataclass with `signature` field, `eval_predicate_between_steps()`, typed `StopReason` enums
  - Log/dashboard keywords: `goal_signature_verified`, `predicate_failed`, `typed_stop`, `memory_invalid`

### L8 — Multi-agent routing

- **Functional signature:** deterministic routing between signed agent cards with typed handoff contracts — produces handoff records (from_agent, to_agent, contract_id, payload_hash) — prevents fanout to unknown agents and untyped boundary leaks.
- **Alternative names:** agent cards, agent2agent (A2A), agent routing, handoff contracts, signed agents, typed routing
- **Detection signals:**
  - Files/dirs: `agents/`, `routing/`, `handoffs/`, `agent_cards/`, `a2a/`
  - Deps: A2A protocol libraries, `langgraph` multi-agent, framework-native router packages
  - Code shapes: `AgentCard` schemas with signatures, deterministic routing tables, payload hashing on handoff
  - Log/dashboard keywords: `handoff_started`, `agent_card_verified`, `routing_decision`, `payload_hash`

### L9 — Policy-gated autonomy

- **Functional signature:** eligibility gate + SLO budget + runtime revocation per autonomous run — produces (eligibility_decision, slo_burn, revocation_events) — prevents runaway autonomy outside policy.
- **Alternative names:** policy gate, eligibility check, SLO guard, runtime revocation, dead-letter queue, autonomy budget
- **Detection signals:**
  - Files/dirs: `policy/`, `slo/`, `eligibility/`, `revocation/`, `dead_letter/`
  - Deps: `opa-py`, `cedar-policy`, `casbin`, internal SLO-tracker packages
  - Code shapes: `evaluate_eligibility()` before run, SLO-burn accumulators, revocation-watchers, DLQ persisters
  - Log/dashboard keywords: `eligibility_denied`, `slo_burn_pct`, `run_revoked`, `dead_letter_added`

### L10 — Governed improvement

- **Functional signature:** signed proposals on candidate model/policy/prompt updates with reviewer signoff and adversarial release gate — produces (proposal_signature, reviewer_signoff, adversarial_eval_results) — prevents silent improvements that quietly weaken the system.
- **Alternative names:** model promotion, change control, signed proposals, release gate, adversarial eval gate, governed rollout
- **Detection signals:**
  - Files/dirs: `proposals/`, `release_gates/`, `adversarial_evals/`, `change_control/`, `model_promotion/`
  - Deps: `cosign`, `sigstore-python`, `opa-policy`, internal release-gate packages
  - Code shapes: `Proposal` dataclass with signature, multi-party signoff records, adversarial replay harness wired to the gate
  - Log/dashboard keywords: `proposal_signed`, `reviewer_signoff`, `adversarial_eval_passed`, `promotion_blocked`
