# Methodology (all projects)

One artifact model across every project. Apply it everywhere unless a project's
own CLAUDE.md deliberately overrides it. Prefer this canonical model over
matching a project's pre-existing local file conventions — those accrete by mood
and drift; the whole point is that this doesn't.

## Artifact trio — at the repo ROOT, never buried in docs/

- `specs/SPEC-YYYY-MM-DD-slug.md` — a **decision record**, used only when there's
  a real fork (competing approaches / architectural ambiguity). Captures the
  options weighed and *why this one won*. Durable: specs do not move.
- `tasks/TASK-YYYY-MM-DD-slug.md` — a **scoped unit of work**: clear *what* +
  *how*, no open questions, ready to execute.
- `done/` — completed task files, moved here on ship.

Most work is clear enough to skip SPEC and go straight to TASK. Reach for a SPEC
only when you'd otherwise be making an unrecorded architectural call.

## Lifecycle — the folder IS the status

1. **Frame** (`/frame`) → an approved SPEC and/or TASK in `specs/`/`tasks/`.
2. **Build it.** Close with an adversarial review (`/code-review`) before commit.
3. **Ship** (`/retro`):
   - add the user-facing line to `CHANGELOG.md` (the single "what shipped" archive);
   - `git mv tasks/<slug>.md done/<slug>.md` and append an `## Outcome` block
     (commit, date, 1–3 learnings);
   - push any steering-worthy learning into the project's CLAUDE.md / memory.

So `ls tasks/` is always the live worklist; `done/` is the retrospective archive.
No standalone DONE file — "what shipped" is the CHANGELOG; "what we learned" is
the Outcome block + steering docs.

Full templates and rituals live in the `/frame` and `/retro` skills.

## Writing voice — never use the section sign (§)

Never emit "§" in anything you author — prose, specs, tasks, headings, comments,
commit messages. It's a glaring AI-tell and a pain to type. Cross-reference in
plain words instead: "see the Lifecycle section", "section 3.2", "under Artifact
trio" — never the section sign followed by a number. Leave the symbol alone only
when it already exists in source you're quoting or editing.
