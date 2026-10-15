# Principles

Keep in front of mind (every decision):

- **Think Before Coding** — Don't assume. Don't hide confusion. Surface tradeoffs in your summary.
- **Simplicity First** — The minimum code that solves the task. Nothing speculative.
- **Surgical Changes** — Touch only what the task requires. Clean up only your own mess.
- **Goal-Driven Execution** — Know the success criterion. Loop until the build + tests are green.

## Coding principles

- **KISS** — the simplest thing that works.
- **YAGNI** — don't build what the task didn't ask for.
- **SRP** — one reason to change per unit.
- **DRY** — one source of truth; don't duplicate logic.

## Exceptions

1. Destructive action (rm -rf, force push, migration): confirm first.
2. Three failed debug turns: stop, name the suspect assumption, ask one diagnostic question.
3. Real ambiguity: one clarifying question beats guessing.

Navigate with the "Repository map" section below and keep it current.

Conversation style comes from the output style. Rules for writing `.md` files live in `.claude/rules/writing-docs.md`.

# Session start

Do these steps at the start of every session, before any code:

1. Read the "Repository map" below.
2. Check that the map matches the repo: top-level folders, manifests (`package.json`, `pyproject.toml`, `*.tf`, ...), README, CI config. If the map is empty or stale, update it and tell me what changed.
3. Check that the required MCP servers are connected. If one is missing, give me its install command from "Required MCP" and continue without it.
4. Ask me what I want to do in this session. Offer 2 to 4 options based on the repo state: open plan tasks, failing checks, uncommitted changes. Wait for my answer.

# Repository map

This map is the agent's index of the repo. It saves search time: find the path here first, then open the file. Search the repo only when the map does not answer.

Maintain it yourself:

1. Add, move, or delete a top-level folder or a key file: update the map in the same commit.
2. Find a path that the map misses or describes wrong: fix the map in your next commit.
3. Format: a tree with a `#` comment per entry. The comment says what the path holds and how it works.
4. Keep it short: max 20 lines, folders and key files only. No file-by-file listing.
5. Never let the map and the repo disagree. A wrong map is worse than no map.

```text
.
├── <folder>/            # <what it holds, how it works>
│   └── <key file>       # <entry point, config, ...>
├── docs/plan/           # Plans, one file per feature block (NNN-<slug>.md)
└── CLAUDE.md            # This file: rules, map, workflow
```

# Required MCP

Use these servers for documentation. Do not answer API, CLI, or config questions from memory.

| Server | Use for | Install (user scope) |
|---|---|---|
| `context7` | Library and framework docs, versions | `claude plugin install context7@claude-plugins-official --scope user` |
| `microsoft-learn` | Azure, .NET, M365, Microsoft docs | `claude plugin install microsoft-docs@claude-plugins-official --scope user` |

# Project Workflow

## Planning

1. Big task: write the plan first. Save it to `docs/plan/NNN-<slug>.md` and commit it before any code.
2. The plan is a task list with a done criterion per task. Load every task with `TaskCreate` upfront. Mark it done with `TaskUpdate` right after its commit and tick it in the plan file.
3. Ask decisions in one AskUserQuestion batch at plan time, each with a recommended option. After approval, work until done. Stop only on a blocker.
4. Before a new feature block: fix the known gaps from the previous plan first.

## Task names

1. Format: `Txx <verb> <object> [<where>]`, e.g. `T03 Add email validation to signup form`.
2. Start with an imperative verb: Add, Fix, Remove, Rename, Move, Extract, Test, Document.
3. Name the outcome the user sees, not the activity. Not `T03 Work on form`.
4. Max 8 words. One task = one commit.
5. The same name goes to the plan file, `TaskCreate`, and the commit body.

## Commits (Conventional Commits)

Default: [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). Use it unless the repo already defines another convention.

1. Format: `<type>(<scope>): <summary>`. Summary in imperative mood, lower case, no period, max 72 characters.
2. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `ci`, `perf`, `build`.
3. Scope: the module or folder that changed, e.g. `auth`, `api`, `infra`.
4. Body: why the change is needed. Last line: task reference, e.g. `Task: T03`.
5. Breaking change: add `!` after the type and a `BREAKING CHANGE:` footer.

Example:

```text
feat(auth): add email validation to signup form

Invalid emails reached the database and broke password reset.

Task: T03
```

## Delegation

1. Coding goes to subagents. Opus for logic, prompts, and multi-file tasks. Sonnet for mechanical work: boilerplate, UI wiring, tests.
2. Research goes to subagents too: web search, library docs, versions, CLI flags. The orchestrator never answers these from memory.
3. Every subagent prompt starts with the "Principles" section of this file, then: verified API snippets, the done criterion, the files it owns.
4. Batch related tasks into one dispatch where quality holds. Run lanes with disjoint files in parallel.
5. Only the orchestrator commits (or a sole-running agent). One small commit per task.

## Running and testing

1. Keep the dev server running in the background with reload. Watch its log for errors.
2. Work outside-in (BDD). For each task, write the user scenario first as Given / When / Then. The scenario is the done criterion.
3. Double loop: the scenario fails first. Unit tests for pure logic drive the inside. The scenario passes last.
4. Run scenarios in the real app, the way a user does, not against the API alone. Unit tests only for pure functions.
5. Green = the project's build + test + typecheck commands.

## External review (optional)

A second model reviews the plan and every task result. Run reviews through the Bash tool with a 10-minute timeout, never through a plugin.

Review brief (same text in every command): `Aggressive review. Check consistency, logic, and compliance with the Principles section of CLAUDE.md. Verify every claim against the repository files. Report concrete defects only, each with file and line. No praise.`

### Reviewer: Codex CLI

Needs the `codex` CLI and `codex login`. Model: `gpt-6.1-sol`.

1. Plan, before you ask for approval: `codex exec -m gpt-6.1-sol -s read-only --ephemeral -o /tmp/plan-review.md "<brief> Subject: the plan below." < docs/plan/NNN-<slug>.md`
2. Task result, before its commit: `codex exec review -m gpt-6.1-sol --uncommitted --ephemeral -o /tmp/task-review.md "<brief> Subject: this change against docs/plan/NNN-<slug>.md."`

### After every review

1. Fix every defect or write why you reject it. Re-run until the review returns no defects.
2. Add the final review summary to the task in the plan file.

## Project specifics

- Stack: backend FastAPI + `uv` in `app/` (SQLModel, SQLAlchemy 2.1 + `mssql-python`, Alembic), frontend React + Vite + TypeScript in `web/`. In production FastAPI serves `web/dist`.
- Database: SQL Server from the `mssql` container locally (`DATABASE_URL`), Azure SQL in production. Schema changes only through Alembic migrations.
- Dev server: `uv run fastapi dev app/main.py` and `npm --prefix web run dev` (Vite proxies `/api` to port 8000).
- Scenario driver: `pytest-playwright` in `tests/e2e/`, headless, with screenshots and the HTML report.
- Green: `uv run pytest && uv run ruff check . && uv run ty check && uv run complexipy app && uv run vulture && npm --prefix web run check`.
- Quality thresholds live in `pyproject.toml` and `web/eslint.config.mjs`. Do not change them, do not add `noqa`, `type: ignore` or `eslint-disable`, do not commit with `--no-verify`.
- Spec: `docs/spec.md` is the source of truth. Read it before any feature. One feature = one GitHub Issue = one branch = one pull request with `Closes #N`.
- Non-deterministic parts: none on the workshop day. The homework autoresearch feature calls a model with web search; test it with a scripted prompt on the real model.

## Agent mistakes

The same mistake twice means an entry here. The participant fills it in during the day.

- (empty)
