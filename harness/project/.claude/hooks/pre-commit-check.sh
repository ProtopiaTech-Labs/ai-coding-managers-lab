#!/usr/bin/env bash
# PreToolUse (Bash, if "git commit"): run the full Green gate. Exit 2 blocks the commit.
set -uo pipefail

command=$(jq -r '.tool_input.command // empty')
[[ "$command" =~ git[[:space:]]+commit ]] || exit 0

cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 2

checks=(
  "uv run pytest --ignore=tests/e2e"
  "uv run ruff check ."
  "uv run ty check"
  "uv run complexipy app"
  "uv run vulture"
  "npm --prefix web run check"
)

status=0
for check in "${checks[@]}"; do
  if ! output=$($check 2>&1); then
    printf 'FAILED: %s\n%s\n\n' "$check" "$output" >&2
    status=2
  fi
done
[[ $status -ne 0 ]] && echo "Commit blocked: fix the checks above." >&2
exit "$status"
