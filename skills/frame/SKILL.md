---
name: frame
description: >-
  Inception ritual — turn a rough intent into a small, approved artifact BEFORE
  writing any code. Interrogates the user to surface scope, acceptance criteria,
  affected surface, and a verification plan, then emits a micro-spec and STOPS
  for approval. If the work outlives the session, graduates it into a canonical
  TASK or SPEC. Portable across projects. Invoke at the START of a feature or
  change when the intent is still fuzzy, or whenever a session is about to
  vibe-code something underspecified.
---

# /frame — frame the work before building it

Kill session-to-session variance by always converting a fuzzy intent into a
small, approved artifact before any code is written. Brownfield and incremental:
one micro-spec per unit, never a PRD or an epic backlog. Keep it light — one
short exchange.

## Phase 1 — Orient (silent, fast)

1. If the user gave a rough intent as an argument, use it. Else ask one line:
   "What are we framing?"
2. Read the project's steering docs if present — `CLAUDE.md`, and any `SPEC.md` /
   `README` it points to — enough to know its conventions (versioning, deploy,
   tests, key files). Don't dump what you find; absorb it so your questions are
   sharp and project-aware.
3. Glance at the relevant code surface so your questions are grounded in what
   actually exists, not generic.

## Phase 2 — Grill (the core move)

Ask **3–5 sharp, specific questions** — the ones whose answers actually change
what gets built. Prefer `AskUserQuestion` so they're fast to answer. Bias toward:

- **Scope boundary** — what's explicitly IN, and what's explicitly OUT?
- **Acceptance criteria** — how will we both know it's done and correct?
- **Affected surface** — which files / components / endpoints / infra? (Propose
  your best guess; have them confirm or correct.)
- **Verification** — how do we check it works? (test, run the app, eyeball?)
- **Risk / blast radius** — does this touch live data, infra, or anything hard to reverse?

Rules: ask only what's genuinely ambiguous (skip what the intent already
answers); lead each choice with your recommended default; never exceed 5. If you
want to ask more, you're over-framing — pick the load-bearing ones.

## Phase 3 — Emit the micro-spec

A compact inline block, ~15 lines, for approval. No prose padding:

```
## Frame: <short title>
**Intent:** <one sentence — the why>
**In scope:** <tight bullets>
**Out of scope:** <the things we're deliberately NOT doing>
**Acceptance criteria:** <2–4 checkable statements>
**Affected surface:** <files / components / lambdas / infra, as links>
**Verification:** <how we'll confirm it works>
**Release impact:** <bump tier + which changelog/release files, if the project
  versions; else "n/a">
```

## Phase 4 — Gate

Present the spec and **STOP**. Do not write code, edit files, or start the work.
End with: "Approve this frame, or tell me what to change." Proceed only on
explicit approval. After building, the natural close is an adversarial review
(`/code-review`), then `/retro`.

## Phase 5 — Land it (only if the work outlives the session)

A frame is ephemeral — it lives in the chat. For a one-session change, just
build it; the frame needs no home. But if the work will be picked up later (or
run by an AFK agent), graduate it into a tracked file using the **canonical
templates** in this skill's `templates/` dir. Do NOT match the project's local
file conventions — those drift by mood; the canonical model is the point.

- **Clear what + how, no open architectural fork →** TASK.
  Copy `templates/TASK.md` → `tasks/TASK-<date>-<slug>.md` (at the repo ROOT) and fill it.
- **A real fork — competing approaches / architectural ambiguity →** SPEC.
  Copy `templates/SPEC.md` → `specs/SPEC-<date>-<slug>.md` and fill it. A SPEC
  may then spawn one or more TASKs.

Create `tasks/` / `specs/` at the repo root if absent. Use the real date (check
the system date; don't guess). The tell: if the artifact documents *why this
approach over the alternatives*, it's a SPEC; if it's just *what to do and how*,
it's a TASK.

## What this skill is NOT

- Not a PRD generator. One artifact per unit of work.
- Not an epic/story decomposer. If the intent is epic-sized, say so and frame
  the first slice only.
- Not a build step. It always stops at the gate.
