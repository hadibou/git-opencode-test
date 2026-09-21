# Architecture of the OpenSpec + OpenCode Test Harness

## Agent Flow

The harness coordinates four agents, each defined under `.opencode/agents/` and orchestrated by `.opencode/commands/pipeline.md`. The flow is planner → committer → coder → tester, with the committer returning at the end to merge:

- **planner** — the architect. It takes the user request, runs `/openspec-propose`, and reviews the generated `openspec/changes/<change>/` proposal, specs, design, and tasks until they are complete and coherent.
- **committer** — the Git lifecycle manager. It commits planning artifacts, creates the isolated Git worktree for development and testing, and performs the merge from a validated worktree back into the main branch.
- **coder** — the developer. Inside the worktree it runs `/openspec-apply-change`, implements the tasks in `openspec/changes/<change>/tasks.md`, writes any supplementary code or tests, and confirms each task is marked complete.
- **tester** — the quality gatekeeper. It runs the project's test suite, analyzes the output, and either returns a detailed error report to the coder on failure or approves the changes for merging.

The loop is: planning produces artifacts, the committer isolates the workspace, the coder implements, and the tester validates. A tester failure routes back to the coder; a tester pass routes back to the committer for merge.

## OpenSpec Lifecycle

Every unit of work moves through three OpenSpec phases, each backed by a command and an Agent Skill in `.opencode/skills/`:

- **propose** — `/openspec-propose` creates a change under `openspec/changes/<change>/` with a proposal, capability spec deltas, a design, and a task list. The planner owns this phase.
- **apply** — `/openspec-apply-change` works through the change's `tasks.md`, updating the implementation and marking each task complete. The coder owns this phase, with the tester verifying the result.
- **archive** — `/openspec-archive-change` finalizes a completed change and moves it into `openspec/changes/archive/`, keeping the active change list clean.

The lifecycle is driven from the repository's `openspec/` root, and completion of the `apply` phase is gated by the harness's validation contract rather than by the agent's own judgement.

## Git Worktree Isolation

Implementation runs on an isolated branch, `feat/openspec-exec`, inside a sibling Git worktree (for example `../worktree-exec`). The committer creates it with a command of the form:

```
git worktree add -b feat/openspec-exec ../worktree-exec master
```

Isolation keeps the main working tree clean while the coder and tester operate: changes are committed on `feat/openspec-exec`, verified in the worktree, and only then merged back into the main branch and removed with `git worktree remove`. Because each worktree is a full checkout, an agent can run commands and tests without disturbing the primary repository or other work in progress.

## Validation Contract

Progress is gated by `scripts/test-md.sh`, which encodes the repository's definition of done for documentation. Run from the repository root, it enforces three rules:

1. `docs/` exists.
2. Every `docs/*.md` file is non-empty.
3. Every `docs/*.md` file contains a top-level H1 header beginning with `# `.

The script exits `0` and prints `=== All Markdown Tests Passed Successfully ===` only when all rules hold; otherwise it prints the offending file and exits non-zero. Neither the coder nor the tester may treat the work as complete while this contract fails.

## See Also

- [README.md](README.md) — orientation: purpose, prerequisites, repository layout, and a summary of the pipeline and test contract.
