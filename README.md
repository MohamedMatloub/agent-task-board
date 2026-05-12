# Agent Task Board Skill

Agent Task Board is an agent-friendly skill for creating and managing a Markdown task board inside a repository. It stores project work in plain files under `board/`, so agents and humans can inspect, edit, and review task state without an external tracker.

## Why Use It
- Keeps task planning and implementation status in the codebase.
- Gives agents a consistent workflow for creating, claiming, updating, and completing tasks.
- Works across agent runtimes because it depends on Markdown files and a shell initializer.

## How To Install
Install from the published repository with `npx skills add`:

```bash
npx skills add owner/repo --skill agent-task-board
```

## How To Use
Ask your agent to use the skill in the target project. For example:

```text
Set up an agent task board for this project.
```

```text
Create a task for adding authentication.
```

```text
Plan the next tasks for this feature.
```

```text
Pick the next task and start working on it.
```

The agent should initialize the project.

## What It Creates
The initializer creates missing board files and leaves existing project instruction files untouched:

```text
board/
  README.md
  features/
  done/
  _templates/
    EPIC_TEMPLATE.md
    FEATURE_TEMPLATE.md
    TASK_TEMPLATE.md
```

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE).
