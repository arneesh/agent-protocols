#!/bin/bash
# agent-protocols session start hook
# Injects the meta-skill discovery protocol into every new session.
#
# Claude Code adds a SessionStart hook's stdout to the model's context in one of
# two forms: a JSON object carrying hookSpecificOutput.additionalContext, or plain
# text. jq is used to build the JSON so the skill file is escaped correctly; when
# jq is not installed the plain-text form is printed instead.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(dirname "$SCRIPT_DIR")/skills"
META_SKILL="$SKILLS_DIR/using-agent-skills/SKILL.md"
INTRO="agent-protocols loaded. Use the skill discovery flowchart to find the right protocol for your task."

if [ ! -f "$META_SKILL" ]; then
  printf '%s\n' "agent-protocols: meta-skill not found. Protocols may still be available individually."
  exit 0
fi

if command -v jq >/dev/null 2>&1; then
  jq -cn --arg intro "$INTRO" --rawfile skill "$META_SKILL" \
    '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: ($intro + "\n\n" + $skill)}}'
else
  printf '%s\n\n' "$INTRO"
  cat "$META_SKILL"
fi
