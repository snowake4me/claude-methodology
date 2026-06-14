#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="$HOME/.claude"
SKILLS="$CLAUDE_HOME/skills"
GLOBAL="$CLAUDE_HOME/CLAUDE.md"
BEGIN="<!-- BEGIN claude-methodology (managed by install.sh — edit the repo, not here) -->"
END="<!-- END claude-methodology -->"

mkdir -p "$SKILLS"

link_skill() {
  name="$1"
  src="$REPO/skills/$name"
  dst="$SKILLS/$name"
  if [ -L "$dst" ]; then rm "$dst"; fi
  if [ -e "$dst" ]; then
    bak="$dst.bak-$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$bak"
    echo "  backed up existing $dst -> $bak"
  fi
  ln -s "$src" "$dst"
  echo "  linked $dst -> $src"
}

echo "Linking skills:"
link_skill frame
link_skill retro
link_skill design-handoff

echo "Refreshing managed methodology block in $GLOBAL:"
mkdir -p "$CLAUDE_HOME"
if [ -f "$GLOBAL" ]; then
  awk -v b="$BEGIN" -v e="$END" '
    $0==b {skip=1}
    skip!=1 {print}
    $0==e {skip=0}
  ' "$GLOBAL" > "$GLOBAL.tmp"
  mv "$GLOBAL.tmp" "$GLOBAL"
else
  : > "$GLOBAL"
fi
{
  printf '\n%s\n\n' "$BEGIN"
  cat "$REPO/CLAUDE.md"
  printf '\n%s\n' "$END"
} >> "$GLOBAL"
echo "  updated (existing global instructions preserved above/below the block)"

echo "done."
