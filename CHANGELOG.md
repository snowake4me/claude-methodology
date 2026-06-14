# Changelog

## 2026-06-13

- Add `/design-handoff` skill — a reusable cross-surface Claude Design ↔ Claude Code
  collaboration protocol. Splits the SIGNAL (Open Brain thoughts, polled + confirm-receipt)
  from the PAYLOAD (the git repo's versioned HANDOFF.md + built result), with a dual home so
  Claude Design (no local filesystem) can learn the protocol from one canonical Open Brain
  reference thought tagged `[DESIGN-CODE-PROTOCOL]`. New projects bootstrap from a slug plus
  four parameters. Decision record: `specs/SPEC-2026-06-13-design-code-handoff.md` (this
  repo's first framed artifact). Linked by `install.sh`.
