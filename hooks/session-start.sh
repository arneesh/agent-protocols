#!/bin/bash
# agent-protocols session start hook
# Injects the meta-skill discovery protocol into every new session

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(dirname "$SCRIPT_DIR")/skills"
META_SKILL="$SKILLS_DIR/using-agent-skills/SKILL.md"

if [ -f "$META_SKILL" ]; then
  CONTENT=$(cat "$META_SKILL")
  cat <<EOF
{
  "priority": "IMPORTANT",
  "message": "agent-protocols loaded. Use the skill discovery flowchart to find the right protocol for your task.\n\n$CONTENT"
}
EOF
else
  echo '{"priority": "INFO", "message": "agent-protocols: meta-skill not found. Protocols may still be available individually."}'
fi
