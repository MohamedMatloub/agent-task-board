---
name: agent-task-board
description: Skill for setting up and managing a markdown-based project task board, featuring epics, tasks, and an agent-friendly workflow.
---

# Agent Task Board Skill

This skill provides a standardized, markdown-based issue tracker and project management board that resides directly in the codebase under the `board/` directory. It is designed to work across agent runtimes because all state is stored in plain Markdown files in the repository.

## When to use this skill
- When the user asks to set up a task board or project tracking system.
- When working in a project whose existing instructions or source of truth define this workflow.
- When the user asks to create, plan, claim, pick, prioritize, update, review, or complete project tasks.
- When the user asks what to work on next, asks for a task plan, or asks to break work into tasks.

## Setup Instructions

Initialize the board when either condition is true:

- The user explicitly asks to set up or initialize an agent task board.
- The user asks for board-backed task work, such as creating a task, planning tasks, choosing the next task, claiming work, or updating task status, and the target project does not already have `board/README.md`.

Do not ask the user for a separate setup confirmation before initializing in response to board-backed task work. The initializer only creates missing board files and does not modify existing project instruction files.

If `board/` exists but `board/README.md`, `board/features/`, `board/done/`, or `board/_templates/` is missing, run the initializer to repair the incomplete setup before continuing.

To initialize:

1. From the target project root, run the initialization script from this skill's installed directory:
   `bash /path/to/agent-task-board/scripts/init_board.sh`
   Replace `/path/to/agent-task-board` with the actual directory where this skill is installed. Agents should use whatever shell-command tool their runtime provides.
2. This will create missing board files and leave existing project instruction files untouched:
   - `board/README.md`
   - `board/features/` and `board/done/` directories
   - `board/_templates/` with Epic, Feature, and Task templates

## Usage After Setup

After initialization, `board/README.md` is the source of truth for board layout, status values, active features, done features, and the agent workflow. Agents should read it before creating, claiming, updating, or completing board tasks.
