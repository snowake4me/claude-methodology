---
name: retro
description: >-
  Close a completed unit of work the consistent way: append the user-facing line
  to CHANGELOG, move the TASK file to done/ with an Outcome block, push any
  steering-worthy learning back into the project's CLAUDE.md / memory, and broadcast
  a significant milestone to cross-client memory (Open Brain). The retrospective
  bookend to /frame. Invoke when a task is shipped or about to ship.
---

# /retro — close the loop

Run when a unit of work is done. Four moves, in order. Do NOT `git commit` —
stage and tee up the command for the user (see global CLAUDE.md git rules).

## 1. Record what shipped → CHANGELOG

Add a concise, user-facing entry to the project's `CHANGELOG.md` (and any mirror
the project's CLAUDE.md names, e.g. a release-notes file). One line per change.
This is the single searchable "what shipped" archive — keep it terse.

## 2. Move the task → done/

If a `tasks/TASK-*.md` file backs this work:

- `git mv tasks/<slug>.md done/<slug>.md` (create `done/` at the repo root if absent).
- Append an `## Outcome` block to the moved file:

  ```
  ## Outcome
  - **Shipped:** <date> · commit <hash> (tee up the commit; the user runs it)
  - **Result:** one line — did it meet the acceptance criteria?
  - **Learnings:** 1–3 things worth remembering. What surprised us? What would we
    do differently? "Nothing non-obvious" is a fine answer.
  ```

`ls tasks/` is now the live worklist; `done/` is the archive.

## 3. Feed steering docs

If a learning should change how future work goes — a convention, a gotcha, a
preference — push it to the right home:

- project-specific → the project's `CLAUDE.md` or memory;
- cross-project / methodology → propose an edit to the methodology repo
  (`~/code/ai/claude-methodology`), so every project inherits it.

Don't manufacture learnings. If the work was routine, steps 1–2 are the whole retro.

## 4. Broadcast the milestone → Open Brain (cross-client memory)

If this was a *significant* unit of work — a shipped feature, an architecture or
naming decision, a project-state shift — capture a standalone summary to **Open
Brain** (`capture_thought`), the user's cross-client brain. CHANGELOG is repo-local;
Open Brain is what lets a *different* Claude client (Desktop, web, Design) recall this
later — e.g. asking Claude Design to update a diagram with the feature you just
shipped. Don't wait to be asked; this is the cross-client half of "record what shipped."

- Write a clear, **standalone narrative paragraph** that makes sense to any AI later
  (what shipped, how it works at altitude, what's still open) — not a terse log line.
- **Correct stale prior thoughts** when facts changed: add an explicit "this CORRECTS
  the earlier thought that said …" note rather than silently contradicting it.
- **Plain ASCII prose only.** Open Brain posts through a WAF that blocks code-looking
  content — no backticks/code blocks, no `≥`/`→`/non-ASCII, no parenthesized query or
  regex syntax. Spell things out ("PG and E", "greater-or-equal", commands sans backticks).
- If Open Brain isn't connected in this client, note it and skip — never block the retro.

Routine fixes don't need this; like the rest, don't manufacture a milestone.

## What this skill is NOT

- Not a second CHANGELOG. The Outcome block is *learnings*, not a re-listing of changes.
- Not a commit step. Stage + tee up; the user commits.
