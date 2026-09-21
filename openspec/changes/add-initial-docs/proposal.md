# Proposal

## Why

The repository is a test harness for the OpenSpec + OpenCode multi-agent pipeline, but it has no documentation of its own: there is no `docs/` directory, so the purpose, prerequisites, layout, agent flow, and test contract are only discoverable by reading source files. New contributors and automated agents need a written baseline before the harness can be extended.

## What Changes

- Create the `docs/` directory with two Markdown files:
  - `docs/README.md` — documents the repository as a test harness: purpose, prerequisites (openspec CLI 1.13.1, bash/WSL, git), repository layout (`.opencode/` agents + commands + skills, `openspec/`, `scripts/test-md.sh`, `docs/`), how the multi-agent pipeline in `.opencode/commands/pipeline.md` works, and the test contract.
  - `docs/architecture.md` — documents the architecture: the planner→committer→coder→tester agent flow, the OpenSpec lifecycle (propose/apply/archive), Git worktree isolation on branch `feat/openspec-exec`, and the `scripts/test-md.sh` validation contract.
- No existing files are modified or removed; this is purely additive Markdown documentation.

## Capabilities

### New Capabilities
- `project-documentation`: The repository must ship authored Markdown documentation under `docs/` describing the test harness (purpose, prerequisites, layout, agent pipeline, test contract) and its architecture (agent flow, OpenSpec lifecycle, Git worktree isolation, validation contract).

### Modified Capabilities
<!-- None. This change introduces documentation only; no existing spec requirements change. -->

## Impact

- Target files created: `docs/README.md`, `docs/architecture.md`.
- No code, configuration, or scripts are changed.
- Validation: `./scripts/test-md.sh` (docs/ exists, all `docs/*.md` non-empty, each has an H1 `# ` header).
