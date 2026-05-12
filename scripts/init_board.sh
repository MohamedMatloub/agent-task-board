#!/bin/bash
# Initializes the agent-task-board structure in the current directory.
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RESOURCES_DIR="$SKILL_DIR/resources"

mkdir -p board/features board/done board/_templates

copy_if_missing() {
  source_file="$1"
  target_file="$2"

  if [ -f "$target_file" ]; then
    echo "Skipped existing $target_file"
  else
    cp "$source_file" "$target_file"
    echo "Created $target_file"
  fi
}

# Copy templates to board/_templates without overwriting local changes.
copy_if_missing "$RESOURCES_DIR/EPIC_TEMPLATE.md" board/_templates/EPIC_TEMPLATE.md
copy_if_missing "$RESOURCES_DIR/FEATURE_TEMPLATE.md" board/_templates/FEATURE_TEMPLATE.md
copy_if_missing "$RESOURCES_DIR/TASK_TEMPLATE.md" board/_templates/TASK_TEMPLATE.md

# Setup the root board README
copy_if_missing "$RESOURCES_DIR/board_README.md" board/README.md

echo "Agent task board initialized successfully!"
