# Changelog

## 2026-06-16

- Document Billy's `dev`→`main` gitflow and the `catchup` aliases in the methodology
  `CLAUDE.md` so every project inherits them: long-running `dev` → PR to `main` →
  `git catchup` to advance local `dev` (with `catchup-hard` as the squash/rebase
  fallback), the reproducible `git config --global` install snippet, and the
  knowledge-vs-config rule — an agent that finds the aliases missing offers to install
  them, never silently (Billy owns all git config). `install.sh` now detects each alias
  and prints the install command for any that's missing without touching git config.

## 2026-06-13

- Add `/design-handoff` skill — a reusable cross-surface Claude Design ↔ Claude Code
  collaboration protocol. Splits the SIGNAL (Open Brain thoughts, polled + confirm-receipt)
  from the PAYLOAD (the git repo's versioned HANDOFF.md + built result), with a dual home so
  Claude Design (no local filesystem) can learn the protocol from one canonical Open Brain
  reference thought tagged `[DESIGN-CODE-PROTOCOL]`. New projects bootstrap from a slug plus
  four parameters. Decision record: `specs/SPEC-2026-06-13-design-code-handoff.md` (this
  repo's first framed artifact). Linked by `install.sh`.
