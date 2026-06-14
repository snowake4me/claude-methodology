# Design↔Code Handoff — bootstrap for <PROJECT NAME>

Fill the four parameters; nothing else about the protocol changes. The full
protocol lives in the `/design-handoff` skill (Code side) and the
`[DESIGN-CODE-PROTOCOL]` Open Brain reference thought (Design side).

## Parameters

| Param | Value |
|---|---|
| **slug** | `<SLUG>` → handoff tag `[<SLUG>-HANDOFF]` |
| **repo** | `<git repo / URL>` |
| **HANDOFF.md path** | `<e.g. design/HANDOFF.md>` |
| **design-system ref** | `<the design source of truth Design grades against>` |

## Wire-up checklist

- [ ] A single `[DESIGN-CODE-PROTOCOL]` reference thought exists in Open Brain
      (capture `ob-reference-thought.txt` once if it doesn't).
- [ ] `<HANDOFF.md path>` exists (or will be created by Design's first spec).
- [ ] Claude Design is pointed at `<repo>` and told to search
      `[DESIGN-CODE-PROTOCOL]` first, then `[<SLUG>-HANDOFF]`, every session.
- [ ] Claude Code has the `/design-handoff` skill installed (via `install.sh`).

## The loop (reminder)

1. Design authors `HANDOFF.md` → posts `[<SLUG>-HANDOFF]` `sender:design → code, type:task` + pointer.
2. Code polls, reads, **acks** → `sender:code → design, type:ack` + build order. No build before the ack.
3. Code builds → result lands **in-repo**.
4. Design inspects vs the design-system ref → grades → posts `type:accept` or `type:task`. Loop to 2.

Keep all Open Brain thoughts **plain ASCII** (no backticks/code-fences/special
chars — the WAF blocks them).
