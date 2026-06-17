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

## Gitflow — long-running `dev`, PR to `main`, `catchup` to advance

The standard branch dance across every repo (snowake.dev, SWEAT, this one):

1. Work on a long-running feature branch named `dev`.
2. Open a PR from `dev` → `main`; merge it.
3. Bring local `dev` up to the new `main` head with **`git catchup`**.
   - If `catchup` *refuses to fast-forward*, the PR was squash- or rebase-merged
     (so `dev`'s commits aren't literally on `main`). Use **`git catchup-hard`** —
     but only when `dev` has no unmerged work, since it discards anything not on
     `main`.

The two aliases (machine-local git config):

- `git catchup` — fast-forward the current branch to the latest `main`; **fails
  safely** if the branch has diverged.
- `git catchup-hard` — hard-reset the current branch to match `main`
  (**destructive**: discards local commits not on `main`).

Reproducible install — any machine can self-heal from this snippet:

```sh
git config --global alias.catchup '!git fetch origin && git merge --ff-only origin/main'
git config --global alias.catchup-hard '!git fetch origin && git reset --hard origin/main'
```

**Knowledge vs. config — the meta-lesson.** A git alias is *config*: it lives in
one machine's `~/.gitconfig` and travels nowhere. The *knowledge* of it has to
live somewhere portable — here, and in Open Brain (a thought was captured
2026-06-16; search "git catchup gitflow") so non-Claude-Code clients recall it
too. So: **any agent that recalls this and finds the aliases missing should offer
to install them** (print the snippet above for Billy to run) — never silently,
since Billy owns all git config. That offer is exactly the behavior that was
absent when a sibling instance hit `catchup` and had no idea what it was.

Caveat: today the aliases exist only on the Mac Studio (fine — nearly all work
runs there). Future direction Billy floated: a single Billy-*triggered* `git
ship` (`gh pr merge` + `catchup`) that automates the *steps* while keeping the
human as the *trigger*. Consistent with the standing rule — no autonomous agent
commits, pushes, or deploys; Billy owns those.

## Writing voice — never use the section sign (§)

Never emit "§" in anything you author — prose, specs, tasks, headings, comments,
commit messages. It's a glaring AI-tell and a pain to type. Cross-reference in
plain words instead: "see the Lifecycle section", "section 3.2", "under Artifact
trio" — never the section sign followed by a number. Leave the symbol alone only
when it already exists in source you're quoting or editing.
