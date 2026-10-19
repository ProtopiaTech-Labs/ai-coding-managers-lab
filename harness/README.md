# Harness

Gotowe pliki, które uczestnik stosuje w lekcji 06. Czyta to trener i agent uczestnika.

`project/` to wynik przebiegu próbnego z 2026-10-15 (prompt setupu z lekcji 06, potem shadcn), po poprawkach. `apply.sh` kopiuje go do korzenia repo i instaluje zależności:

```bash
bash harness/apply.sh
```

| W `project/` | Po co |
|---|---|
| `CLAUDE.md`, `.claude/rules/writing-docs.md` | Zasady z playbooka ProtopiaTech. Mapa repo do uzupełnienia przez agenta |
| `.claude/settings.json`, `.claude/hooks/` | Hook po edycji (lint pliku), hook przed `git commit` (pełna bramka bez e2e), hook na werdykt reviewera |
| `.claude/agents/reviewer.md`, `REVIEW.md` | Subagent review: Bugs, Security, Compliance, `VERDICT:` |
| `pyproject.toml`, `uv.lock`, `app/`, `tests/`, `alembic.ini`, `migrations/` | FastAPI, SQLModel, `mssql-python`, Alembic, progi ruff / complexipy / vulture, pytest z Playwright |
| `web/` | Vite + React + TypeScript, Tailwind 4, shadcn/ui (7 komponentów), ESLint z sonarjs |
| `.github/workflows/ci.yml` | Ta sama bramka na pull request i push do `main` |

Co nadpisuje: `.claude/settings.json` szablonu (styl i tryb auto zostają, dochodzą hooki). `.mcp.json` i `.claude/skills/` zostają bez zmian.

Pobranie pojedynczego pliku bez klonowania:

```bash
curl -fsSL https://raw.githubusercontent.com/ProtopiaTech-labs/ai-coding-managers-lab/main/harness/project/CLAUDE.md
```
