# Tasks

## 1. Create docs/README.md

- [ ] 1.1 Create `docs/README.md` with an H1 title (`# `) and H2 sections describing the test harness purpose and its prerequisites (openspec CLI 1.13.1, bash/WSL, git); validate with `./scripts/test-md.sh`
- [ ] 1.2 Extend `docs/README.md` with an H2 repository-layout section covering `.opencode/` (agents, commands, skills), `openspec/`, `scripts/test-md.sh`, and `docs/`; validate with `./scripts/test-md.sh`
- [ ] 1.3 Extend `docs/README.md` with H2 sections explaining how the multi-agent pipeline in `.opencode/commands/pipeline.md` works and stating the test contract, including a relative link to `docs/architecture.md`; validate with `./scripts/test-md.sh`

## 2. Create docs/architecture.md

- [ ] 2.1 Create `docs/architecture.md` with an H1 title (`# `) and an H2 section describing the planner→committer→coder→tester agent flow; validate with `./scripts/test-md.sh`
- [ ] 2.2 Add an H2 section to `docs/architecture.md` describing the OpenSpec lifecycle (propose/apply/archive); validate with `./scripts/test-md.sh`
- [ ] 2.3 Add H2 sections to `docs/architecture.md` describing Git worktree isolation on branch `feat/openspec-exec` and the `scripts/test-md.sh` validation contract, including a relative link to `docs/README.md`; validate with `./scripts/test-md.sh`

## 3. Final validation

- [ ] 3.1 Run `./scripts/test-md.sh` from the repository root and confirm it exits 0, with `docs/README.md` and `docs/architecture.md` both non-empty and each containing an H1 `# ` header; this is the final validation step for the change
