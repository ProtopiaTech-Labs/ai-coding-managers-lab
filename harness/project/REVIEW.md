# Review checklist

The `reviewer` subagent reads this file before each pull request. Check the diff in three passes, in this order.

## 1. Bugs

- The code does what the task and its Given / When / Then scenario say.
- Error paths return a correct status code and do not swallow exceptions.
- Database sessions and connections close on every path.
- Schema changes come with an Alembic migration that upgrades and downgrades.
- The frontend handles loading, error, and empty states.
- New logic has a test: a unit test for pure functions, a scenario in `tests/e2e/` for user flows.

## 2. Security

- No secrets, passwords, or connection strings in code, tests, or logs.
- SQL uses bound parameters. No user input in f-string SQL.
- Every input from a request has a Pydantic or SQLModel type with limits.
- Error responses do not leak stack traces or database details.
- New dependencies are necessary, maintained, and pinned in the lock file.

## 3. Compliance with the spec

- The change matches `docs/spec.md`. Any difference is a defect.
- The change does nothing that the spec and the issue did not ask for.
- The pull request closes one issue with `Closes #N`.
- The diff has no `noqa`, `type: ignore`, `eslint-disable`, or changed thresholds.
- A custom UI component that shadcn/ui already has is a defect.
- `CLAUDE.md` "Repository map" matches new or moved folders and key files.
