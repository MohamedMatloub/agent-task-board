# Agent Task Board

This directory is the primary source of truth for project work. Agents and humans should use this board before starting, claiming, or completing tasks.

## Status Values
Use exactly these values in feature, epic, and task metadata:

- `Todo`
- `Doing`
- `Review`
- `Done`

## Board Layout
- `board/features/` contains active, blocked, review, and partially done feature folders.
- `board/done/` contains fully completed feature folders, including their epics and tasks.
- `board/_templates/` contains the Markdown templates for new features, epics, and tasks.

When every epic in a feature is `Done`, move the entire feature folder from `board/features/` to `board/done/`.

## Active Features
- Add your active features here

## Done Features
- Add your done features here

## Agent Workflow
1. Pick an unowned `Todo` task from `board/features/`.
2. Set `status: Doing`, fill `owner`, set `started`, and add a progress log entry.
3. Implement and verify the task.
4. Set task `status: Done`, set `finished`, record verification and implementation notes.
5. Update the parent `EPIC.md` task list and progress.
6. Update the parent `FEATURE.md` epic list and progress.
7. If all epics are `Done`, move the whole feature folder to `board/done/`.
8. If new constraints affect other work, update related tasks.

## Project Constraints
- Keep task changes minimal and scoped to the claimed task.
- Verify changes before marking any task complete.
- Do not overwrite unrelated user or agent changes.
