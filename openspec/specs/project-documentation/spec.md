# project-documentation Specification

## Purpose

Provides authored Markdown documentation for this repository so contributors and automated agents can understand the test harness, its multi-agent pipeline, and its validation contract without reading every source file.

## Requirements

### Requirement: Documentation directory and required files
The repository SHALL contain a `docs/` directory holding the project's documentation, including `docs/README.md` and `docs/architecture.md`. The documentation SHALL be composed of Markdown (`.md`) files only.

#### Scenario: Documentation files exist
- **WHEN** the documentation change is complete
- **THEN** `docs/README.md` and `docs/architecture.md` both exist under the repository root

#### Scenario: Only Markdown files are produced
- **WHEN** the `docs/` directory is listed
- **THEN** every documented artifact is a Markdown file with a `.md` extension

### Requirement: README documents the test harness
`docs/README.md` SHALL document the repository as a test harness. It MUST state the purpose of the harness, list the prerequisites (openspec CLI 1.13.1, bash/WSL, and git), describe the repository layout (`.opencode/` agents + commands + skills, `openspec/`, `scripts/test-md.sh`, and `docs/`), explain how the multi-agent pipeline in `.opencode/commands/pipeline.md` works, and describe the test contract.

#### Scenario: Prerequisites are documented
- **WHEN** a reader opens `docs/README.md`
- **THEN** it lists openspec CLI 1.13.1, bash/WSL, and git as prerequisites

#### Scenario: Repository layout is documented
- **WHEN** a reader opens `docs/README.md`
- **THEN** it describes `.opencode/` (agents, commands, skills), `openspec/`, `scripts/test-md.sh`, and `docs/`

#### Scenario: Pipeline and test contract are documented
- **WHEN** a reader opens `docs/README.md`
- **THEN** it explains how `.opencode/commands/pipeline.md` coordinates the agents and states the repository's test contract

### Requirement: Architecture document describes the system design
`docs/architecture.md` SHALL document the architecture of the harness. It MUST describe the planner→committer→coder→tester agent flow, the OpenSpec lifecycle (propose/apply/archive), Git worktree isolation using branch `feat/openspec-exec`, and the `scripts/test-md.sh` validation contract.

#### Scenario: Agent flow is documented
- **WHEN** a reader opens `docs/architecture.md`
- **THEN** it describes the planner→committer→coder→tester agent flow

#### Scenario: OpenSpec lifecycle is documented
- **WHEN** a reader opens `docs/architecture.md`
- **THEN** it describes the propose, apply, and archive phases of the OpenSpec lifecycle

#### Scenario: Worktree isolation is documented
- **WHEN** a reader opens `docs/architecture.md`
- **THEN** it describes Git worktree isolation on the `feat/openspec-exec` branch

#### Scenario: Validation contract is documented
- **WHEN** a reader opens `docs/architecture.md`
- **THEN** it describes the `scripts/test-md.sh` checks: `docs/` exists, every `docs/*.md` file is non-empty, and each file has an H1 `# ` header

### Requirement: Markdown header hierarchy and cross-references
Every `docs/*.md` file SHALL begin with a single top-level H1 header (`# `) and SHALL use H2 (`## `) headers to structure its sections, preserving a clear and consistent hierarchy. Where one document refers to another, it SHALL use a relative Markdown link to that file under `docs/`.

#### Scenario: Top-level header present
- **WHEN** any file under `docs/` is inspected
- **THEN** it contains an H1 header beginning with `# `

#### Scenario: Sections use H2 headers
- **WHEN** a documentation file is inspected
- **THEN** its sections are introduced by H2 headers rather than skipping to deeper levels

#### Scenario: Cross-references resolve
- **WHEN** one documentation file links to another document
- **THEN** the link is a relative path to an existing `.md` file under `docs/`

### Requirement: Documentation passes the Markdown test contract
The documentation SHALL satisfy `scripts/test-md.sh`. The script MUST be run as the final validation step for this change, and the change MUST NOT be considered complete unless it exits successfully.

#### Scenario: Validation succeeds
- **WHEN** `./scripts/test-md.sh` is executed from the repository root
- **THEN** it exits with status 0 and reports that all Markdown tests passed

#### Scenario: Missing H1 fails validation
- **WHEN** any `docs/*.md` file lacks an H1 `# ` header
- **THEN** `./scripts/test-md.sh` fails and reports the offending file
