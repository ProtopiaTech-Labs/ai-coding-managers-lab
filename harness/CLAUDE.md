# Zasady

Miej je przed oczami przy każdej decyzji:

- **Najpierw myśl, potem koduj.** Nie zakładaj. Nie ukrywaj niejasności. Napisz, co wybrałeś i co odrzuciłeś.
- **Najprościej, jak się da.** Minimum kodu, które rozwiązuje zadanie. Nic na zapas.
- **Zmiany chirurgiczne.** Dotykaj tylko tego, czego wymaga zadanie. Sprzątaj tylko po sobie.
- **Cel przed ruchem.** Znaj kryterium "zrobione". Pracuj, aż build i testy są zielone.

Wyjątki:

1. Akcja destrukcyjna (usuwanie plików, force push, migracja bazy): najpierw zapytaj.
2. Trzy nieudane próby naprawy: zatrzymaj się, nazwij podejrzane założenie, zadaj jedno pytanie.
3. Prawdziwa niejasność: jedno pytanie zamiast zgadywania.

Styl rozmowy daje output style. Zasady pisania plików `.md` są w `.claude/rules/writing-docs.md`.

# Proces

1. Przed kodem przeczytaj `docs/spec.md`. Spec jest źródłem prawdy. Gdy zadanie z nim się kłóci, zapytaj.
2. Jeden feature = jedno GitHub Issue = jedna gałąź = jeden pull request z `Closes #N`.
3. Plan przed kodem: w plan mode napisz, co zmienisz, jakie ryzyka widzisz i co odrzuciłeś. Czekaj na akceptację.
4. Commit po każdym domkniętym kroku, z opisem po polsku w trybie rozkazującym.
5. Gdy hook zablokuje komendę albo edycję, pokaż mi blokadę. Nie obchodź jej.

# Weryfikacja

1. Po każdej zmianie uruchom testy i lint. Wklej mi wynik, nie streszczenie.
2. Czerwony test naprawiasz w kodzie, nie w teście. Zmiana testu wymaga mojej zgody.
3. "Gotowe" znaczy: testy zielone, lint czysty, aplikacja uruchomiona i sprawdzona w przeglądarce.

# Stos i komendy

<!-- Uzupełnia agent w lekcji 04 na podstawie tego, co postawił. -->

- Dev: `TODO`
- Testy: `TODO`
- Lint i typy: `TODO`
- Build produkcyjny: `TODO`

# Zakazy

- Nie zmieniaj progów jakości w `pyproject.toml`, `web/eslint.config.mjs` ani plików w `.claude/`.
- Nie używaj `# noqa`, `# type: ignore` ani `eslint-disable`.
- Nie commituj z `--no-verify`.
- Nie dodawaj zależności bez pytania.
- Nie pisz nazwy firmy klienta w kodzie, commitach ani dokumentach.

# Błędy agenta

Ten sam błąd dwa razy = wpis tutaj. Uzupełnia uczestnik w trakcie dnia.

- (pusto)
