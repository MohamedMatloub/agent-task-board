#!/usr/bin/env bash
# Validate nested board task metadata.
set -eu

BOARD_DIR="${1:-board}"
VALID_STATUSES=" Todo InProgress Blocked Review Done "
VALID_PRIORITIES=" P0 P1 P2 P3 "
REQUIRED_FIELDS="ID Status Priority DependsOn"
errors=0
ids_file="$(mktemp)"
tasks_file="$(mktemp)"
meta_file="$(mktemp)"

cleanup() {
  rm -f "$ids_file" "$tasks_file" "$meta_file"
}
trap cleanup EXIT

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  errors=$((errors + 1))
}

metadata_for() {
  sed '/^## /,$d' "$1" > "$meta_file"
}

metadata_value() {
  sed -n "s/^$1: //p" "$meta_file" | head -n 1
}

has_id() {
  grep -q "^$1	" "$ids_file"
}

if [ ! -d "$BOARD_DIR" ]; then
  fail "missing board directory: $BOARD_DIR"
  exit 1
fi

if [ ! -d "$BOARD_DIR/features" ]; then
  fail "missing features directory: $BOARD_DIR/features"
fi

if [ ! -d "$BOARD_DIR/done" ]; then
  fail "missing done directory: $BOARD_DIR/done"
fi

find "$BOARD_DIR/features" "$BOARD_DIR/done" -type f -name 'TASK-*.md' 2>/dev/null | sort > "$tasks_file"

if [ ! -s "$tasks_file" ]; then
  printf 'No task files found under %s/features or %s/done\n' "$BOARD_DIR" "$BOARD_DIR"
  exit "$errors"
fi

while IFS= read -r file; do
  metadata_for "$file"
  id="$(metadata_value ID)"

  if [ -n "$id" ]; then
    printf '%s\t%s\n' "$id" "$file" >> "$ids_file"
  fi
done < "$tasks_file"

if [ -s "$ids_file" ]; then
  duplicates="$(cut -f1 "$ids_file" | sort | uniq -d)"
  if [ -n "$duplicates" ]; then
    old_ifs="$IFS"
    IFS='
'
    for id in $duplicates; do
      matches="$(grep "^$id	" "$ids_file" | cut -f2 | tr '\n' ' ')"
      fail "duplicate task ID $id in: $matches"
    done
    IFS="$old_ifs"
  fi
fi

while IFS= read -r file; do
  [ -f "$file" ] || continue
  metadata_for "$file"

  for field in $REQUIRED_FIELDS; do
    count="$(grep -Ec "^$field: " "$meta_file" || true)"
    if [ "$count" -eq 0 ]; then
      fail "$file missing required field: $field"
    elif [ "$count" -gt 1 ]; then
      fail "$file has duplicate field: $field"
    fi
  done

  if grep -Eq '^(ID|Status|Priority|DependsOn|Owner|Branch):[^ ]' "$meta_file"; then
    fail "$file has malformed metadata; use 'Field: value'"
  fi

  id="$(metadata_value ID)"
  status="$(metadata_value Status)"
  priority="$(metadata_value Priority)"
  depends_on="$(metadata_value DependsOn)"
  filename_id="$(basename "$file" .md)"

  if [ -n "$id" ]; then
    case "$id" in
      TASK-[0-9][0-9][0-9]) ;;
      *) fail "$file has invalid ID: $id" ;;
    esac

    if [ "$filename_id" != "$id" ]; then
      fail "$file filename does not match ID: $id"
    fi
  fi

  if [ -n "$status" ] && ! printf '%s' "$VALID_STATUSES" | grep -q " $status "; then
    fail "$file has invalid Status: $status"
  fi

  if [ -n "$priority" ] && ! printf '%s' "$VALID_PRIORITIES" | grep -q " $priority "; then
    fail "$file has invalid Priority: $priority"
  fi

  if [ -n "$depends_on" ] && [ "$depends_on" != "none" ]; then
    compact="$(printf '%s' "$depends_on" | tr -d ' ')"
    old_ifs="$IFS"
    IFS=,
    for dep in $compact; do
      case "$dep" in
        TASK-[0-9][0-9][0-9])
          if ! has_id "$dep"; then
            fail "$file depends on missing task: $dep"
          fi
          ;;
        *) fail "$file has invalid DependsOn entry: $dep" ;;
      esac
    done
    IFS="$old_ifs"
  fi
done < "$tasks_file"

if [ "$errors" -gt 0 ]; then
  printf 'Board validation failed with %s error(s).\n' "$errors" >&2
  exit 1
fi

printf 'Board validation passed.\n'
