---
canon_version: 1.0.0
last_reviewed: 2026-04-29
---

# Pattern Families per AMM Level

One section per AMM level L1–L10. Levels with no v0 pattern family carry an explicit `no v0 pattern family — <reason>` line. Required-family levels (L3–L10) carry **Functional signature:** + **Controls activated:** + **Test asserts:** verbatim. Pattern families are captured by *functional signature* (capability + evidence + failure-prevented), not by per-pattern verbatim entries.

## L1 — Unstructured AI use

no v0 pattern family — baseline; no patterns to standardize, only failure cases.

## L2 — Process definition

no v0 pattern family — process is documented in human SOPs, not in code.

## L3 — Retrieval & citations

- **Functional signature:** RAG retrieval with cited spans — produces (span_id, source_uri, citation_offset) per response — prevents fabricated facts from grounded queries
- **Controls activated:** Data Governance, Protocol Conformance
- **Test asserts:** every model response that cites a corpus must include at least one (span_id, source_uri, offset) triple verifiable against the corpus index.

## L4 — Draft-and-review

- **Functional signature:** model produces drafts that traverse a review state machine (draft → reviewed → published) — produces a review record per draft (reviewer_id, decision, timestamp, diff) — prevents unreviewed agent output from reaching customers
- **Controls activated:** Adversarial Awareness, Compliance Evidence Pack, Data Governance, Protocol Conformance
- **Test asserts:** every published artifact has a non-empty review record whose reviewer_id is a human principal.

## L5 — Read-only tools

- **Functional signature:** scoped read-only tool registry with audit-on-call and boundary redaction — produces an audit row per call (tool_call_id, actor, args_hash, result_hash, ts) — prevents unbounded tool surface and silent data egress
- **Controls activated:** Adversarial Awareness, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, OpenTelemetry Mapping
- **Test asserts:** every tool call produces an audit row whose schema validates and whose actor matches the calling principal.

## L6 — Approved writes

- **Functional signature:** two-step write with human approval, idempotency keys, and rollback metadata — produces a write record (request_id, approver_id, idempotency_key, rollback_token) — prevents irreversible mutations without human sign-off
- **Controls activated:** Adversarial Awareness, Agent Control Tower, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, Incident Response, OpenTelemetry Mapping, Value and Cost Management
- **Test asserts:** every write request has a corresponding approval record AND a rollback_token that resolves to a working rollback procedure.

## L7 — Signed goals + runtime predicates

- **Functional signature:** goals signed at submission and validated by runtime predicates between steps — produces (goal_signature, predicate_eval_records) per run — prevents goal drift and untyped stops
- **Controls activated:** Adversarial Awareness, Agent Control Tower, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, Incident Response, OpenTelemetry Mapping, Value and Cost Management
- **Test asserts:** every step transition has a predicate evaluation record; goal signature verifies on every step.

## L8 — Multi-agent routing

- **Functional signature:** deterministic routing between signed agent cards with typed handoff contracts — produces handoff records (from_agent, to_agent, contract_id, payload_hash) — prevents fanout to unknown agents and untyped boundary leaks
- **Controls activated:** Adversarial Awareness, Agent Control Tower, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, Incident Response, OpenTelemetry Mapping, Value and Cost Management
- **Test asserts:** every handoff is between two signed agent cards and validates against the named contract schema.

## L9 — Policy-gated autonomy

- **Functional signature:** eligibility gate + SLO budget + runtime revocation per autonomous run — produces (eligibility_decision, slo_burn, revocation_events) — prevents runaway autonomy outside policy
- **Controls activated:** Adversarial Awareness, Agent Control Tower, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, Incident Response, OpenTelemetry Mapping, Value and Cost Management
- **Test asserts:** every autonomous run starts with an eligibility decision, tracks SLO burn, and stops on revocation.

## L10 — Governed improvement

- **Functional signature:** signed proposals on candidate model/policy/prompt updates with reviewer signoff and adversarial release gate — produces (proposal_signature, reviewer_signoff, adversarial_eval_results) — prevents silent improvements that quietly weaken the system
- **Controls activated:** Adversarial Awareness, Agent Control Tower, Compliance Evidence Pack, Credential and Delegated Access, Data Governance, Protocol Conformance, Incident Response, OpenTelemetry Mapping, Value and Cost Management
- **Test asserts:** no candidate change is promoted without all three: reviewer signoff, passing adversarial eval, and a verifiable proposal signature.
