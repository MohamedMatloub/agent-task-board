# Agent Task Board Skill

Agent Task Board is a lightweight Markdown workflow for AI agents and humans. It keeps project state in a local `board/` folder so work can be planned, claimed, handed off, reviewed, and completed without external trackers.

## Philosophy

- Local-first Markdown.
- Low token usage by default.
- Concise metadata over repeated prose.
- Append progress; preserve history.
- Lightweight shell tooling, no services.

## Install

```bash
npx skills add https://github.com/MohamedMatloub/agent-task-board --skill agent-task-board
```

## Repository Structure

```text
agent-task-board/
  SKILL.md
  README.md
  scripts/
    init_board.sh
    validate_board.sh
  templates/
    BOARD_README.md
    FEATURE.md
    EPIC.md
    TASK.md
    STATUS.md
  examples/
    board/
  docs/
```

## Generated Board

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

## Workflow

1. Read `board/status.md`.
2. Open only relevant nested task files.
3. Pick the highest-priority unblocked `Todo` task.
4. Move it through `Todo -> InProgress -> Blocked -> Review -> Done`.
5. Append short progress, verification, and handoff notes.
6. Keep `decisions.md` and `changelog.md` concise.
7. Move a feature folder to `board/done/` when all nested work is done.

## Optional Git Branch Tracking

On first setup, agents should ask whether to enable git branch tracking. The default is disabled.

```text
GitBranchTracking: disabled
BranchPattern: task/TASK-000-short-slug
BaseBranch: current
```

When enabled, agents may create or switch task branches and record them in `Branch:`. `BaseBranch: current` means create task branches from the current branch. If `BaseBranch` names a branch, agents should switch only with a clean worktree or user approval. Agents must not stage, commit, or push unless explicitly asked.

## Examples

Ask an agent:

```text
Set up an agent task board for this project.
```

```text
Create TASK-004 for adding import validation.
```

```text
Pick the next unblocked P1 task and start it.
```

## Token Optimization

Agents should read files hierarchically:

- Start with `board/status.md`.
- Read only referenced task paths.
- Read parent feature or epic files only when they clarify scope.
- Ignore `board/done/` unless history is required.
- Keep progress logs to one line per update.

## Validation

```bash
bash scripts/validate_board.sh
```

The validator checks:

- Task IDs are unique.
- Task filenames match task IDs.
- Required fields are present.
- Status is one of `Todo`, `InProgress`, `Blocked`, `Review`, `Done`.
- Priority is one of `P0`, `P1`, `P2`, `P3`.
- Dependencies use `none` or existing comma-separated task IDs.

## Best Practices

- Use IDs like `TASK-001`, `FEAT-001`, and `EPIC-001`.
- Use priorities `P0` through `P3`.
- Use `DependsOn: none` or comma-separated task IDs.
- Use task branches only when `GitBranchTracking: enabled` or explicitly requested.
- Never overwrite user notes; append updates.
- Keep templates structured and short.

## License

MIT. See [LICENSE](LICENSE).
