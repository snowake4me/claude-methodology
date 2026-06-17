# claude-methodology

My personal, portable development methodology — **one muscle memory** across
every project, current and future. The source of truth lives here; `install.sh`
symlinks it into `~/.claude/` so Claude Code picks it up in every project
automatically. No copying into projects, no per-project drift.

## What's here

| Path | Role |
|------|------|
| `CLAUDE.md` | The standing rules (artifact trio + lifecycle + the `dev`→`main` gitflow and `catchup` aliases). Installed as a *managed block* in `~/.claude/CLAUDE.md` — the passive layer that applies even when no skill is invoked. |
| `skills/frame/` | `/frame` — turn a fuzzy intent into an approved SPEC or TASK before any code. Carries the canonical templates. |
| `skills/retro/` | `/retro` — close a unit of work: CHANGELOG line, move the task to `done/`, push learnings into steering docs. |
| `skills/design-handoff/` | `/design-handoff` — run a Claude Design ↔ Claude Code collaboration over the cross-surface handoff protocol (Open Brain = signal, repo = payload). Carries the canonical OB reference-thought + per-project bootstrap templates. |
| `specs/` | Decision records. First entry: `SPEC-2026-06-13-design-code-handoff.md`. |
| `install.sh` | Idempotent symlink installer. |

## The model

Three folders at each project's **root** (not buried in `docs/` — that's where
they get lost):

| Folder | Holds | Moves? |
|--------|-------|--------|
| `specs/` | decision records — "why this approach over the alternatives" | no (durable) |
| `tasks/` | scoped, ready-to-execute work — clear *what* + *how* | → `done/` on ship |
| `done/` | executed tasks, each with an appended Outcome (commit + learnings) | archive |

"What shipped" lives in the project's `CHANGELOG.md` — one single searchable
archive. "What we learned" lives in the moved task's Outcome block + steering
docs. **There is no standalone DONE file.**

## Install (new machine)

```
git clone <this repo> ~/code/ai/claude-methodology
~/code/ai/claude-methodology/install.sh
```

Re-run `install.sh` any time — it's idempotent (re-links, refreshes the managed
CLAUDE.md block, backs up anything it replaces).

## Editing

Edit files **here**, in the repo. The symlinks make changes live in every
project instantly. Change the convention once; every project inherits the fix.
