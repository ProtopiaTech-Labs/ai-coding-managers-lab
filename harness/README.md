# Harness

Pliki, które agent stosuje w lekcji 04. Czyta to trener i agent uczestnika.

| Plik | Trafia do | Po co |
|---|---|---|
| `CLAUDE.md` | `CLAUDE.md` w korzeniu repo | Pełny plik z playbooka ProtopiaTech: zasady, start sesji, mapa repo, workflow (plan, zadania, commity, delegacja, BDD), review przez Codex, specyfika projektu już wypełniona pod stos warsztatu. Agent uzupełnia tylko "Repository map". |
| `rules/writing-docs.md` | `.claude/rules/writing-docs.md` | Zasady pisania plików `.md`: spec, plany, ADR. |

Output style `plain-action` i tryb `auto` są już w `.claude/settings.json` szablonu, więc działają od pierwszej sesji, także w vibe codingu.

Źródło: `ProtopiaTech/ai-playbook` (repo wewnętrzne), kopia tutaj, bo szablon jest publiczny. Pobranie bez klonowania:

```bash
curl -fsSL https://raw.githubusercontent.com/ProtopiaTech-labs/ai-coding-managers-lab/main/harness/CLAUDE.md
```
