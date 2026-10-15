#!/usr/bin/env bash
set -euo pipefail

# Named volumes powstają jako root. Oddaj je użytkownikowi vscode.
sudo chown -R vscode:vscode /home/vscode/.claude /home/vscode/.codex

# SQLite CLI
sudo apt-get update
sudo apt-get install -y --no-install-recommends sqlite3 bzip2
sudo rm -rf /var/lib/apt/lists/*

# uv (Python)
curl -LsSf https://astral.sh/uv/install.sh | sh

# go-sqlcmd (SQL Server / Azure SQL)
case "$(uname -m)" in
  x86_64) arch=amd64 ;;
  aarch64 | arm64) arch=arm64 ;;
  *) echo "Unsupported arch: $(uname -m)" >&2; exit 1 ;;
esac
curl -fsSL "https://github.com/microsoft/go-sqlcmd/releases/latest/download/sqlcmd-linux-${arch}.tar.bz2" \
  | sudo tar -xj -C /usr/local/bin sqlcmd

# Claude Code: instalator natywny jako użytkownik vscode, do ~/.local.
# Feature devcontainera instaluje przez npm jako root, przez co auto-update
# nie ma prawa zapisu i wersja zostaje zamrożona na dzień budowy obrazu.
curl -fsSL https://claude.ai/install.sh | bash
grep -q '.local/bin' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
grep -q '.local/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# apiKeyHelper: jedno źródło klucza dla CLI i rozszerzenia VS Code.
# Plik pisze post-start.sh z sekretu Codespaces; lokalnie klucz idzie ze środowiska.
node -e '
const fs = require("fs");
const p = process.env.HOME + "/.claude/settings.json";
const s = fs.existsSync(p) ? JSON.parse(fs.readFileSync(p, "utf8")) : {};
s.apiKeyHelper = "cat $HOME/.claude/anthropic_key 2>/dev/null || printenv ANTHROPIC_API_KEY";
fs.writeFileSync(p, JSON.stringify(s, null, 2) + "\n");
'

# Codex CLI (post-start.sh aktualizuje go przy każdym starcie)
npm i -g @openai/codex@latest

echo
echo "Gotowe: claude, codex, node, python, uv, az, gh, sqlite3, sqlcmd"
