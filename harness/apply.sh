#!/usr/bin/env bash
# Kopiuje harness do korzenia repo i instaluje zależności. Uruchamiasz raz, w lekcji 05.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

cp -R harness/project/. .
chmod +x .claude/hooks/*.sh

uv sync
npm --prefix web ci
uv run playwright install --with-deps chromium
uv run alembic upgrade head

echo
echo "Harness zastosowany. Sprawdzenia: uv run pytest --ignore=tests/e2e && uv run ruff check . && uv run ty check && uv run complexipy app && uv run vulture && npm --prefix web run check"
