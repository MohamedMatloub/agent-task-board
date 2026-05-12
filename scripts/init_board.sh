#!/bin/bash
# Initializes the project-board structure in the current directory.

SKILL_DIR="$(dirname "$0")/.."
RESOURCES_DIR="$SKILL_DIR/resources"

mkdir -p board/features board/done board/_templates tasks

# Copy templates to board/_templates
cp "$RESOURCES_DIR/EPIC_TEMPLATE.md" board/_templates/
cp "$RESOURCES_DIR/FEATURE_TEMPLATE.md" board/_templates/
cp "$RESOURCES_DIR/TASK_TEMPLATE.md" board/_templates/

# Setup the root board README
cp "$RESOURCES_DIR/board_README.md" board/README.md

# Setup AGENTS.md in the root
cp "$RESOURCES_DIR/AGENTS.md" AGENTS.md

# Initialize empty tasks/lessons.md if it doesn't exist
if [ ! -f tasks/lessons.md ]; then
  echo "# Lessons" > tasks/lessons.md
  echo "- Add specific mistakes to avoid here." >> tasks/lessons.md
fi

echo "Project board initialized successfully!"
