#!/usr/bin/env bash
set -euo pipefail

# Codex zawsze najnowszy.
npm i -g @openai/codex@latest

# Klucz Anthropic do pliku dla apiKeyHelper. Rozszerzenie VS Code w Codespaces
# nie widzi sekretów konta (trafiają tylko do sesji terminala), a helper czyta
# plik z każdego procesu. Skrypt startowy widzi sekrety, więc kopiuje je tutaj.
if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
  (umask 077; printf '%s' "$ANTHROPIC_API_KEY" > "$HOME/.claude/anthropic_key")
fi
