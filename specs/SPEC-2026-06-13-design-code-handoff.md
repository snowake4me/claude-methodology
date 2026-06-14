# Spec: Design↔Code Handoff — a reusable cross-surface collaboration protocol

**ID:** SPEC-2026-06-13-design-code-handoff
**Status:** decided
**Related:** first framed artifact in this repo · spawns `skills/design-handoff/`

---

## Objective

Extract SWEAT's proven, ad-hoc Claude Design ↔ Claude Code handoff into a
project-agnostic methodology artifact, so any future Design↔Code collaboration
inherits the protocol instead of re-deriving it.

## Context

SWEAT runs a working Design↔Code loop in production today (protocol ~v0.3→v0.4),
but it was built ad hoc and lives nowhere reusable. The pattern is general; the
implementation is not. Two facts force the design:

1. **It's cross-surface.** Claude Code reads local `~/.claude` steering. Claude
   Design (browser/server-side, Anthropic Labs) has **no local filesystem** — it
   cannot read steering docs. But Design *can* reach Open Brain and *can* read
   GitHub repos it's pointed at (with Billy's browser-session privileges).
2. **The substrates have different shapes.** Open Brain is small, cross-client,
   polled. A git repo is large, versioned, durable.

## Options considered

The forks below are why this is a SPEC, not a TASK. Each was resolved with Billy
during framing.

### Fork 1 — Name
- **A. Design↔Code Handoff** *(chosen)* — centers the two participants;
  transport-agnostic, survives if the substrates change.
- **B. Cross-Surface Handoff** — centers the architectural insight; more abstract,
  vaguer about who.
- **C. OB Handoff** — centers the transport; couples the name to one substrate.

### Fork 2 — How Claude Design finds the protocol each session
- **A. One reserved global tag** *(chosen)* — a single canonical reference thought
  tagged with a fixed reserved string; Design searches it first thing each session.
  One known address. Per-project handoff thoughts are separate runtime traffic.
- **B. Per-project tag only** — protocol rules inline in each project's stream;
  re-derives the protocol per project (violates the acceptance seed).
- **C. Repo pointer + thought ID** — OB holds only a pointer to the repo; adds a
  hop and depends on Design's repo access every session.

### Fork 3 — How much to genericize now
- **A. Stable spine only** *(chosen)* — extract the project-agnostic invariants;
  leave message-field schema and HANDOFF.md versioning as per-project fill-in,
  promotable into the global once SWEAT's v0.4+ proves them stable.
- **B. Full standardization** — fix the OB message schema and a HANDOFF.md
  versioning scheme now; freezes a still-maturing protocol.
- **C. Spine + standard schema, versioning loose** — middle ground.

### Fork 4 — Code-side deliverable form
- **A. New `/design-handoff` skill** *(chosen)* — symlinked by `install.sh` like
  `/frame` and `/retro`; discoverable, versioned, fits the existing pattern.
- **B. Passive CLAUDE.md block** — always-on, but adds standing weight to every
  project, even those with no Design collaboration.
- **C. Standalone doc + pointer** — lightest, but not auto-inherited as behavior.

### Fork 5 — Dogfooding
- **Chosen: yes.** This SPEC is the methodology repo's first framed artifact and
  adopts its own `specs/` lifecycle.

## Decision

**Split the SIGNAL from the PAYLOAD, and give the protocol a DUAL HOME.**

- **Open Brain = signaling bus.** Handoffs are OB thoughts tagged
  `[SLUG-HANDOFF]`, with sender→recipient and a type, polled by both sides via
  `search_thoughts`, with **explicit confirm-receipt**. Small, cross-client, fast.
- **The git repo = artifact store.** A versioned `HANDOFF.md` carries the detailed
  build spec; the built result lands back in-repo so Design can re-read it and
  grade fidelity. Large, versioned, durable.
- **Dual home, because cross-surface.** The protocol lives (a) as the
  `/design-handoff` skill every Code project inherits, and (b) as **one canonical
  Open Brain reference thought** tagged `[DESIGN-CODE-PROTOCOL]` — which is
  effectively the "global system instruction" Claude Design otherwise lacks.

The signal/payload split is the durable, project-agnostic residue. Everything that
varies collapses to **four per-project parameters**: project **slug** (→ handoff
tag), the **repo**, the **HANDOFF.md path**, and the **design-system reference**.

Reserved tag settled as `[DESIGN-CODE-PROTOCOL]` — distinguishes the durable
*protocol* reference from per-project *handoff* traffic (`[SLUG-HANDOFF]`).

## Consequences

**Commits us to:**
- A new `skills/design-handoff/` skill (spine + OB reference template + bootstrap
  snippet), linked by `install.sh`.
- Treating `[DESIGN-CODE-PROTOCOL]` and `[SLUG-HANDOFF]` as reserved OB tag
  conventions, documented identically on both surfaces.
- Plain-ASCII OB templates (no backticks/code-fences/special chars — OB's
  Cloudflare WAF blocks them).

**Rules out (for now):**
- Standardizing the OB message schema or HANDOFF.md versioning — per-project until
  proven, then promoted. The spine gives that later refinement a fixed place to attach.
- Auto-publishing the canonical OB thought — we template it; Billy captures it.

**Follow-on work:** build the skill, the OB reference template, the bootstrap
snippet; update `install.sh`, `README.md`, `CHANGELOG.md`. (Executed in the same
session as this SPEC — see CHANGELOG.)

## Open questions

None blocking. As SWEAT reaches v0.4+, revisit whether the message-field schema and
a HANDOFF.md versioning scheme have stabilized enough to promote into the spine.

---
**Created:** 2026-06-13 · **Last updated:** 2026-06-13
