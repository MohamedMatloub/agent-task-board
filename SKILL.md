---
name: agent-task-board
description: Local Markdown project board for agent task planning, handoffs, status tracking, and low-token workflow.
---

# Agent Task Board

Use this skill for local Markdown task boards, project planning, task lifecycle updates, handoffs, and "what next?" requests.

## Principles

- Local-first: all state lives in `board/`.
- Token-light: read only what is needed.
- Append-only progress: never erase user or agent notes.
- Structured metadata beats prose.
- No GitHub Projects, database, or external service.

## Setup

When `board/status.md` is missing, create the board from this layout and the templates. Prefer the initializer; it creates missing files only.

```bash
bash /path/to/agent-task-board/scripts/init_board.sh
```

On first setup, ask once whether to enable git branch tracking. If yes, set `GitBranchTracking: enabled` in `board/status.md`. If no or no answer, keep `disabled`.

## Generated Layout

```text
board/
  README.md
  status.md
  features/
    <feature>/
      FEATURE.md
      <epic>/
        EPIC.md
        TASK-000.md
  done/
  changelog.md
  decisions.md
```

## Read Order

1. Read `board/status.md`.
2. Read only task paths named there or relevant to the request.
3. Read parent `EPIC.md` or `FEATURE.md` only if scope is unclear.
4. Ignore `board/done/` unless history is requested.

## Task Metadata

Use these fields near the top of every task:

```text
ID: TASK-000
Status: Todo
Priority: P2
DependsOn: none
Owner: unassigned
Branch: none
```

Valid statuses: `Todo`, `InProgress`, `Blocked`, `Review`, `Done`.

Priorities: `P0` urgent, `P1` high, `P2` normal, `P3` low.

## Workflow

1. Pick the highest-priority unblocked `Todo` task.
2. Set `Status: InProgress`, set `Owner`, and append one progress line.
3. Keep changes scoped to the task.
4. If blocked, set `Status: Blocked`, keep it in place, and list it in `board/status.md`.
5. When ready, set `Status: Review` and record verification.
6. After acceptance, set `Status: Done`.
7. Move a whole feature folder to `board/done/` only when all of its epics/tasks are done.

## Update Rules

- Never overwrite user content blindly.
- Append progress as one-line dated entries.
- Keep `board/status.md` current and concise.
- Record decisions in `board/decisions.md`.
- Record user-visible changes in `board/changelog.md`.
- Add handoff notes when another agent may continue.

## Git

- Default: `GitBranchTracking: disabled`.
- Create or switch branches only when tracking is enabled or the user explicitly asks.
- Use `BranchPattern` from `board/status.md`.
- Use `BaseBranch: current` to branch from the current branch.
- If `BaseBranch` names a branch, switch only with a clean worktree or user approval.
- Record active task branches in `Branch:`.
- Never stage, commit, or push unless the user explicitly asks.

## Validation

Run the validator when useful:

```bash
bash /path/to/agent-task-board/scripts/validate_board.sh
```

Fix duplicate IDs, missing required fields, filename/ID mismatches, missing dependencies, invalid statuses, and malformed metadata before marking work done.
