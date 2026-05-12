# Agent Instructions

Before starting any new work in this project, read these files in order:

1. `board/README.md` - primary task board, active/done feature index, and agent workflow.
2. `Features.md` - feature plans, scope, implementation decisions, and feature status.
3. `tasks/todo.md` - legacy pointer to the board and historical note.
4. `tasks/lessons.md` - project-specific mistakes to avoid.
5. `DEVELOPER_NOTES.md` - mocked features, placeholders, and architecture notes.

## Working Rules
- Keep `Features.md` updated when feature scope, implementation decisions, or completion status changes.
- Use `board/` as the primary source of truth for task tracking. Claim, update, and complete work in the relevant board task file.
- Keep parent `EPIC.md` and `FEATURE.md` files updated as board tasks progress.
- Move completed feature folders from `board/features/` to `board/done/` when all epics and tasks are done.
- Update `tasks/lessons.md` after user corrections with a rule that prevents repeating the mistake.
- Prefer simple, minimal-impact changes that follow existing project patterns.
- Verify changes before marking work complete.
- Do not overwrite unrelated user or agent changes in the working tree.
