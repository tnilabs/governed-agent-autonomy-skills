---
canon_version: 1.0.0
last_reviewed: 2026-04-29
---

# Agentic Maturity Model — Levels

Ten capability levels for production-grade AI agents. Each level adds one capability boundary; later levels carry forward all controls activated at earlier levels — controls accumulate. Level claims are made on evidence (artifacts, controls, tests, telemetry), not vibes.

## L1 — Unstructured AI use

**Intent.** Ad-hoc model use. Whoever needs help types into a chat, copies useful output back into their work. No documented workflow, no shared playbook, no audit, no defined success criteria.

**Exit criteria.**
- A *failure-case catalog* exists: real user-visible incidents from unstructured use, captured as test fixtures.
- A baseline measurement of cost-of-doing-nothing or cost-of-current-state is recorded.
- The team has a written intent statement of what they would manage if they moved past L1.

**Common confusion.** L1 is not "no AI use" — it is *unmanaged* use. If a team has documented when to use AI, what to share, and how to capture failures, they are already at L2.

## L2 — Process definition

**Intent.** The work is documented as a human workflow. Policies, templates, decision criteria, and validation steps are authored as documents. Humans execute the work; the AI may assist but does not own a step.

**Exit criteria.**
- A workflow document names every step, owner, and decision point.
- Policies (for sharing data, escalation, retention) are recorded and discoverable.
- Validation rules and templates are versioned alongside the workflow.
- The team has run the workflow end-to-end on at least one representative case.

**Common confusion.** L2 is not "we wrote a Notion page once." Policies and templates must be the actual artifacts in use, and the workflow must be the one humans run today.

## L3 — Knowledge grounding

**Intent.** Local retrieval grounds model responses in a bounded, curated knowledge surface. Citations are first-class — every claim a model emits points back to an indexed span. Retrieval quality is evaluated.

**Exit criteria.**
- A local RAG corpus is curated, indexed, and versioned.
- Every model response that cites the corpus carries `(span_id, source_uri, citation_offset)` tuples verifiable against the index.
- A retrieval-evaluation harness measures recall, precision, and citation accuracy on a held-out set.
- Out-of-scope queries return a *don't know* response, not a hallucination.

**Common confusion.** L3 is not "we use embeddings somewhere." If the model can answer without citing a span, or citations don't resolve to real corpus content, the system has not crossed L3.

## L4 — Human-guided assistance

**Intent.** The model produces drafts (replies, triage, notes, checklists) that traverse a review state machine before reaching customers or downstream systems. Humans own every output that ships.

**Exit criteria.**
- A review state machine is implemented: `draft → reviewed → published`. Every published artifact has a non-empty review record (`reviewer_id`, `decision`, `timestamp`, `diff`).
- Confidence and citations are surfaced to the reviewer alongside the draft.
- The reviewer is a human principal — not another model — and that is enforced in the record schema.
- A pre-merge guard prevents publishing artifacts with missing review records.

**Common confusion.** L4 is not "a human looks at it sometimes." If there is no record, no schema, and no enforcement, the system is at L3 with manual oversight, not L4.

## L5 — Read-only tools

**Intent.** The agent calls scoped read-only tools through a registered surface. Every call is audited. Sensitive data is redacted at the boundary before it reaches the model.

**Exit criteria.**
- A tool registry enumerates every callable read tool; the agent cannot call anything off-registry.
- Every tool call produces an audit row: `tool_call_id`, `actor`, `args_hash`, `result_hash`, `ts`. The schema validates.
- Boundary redaction is applied to tool results before the model sees them; redaction is configured per data classification.
- A negative test exists for an unregistered tool name (call must refuse).

**Common confusion.** L5 is not "the agent has tools." If a tool can mutate state, the system has crossed into L6 territory and is missing the L6 controls. If audit rows are inconsistent or redaction is opt-in, it isn't L5.

## L6 — Approved write actions

**Intent.** The agent can mutate state, but every write goes through human approval, carries an idempotency key, and records a rollback token. Nothing irreversible happens without sign-off.

**Exit criteria.**
- Two-step write: agent proposes a write; human approver records `request_id`, `approver_id`, `idempotency_key`, `rollback_token`. The write only executes after approval.
- Rollback is *tested*, not just declared — the rollback procedure has been exercised against the system the write touched.
- Idempotency keys prevent duplicate writes from a retry; this is verified by replay tests.
- An incident-response runbook exists and names who to page when an approved write goes wrong.

**Common confusion.** L6 is not "we have a confirm dialog." If approver identity is not recorded, or the rollback path doesn't actually roll back, the system is at L5 with optimistic writes, not L6.

## L7 — Goal-directed execution

**Intent.** The agent plans toward signed, persistent goals. Runtime predicates evaluate between every step to detect drift, untyped stops, or violations. Memory writes are validated against schema.

**Exit criteria.**
- Goals are signed at submission; the signature is verified before each step.
- Runtime predicates run between steps and produce predicate-evaluation records (passed, failed, reason).
- Memory writes are typed and validated; an invalid memory shape stops the run.
- Typed stop conditions cover normal completion, predicate failure, budget exhaustion, and operator revocation.

**Common confusion.** L7 is not "we use a planner library." Signatures, predicates, and memory validation are the boundary — not the choice of orchestration framework.

## L8 — Coordinated agents

**Intent.** Multiple agents collaborate via deterministic routing and signed agent cards. Handoffs are typed contracts, not free-form prose.

**Exit criteria.**
- Each participating agent has a signed agent card declaring its capabilities, contracts, and credentials.
- Routing is deterministic — a given input produces the same target agent every time, given the same routing rules.
- Each handoff records `from_agent`, `to_agent`, `contract_id`, `payload_hash`, and validates the payload against the named contract schema.
- Untyped handoffs are refused at the boundary.

**Common confusion.** L8 is not "we have multiple agents calling each other." Signed cards, deterministic routing, and typed contracts are the boundary — not the count of agents in the system.

## L9 — Policy-gated autonomy

**Intent.** The agent runs autonomously within explicit eligibility gates, SLO budgets, and runtime revocation. Out-of-policy work stops; revocation is honored within bounded latency.

**Exit criteria.**
- Every autonomous run starts with an eligibility decision (allowed / denied / partial) recorded with the reason.
- An SLO budget tracks burn (cost, latency, error rate) and pauses or denies further work when burned.
- Runtime revocation is honored: when an operator pulls authority, in-flight steps stop within a bounded window.
- A dead-letter queue captures denied or revoked work for human review.

**Common confusion.** L9 is not "we can pause it." If revocation latency is unbounded, or eligibility is implicit, the system is at L8 with operator overrides, not L9.

## L10 — Governed improvement

**Intent.** Changes to the agent's models, policies, or prompts are governed: signed proposals, multi-party reviewer signoff, adversarial release gates. Improvement does not silently weaken the system.

**Exit criteria.**
- Every candidate change carries a signed proposal (`proposal_signature`) bound to the diff.
- Reviewer signoff is multi-party; signatures are recorded and verifiable.
- An adversarial release gate runs before promotion and must pass — adversarial evals plus regression on prior failure cases.
- A rollback record names what to roll back to and how, in case the new artifact regresses post-promotion.

**Common confusion.** L10 is not "we run evals." If proposals are unsigned, reviewers are unrecorded, or adversarial gates are advisory, the system is at L9 with model rotation, not L10.
