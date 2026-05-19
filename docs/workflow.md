# Workflow Reference

This file expands the concise rules in `SKILL.md`.

## Lifecycle

Use one of these exact task statuses:

- `Todo`
- `InProgress`
- `Blocked`
- `Review`
- `Done`

## Loading Strategy

1. Read `board/status.md`.
2. Read only nested task files required by the request.
3. Read parent `EPIC.md` or `FEATURE.md` when scope is unclear.
4. Skip `board/done/` unless historical context is needed.

## Paths

Use this layout:

```text
board/README.md
board/status.md
board/features/<feature>/FEATURE.md
board/features/<feature>/<epic>/EPIC.md
board/features/<feature>/<epic>/TASK-000.md
board/done/
```

When all nested work is complete, move the whole feature folder to `board/done/`.

## Handoffs

Add a short handoff note when stopping before completion:

```text
- YYYY-MM-DD: Handoff: current state, next step, blocker if any.
```

## Git Branch Tracking

On first setup, ask whether to enable git branch tracking. Default to:

```text
GitBranchTracking: disabled
BranchPattern: task/TASK-000-short-slug
BaseBranch: current
```

When enabled, agents may create or switch task branches and should record them in `Branch:`. `BaseBranch: current` means create task branches from the current branch. If `BaseBranch` names a branch, switch only with a clean worktree or user approval. Staging, committing, and pushing still require an explicit user request.
