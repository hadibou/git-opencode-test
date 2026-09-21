# Design

## Context

See `proposal.md` — Why. The repository currently has no `docs/` directory; the harness is understood only by reading `.opencode/`, `openspec/`, and `scripts/test-md.sh`. The change is documentation-only and is constrained by `openspec/config.yaml`: content is Markdown in `docs/`, headers must form a clear H1/H2 hierarchy, and `scripts/test-md.sh` must pass. The script enforces that `docs/` exists, that every `docs/*.md` file is non-empty, and that each file contains an H1 (`# `) header.

## Goals / Non-Goals

**Goals:**
- Produce two durable Markdown documents (`docs/README.md`, `docs/architecture.md`) whose content matches the behavior contract in `specs/project-documentation/spec.md`.
- Keep the two documents non-overlapping in purpose: README is orientation and setup; architecture is system design and lifecycle.
- Ensure both files satisfy `scripts/test-md.sh` on the first validation run.

**Non-Goals:**
- No changes to scripts, agents, commands, skills, or OpenSpec configuration.
- No new tooling, generation pipeline, or static-site setup.
- No documentation of the user's application code (there is none); only the harness itself.

## Decisions

- **Two documents, split by reader intent.** `docs/README.md` answers "what is this and how do I run it"; `docs/architecture.md` answers "how does it work". Alternatives considered: a single `docs/README.md` (rejected — mixes onboarding with design detail), or a `docs/` tree with many small files (rejected — over-engineered for a test harness and increases the chance of failing the non-empty/H1 checks).
- **Content is authored directly as Markdown, not generated.** There is no generator in the repo; adding one would violate the non-goals and the config's "Markdown only" constraint. Alternative considered: a templating step (rejected — out of scope).
- **H1 once per file, H2 for sections.** Matches the spec's header-hierarchy requirement and the `^# ` check in `scripts/test-md.sh`. Deeper levels are avoided except where a list suffices, keeping the hierarchy shallow and predictable.
- **Cross-references by relative link.** `docs/README.md` links to `docs/architecture.md` (and back), using relative paths that resolve within `docs/`. Alternative considered: absolute paths (rejected — brittle across worktrees and clones).
- **Prerequisite versions stated exactly.** The README records openspec CLI `1.13.1` (the version reported by `openspec --version` in this environment), bash/WSL, and git, so the harness is reproducible.

## Risks / Trade-offs

- [Content can drift from the pipeline it describes] → Keep descriptions aligned to the actual files (`.opencode/commands/pipeline.md`, `.opencode/agents/*.md`) and re-run `./scripts/test-md.sh` before marking completion.
- [A file could be created empty or without an H1] → Author the H1 as the first line of each file and treat `./scripts/test-md.sh` as the mandatory final validation step.
- [Overlap between the two documents creates maintenance burden] → Enforce the README/architecture split described above; README summarizes the pipeline, architecture retains the detailed flow.

## Migration Plan

Additive only: create `docs/` with the two files. Rollback is deleting the `docs/` directory; no other files are touched. There is no deployment or data migration.

## Open Questions

None.
