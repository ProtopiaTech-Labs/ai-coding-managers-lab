#!/usr/bin/env bash
# PostToolUse (Edit|Write): lint the edited file. Exit 2 sends the errors back to Claude.
set -uo pipefail

file=$(jq -r '.tool_input.file_path // empty')
[[ -z "$file" || ! -f "$file" ]] && exit 0

root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
cd "$root" || exit 0

run() {
  local output
  if ! output=$("$@" 2>&1); then
    printf '%s\n%s\n\n' "\$ $*" "$output" >&2
    return 1
  fi
}

status=0
case "$file" in
  *.py)
    run uv run ruff check "$file" || status=2
    run uv run ty check "$file" || status=2
    run uv run complexipy "$file" || status=2
    ;;
  "$root"/web/*.ts | "$root"/web/*.tsx | web/*.ts | web/*.tsx)
    run npm --prefix web exec -- eslint --max-warnings 0 "$(realpath "$file")" || status=2
    ;;
esac
exit "$status"
