#!/bin/bash
# agent-protocols session start hook
# Injects the meta-skill discovery protocol into every new session

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$(dirname "$SCRIPT_DIR")/skills"
META_SKILL="$SKILLS_DIR/using-agent-skills/SKILL.md"

if [ -f "$META_SKILL" ]; then
  python3 - "$META_SKILL" <<'PY'
import json, sys
content = open(sys.argv[1], encoding="utf-8").read()
msg = "agent-protocols loaded. Use the skill discovery flowchart to find the right protocol for your task.\n\n" + content
print(json.dumps({"priority": "IMPORTANT", "message": msg}, indent=2))
PY
else
  echo '{"priority": "INFO", "message": "agent-protocols: meta-skill not found. Protocols may still be available individually."}'
fi
