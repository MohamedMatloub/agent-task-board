---
name: project-board
description: Agent skill for setting up and managing a markdown-based project task board, featuring epics, tasks, and an automated agent workflow.
---

# Project Board Skill

This skill provides a standardized, markdown-based issue tracker and project management board that resides directly in the codebase under the `board/` directory.

## When to use this skill
- When the user asks to set up a task board or project tracking system.
- When working in a project that has a `board/` directory or an `AGENTS.md` file defining this workflow.
- When creating, claiming, or resolving tasks across epics and features.

## Setup Instructions

If the user requests to initialize this setup in a new project:

1. Run the initialization script from the skill directory to scaffold the necessary directories and templates:
   `bash ~/.gemini/antigravity/skills/project-board/scripts/init_board.sh`
   *(Note: use a bash `run_command` inside the project root to execute this script)*
2. This will create:
   - `AGENTS.md` in the root
   - `board/README.md`
   - `board/features/` and `board/done/` directories
   - `board/_templates/` with Epic, Feature, and Task templates
   - `tasks/lessons.md`

## Agent Workflow Rules

When working in a repository with this setup, follow these strict rules:

### Board Layout
- `board/features/` contains active, blocked, review, and partially done feature folders.
- `board/done/` contains fully completed feature folders, including their epics and tasks.
- `board/_templates/` contains the Markdown templates for new features, epics, and tasks.

### Status Values
Use EXACTLY these values in feature, epic, and task metadata:
- `Todo`
- `Doing`
- `Review`
- `Done`

### Task Management Workflow
1. **Claim Work:** Pick an unowned `Todo` task from a feature in `board/features/`.
2. **Start Work:** Set the task's `status: Doing`, fill in `owner: Antigravity`, set `started: YYYY-MM-DD`, and add a progress log entry.
3. **Implement:** Write code, implement the task, and verify your changes. Keep changes minimal and scoped to the task.
4. **Complete Work:** Set the task's `status: Done`, set `finished: YYYY-MM-DD`, and record verification/implementation notes in the task file.
5. **Update Parent Epic:** Go to the parent `EPIC.md` file. Update the task checklist to `[x]` and update the progress percentage.
6. **Update Parent Feature:** Go to the parent `FEATURE.md` file. If the epic's progress changed, update it there.
7. **Complete Feature:** If all epics in a feature are `Done`, move the entire feature folder from `board/features/` to `board/done/`.
8. **Learn:** If you make a mistake and the user corrects you, add a note to `tasks/lessons.md` so the mistake is not repeated.

### Documentation Files
- **`Features.md` (Optional project-level file)**: Describes feature intent and major design decisions. Do NOT duplicate task progress here; link to the board instead.
- **`tasks/lessons.md`**: Project-specific mistakes to avoid. Always read before implementing.
- **`DEVELOPER_NOTES.md`**: Mocked features, placeholders, and architecture notes. Update only when architecture changes.
