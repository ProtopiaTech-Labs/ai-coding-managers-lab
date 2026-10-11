# ai-coding-managers-lab

Środowisko do warsztatu z Claude Code. Działa w GitHub Codespaces i lokalnie w Dev Containers.

## Start w Codespaces

1. Kliknij **Use this template** → **Create a new repository**. Ustaw repo jako prywatne.
2. W nowym repo kliknij **Code** → **Codespaces** → **Create codespace on main**.
3. Poczekaj, aż terminal pokaże `Gotowe`.
4. Uruchom `claude` w terminalu i zaloguj się.

## Start lokalnie

1. Zainstaluj Docker Desktop i VS Code z rozszerzeniem Dev Containers.
2. Sklonuj repo i otwórz je w VS Code.
3. Wybierz **Reopen in Container**.

## Co jest w środowisku

- Claude Code (`claude`) i Codex (`codex`, zawsze najnowsza wersja)
- Node.js LTS (Next.js), Python 3.12 i `uv`
- SQLite (`sqlite3`) i SQL Server 2025 jako lokalny odpowiednik Azure SQL (`sqlcmd`, host `mssql`)
- Azure CLI (`az`) i GitHub CLI (`gh`)

Połączenie z SQL Server:

```bash
sqlcmd -S mssql -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT @@VERSION"
```
