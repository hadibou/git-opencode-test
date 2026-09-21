---
---
description: Executes the complete OpenSpec lifecycle using native OpenSpec commands across isolated Git Worktrees.
---

# Execution Workflow

1. **Planning & Spec Generation:**
   
   - Pass the user request to `@planner` to trigger `/openspec-propose`.
   - Once spec files are drafted, invoke `@committer` to commit them:
     `git add openspec/ && git commit -m "docs(openspec): generate spec artifacts"`

2. **Workspace Isolation (Git Worktree):**
   
   - Invoke `@committer` to spin up a clean worktree:
     `git worktree add -b feat/openspec-exec ../worktree-exec master`

3. **Execution & Verification (inside Worktree):**
   
   - In `../worktree-exec`, invoke `@coder` to run `/openspec-apply-change` against the active tasks.
   - Invoke `@tester` to run project tests and validate stability.
   - If `@tester` fails, pass the error log back to `@coder` to fix before proceeding.

4. **Finalization & Merge:**
   
   - Once `@tester` passes, invoke `@committer` to:
     1. Commit implementation changes in the worktree:
        `git commit -am "feat: apply openspec changes"`
     2. Return to the main repository root (the worktree is a sibling directory).
     3. Merge the worktree branch (`git merge feat/openspec-exec`).
     4. Remove the worktree (`git worktree remove ../worktree-exec` and `git branch -d feat/openspec-exec`).

---