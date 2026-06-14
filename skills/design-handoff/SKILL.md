---
name: design-handoff
description: >-
  Run a Claude Design ↔ Claude Code collaboration over the proven cross-surface
  handoff protocol: Open Brain as the signaling bus (small, polled, confirm-receipt)
  and the git repo as the artifact store (versioned HANDOFF.md + built result for
  fidelity grading). Use when starting or continuing a Design↔Code build loop, when
  bootstrapping the protocol for a new project (set one slug + four params), or when
  you need to author/poll a handoff. Portable across projects; learnable by Claude
  Design from Open Brain alone (no local steering required).
---

# /design-handoff — cross-surface Design↔Code collaboration

A two-party protocol between **Claude Design** (browser/server-side, Anthropic
Labs — no local filesystem) and **Claude Code** (local, reads `~/.claude`
steering). It exists because the two surfaces can't share a filesystem, but both
reach **Open Brain** and both can read a named **git repo**.

This skill is the Code-side home of the protocol. The Design-side home is **one
canonical Open Brain thought** tagged `[DESIGN-CODE-PROTOCOL]` (see
`templates/ob-reference-thought.txt`) — that thought is Design's missing "global
system instruction." The two homes must say the same thing.

## The one core idea — split SIGNAL from PAYLOAD

| | Substrate | Carries | Properties |
|---|---|---|---|
| **SIGNAL** | Open Brain thoughts | "a handoff exists; here's its type + pointer" | small, cross-client, polled, confirm-receipt |
| **PAYLOAD** | the git repo | the detailed `HANDOFF.md` spec + the built result | large, versioned, durable |

Everything project-agnostic lives in that split. Everything that varies collapses
to four parameters.

## The four per-project parameters

Fill these once per project; nothing else changes.

| Param | Example (SWEAT) | Used for |
|---|---|---|
| **slug** | `SWEAT` | the per-project handoff tag `[SLUG-HANDOFF]` |
| **repo** | the project's git repo | where the payload lives |
| **HANDOFF.md path** | `design/HANDOFF.md` | the versioned build spec |
| **design-system ref** | the project's design source of truth | what Design grades fidelity against |

## Two reserved Open Brain tags

- `[DESIGN-CODE-PROTOCOL]` — **one** canonical reference thought, project-agnostic,
  the durable protocol itself. Both surfaces search this first each session to
  (re)learn the protocol. Do not create more than one.
- `[SLUG-HANDOFF]` — per-project runtime traffic: the actual handoff signals for
  that project (e.g. `[SWEAT-HANDOFF]`). One stream per project.

Keep them distinct: `[DESIGN-CODE-PROTOCOL]` is *how we work*; `[SLUG-HANDOFF]` is
*the work*.

## The bidirectional loop

1. **Design authors the spec.** Design writes/updates `HANDOFF.md` in the repo,
   then posts a `[SLUG-HANDOFF]` OB thought: `sender:design → recipient:code`,
   `type:task`, with a pointer to the HANDOFF.md commit/path. (No code in the OB
   thought — that's the payload's job.)
2. **Code confirms receipt + proposes a build order.** Code polls `[SLUG-HANDOFF]`
   via `search_thoughts`, reads `HANDOFF.md`, then posts a confirm-receipt thought:
   `sender:code → recipient:design`, `type:ack`, with its proposed build order.
   **No build starts before this ack.**
3. **Code builds.** The built result lands back **in-repo** (so Design can read it).
4. **Design inspects + grades.** Design re-reads the result against the
   design-system ref, grades fidelity, and posts the next `[SLUG-HANDOFF]` thought
   — either `type:accept` or `type:task` with revisions. Loop to step 2.

**Confirm-receipt is mandatory at every direction change.** A signal with no ack is
not yet a handoff — it's a hope.

## Open Brain hygiene (WAF constraint)

Open Brain sits behind a Cloudflare WAF that **blocks backticks, code fences, and
many special characters**. All OB thoughts in this protocol must be **plain ASCII
prose** — no backticks, no triple-fences, no angle brackets used as markup. Write
"see design/HANDOFF.md" not a code-formatted path. The reference template in
`templates/` is already WAF-safe; keep it that way.

## Bootstrapping a NEW project

The acceptance bar: a brand-new Design↔Code collaboration starts from a slug + the
four params alone, with no protocol re-derivation, and Design learns the protocol
from Open Brain alone.

1. **Once ever (global):** confirm a single `[DESIGN-CODE-PROTOCOL]` reference
   thought exists in Open Brain. If not, capture `templates/ob-reference-thought.txt`
   verbatim (Billy captures it — the skill does not auto-publish).
2. **Per project:** fill `templates/bootstrap-snippet.md` with the four params and
   drop it into the project (and/or post it once to the project's `[SLUG-HANDOFF]`
   stream). Point Claude Design at the repo and tell it to search
   `[DESIGN-CODE-PROTOCOL]` then `[SLUG-HANDOFF]`.
3. **Run the loop** (above). That's it — no protocol gets re-invented.

## What this skill is NOT

- Not a rebuild of SWEAT — SWEAT is the reference implementation, not the artifact.
- Not a universal multi-agent framework — strictly the two-party Design↔Code pattern.
- Not a freeze of the message schema or HANDOFF.md versioning — those stay
  per-project until SWEAT (v0.4+) proves a shape worth promoting into this spine.

## Templates

- `templates/ob-reference-thought.txt` — the canonical `[DESIGN-CODE-PROTOCOL]`
  thought, plain ASCII, ready to capture into Open Brain.
- `templates/bootstrap-snippet.md` — the per-project fill-in (four params + the
  two-tag + loop reminder).
