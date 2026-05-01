# Contributing

This repo ships skills and reference canon for coding agents. Keep changes small, self-contained, and testable.

## Public Surface

- `skills/`: exactly five skill directories: `gaam`, `gaam-assess`, `gaam-design`, `gaam-implement`, `gaam-review`.
- `references/`: root GAAM canon.
- `skills/<focused-skill>/references/`: copies of root canon used by hosts that sandbox skill resources.
- Tool packaging: `.claude-plugin/`, `.codex/`, `.codex-plugin/`, `.cursor-plugin/`, `.opencode/`, `gemini-extension.json`, and `package.json`.
- `README.md`: human install and usage guide.
- `AGENTS.md`: operational rules for coding agents working in this repo.

## Validation

Run the static gate before every commit:

```bash
./tests/manifests.test.sh && ./tests/skills.test.sh && ./tests/refs.test.sh && ./tests/no-external-fetch.test.sh
```

Run smoke checks for local tool artifacts:

```bash
for f in tests/smoke/*.sh; do "$f"; done
```

Smoke scripts skip cleanly when a tool is not installed. Do not mask failures with `|| true`.

## Skill Rules

- Skill frontmatter has only `name` and `description`.
- Descriptions start with `Use when` and describe trigger conditions only.
- Skill bodies stay concise: gateway under 200 words; `gaam-assess` under 650 words; other siblings under 500 words.
- Skills do not chain to other plugins.
- `gaam-assess` and `gaam-review` must enforce recorded conceptual-equivalence search before marking any control or pattern missing.
- `gaam-assess` must load all four bundled references before classifying; reporting a canon file as "not loaded" is invalid.
- Every focused skill must treat GAAM level descriptions, requirements, control names, pattern IDs, and record/schema names as semantic anchors. User artifacts satisfy GAAM through equivalent capability, evidence, runtime boundary, and failure prevention, not literal names.

## Reference Rules

- Every reference file has `canon_version:` and `last_reviewed:` frontmatter.
- `references/gaam-levels.md` keeps exactly 10 GAAM level sections.
- `references/controls.md` keeps exactly 10 canonical control sections and the activation matrix.
- `references/patterns.md` keeps one section per GAAM level and one entry per source GAAM pattern ID.
- `references/synonyms.md` keeps entries for every control and pattern, with functional signature, alternative names, conceptual-equivalence guidance, semantic-anchor guidance, and detection signals.
- The focused skill reference copies must match root `references/*.md` exactly.

Changing reference meaning requires a version bump and fresh validation. Wording-only fixes may stay in the current canon version when they do not change behavior.

## Release

1. Make the change and update affected docs/manifests.
2. Run the static gate and smoke checks above.
3. If public behavior changes, run `./scripts/bump-version.sh <new-version>`.
4. Commit with `type(scope): summary`.
5. Tag with `git tag vX.Y.Z`.
6. Push commits and tags.
7. Create the GitHub release for the tag.

Do not add AI co-author or attribution lines to commits, file headers, docs, or release notes.
