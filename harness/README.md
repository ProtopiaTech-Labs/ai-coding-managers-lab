# Harness

Pliki, które agent stosuje w lekcji 04. Czyta to trener i agent uczestnika.

| Plik | Trafia do | Po co |
|---|---|---|
| `CLAUDE.md` | `CLAUDE.md` w korzeniu repo | Zasady, proces, weryfikacja, zakazy. Agent czyta go na starcie każdej sesji. Sekcję "Stos i komendy" uzupełnia agent. |
| `rules/writing-docs.md` | `.claude/rules/writing-docs.md` | Zasady pisania plików `.md`: spec, plany, ADR. |

Output style `plain-action` i tryb `auto` są już w `.claude/settings.json` szablonu, więc działają od pierwszej sesji, także w vibe codingu.

Źródło zasad: wewnętrzny playbook ProtopiaTech, wersja skrócona dla uczestników.
