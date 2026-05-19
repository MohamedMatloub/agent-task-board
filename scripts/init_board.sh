#!/usr/bin/env bash
# Create the nested Markdown agent board in the current project.
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
SKILL_DIR="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$SKILL_DIR/templates"

mkdir -p board/features board/done

copy_if_missing() {
  source_file="$1"
  target_file="$2"

  if [ -e "$target_file" ]; then
    printf 'Skipped existing %s\n' "$target_file"
    return
  fi

  cp "$source_file" "$target_file"
  printf 'Created %s\n' "$target_file"
}

write_if_missing() {
  target_file="$1"
  content="$2"

  if [ -e "$target_file" ]; then
    printf 'Skipped existing %s\n' "$target_file"
    return
  fi

  printf '%s\n' "$content" > "$target_file"
  printf 'Created %s\n' "$target_file"
}

copy_if_missing "$TEMPLATE_DIR/STATUS.md" board/status.md
copy_if_missing "$TEMPLATE_DIR/BOARD_README.md" board/README.md
write_if_missing "board/changelog.md" "# Changelog

- $(date +%F): Board created."
write_if_missing "board/decisions.md" "# Decisions

- $(date +%F): Use local Markdown board state."

printf 'Agent task board ready.\n'
