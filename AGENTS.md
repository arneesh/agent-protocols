# AGENTS.md

Guidance for AI coding agents working in this repository.

## What This Is

A collection of engineering protocols for AI coding agents. Each protocol is a structured workflow (SKILL.md) that agents follow to produce higher-quality output -- with specs, tests, reviews, and deployment gates enforced at every step.

## Project Layout

```
skills/{protocol-name}/SKILL.md    Core protocol definition
agents/{persona}.md                Specialist agent personas
references/{topic}.md              Supplementary checklists
hooks/                             Session lifecycle hooks
.claude/commands/{command}.md      Slash commands
docs/                              Setup guides
```

## Creating a New Protocol

### Directory Structure

```
skills/
  {protocol-name}/       # kebab-case directory name
    SKILL.md             # Required: protocol definition
    scripts/             # Optional: executable scripts
      {script-name}.sh   # Bash scripts (preferred)
```

### Naming Conventions

- **Protocol directory**: `kebab-case` (e.g., `code-review-and-quality`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `fetch-logs.sh`)

### SKILL.md Format

```markdown
---
name: {protocol-name}
description: {What it does. Use when [trigger conditions].}
---

# {Protocol Title}

## Overview
What this protocol does and why it matters.

## When to Use
- Triggering conditions
- When NOT to use

## Process
Step-by-step workflow with checkpoints.

## Common Rationalizations
| Rationalization | Reality |
|---|---|
| Excuse to skip a step | Why the excuse is wrong |

## Red Flags
- Signs the protocol is being violated

## Verification
- [ ] Evidence requirements
- [ ] Exit criteria
```

### Context Efficiency

Protocols load on-demand -- only name and description load at startup. The full SKILL.md loads when the agent decides it's relevant.

- Keep SKILL.md under 500 lines
- Write specific descriptions so agents know when to activate
- Use progressive disclosure -- reference supporting files that load only when needed
- Prefer scripts over inline code (script execution doesn't consume context)

### Script Requirements

- `#!/bin/bash` shebang
- `set -e` for fail-fast
- Status messages to stderr: `echo "Message" >&2`
- Machine-readable output (JSON) to stdout
- Cleanup trap for temp files

## Boundaries

- Always follow `docs/skill-anatomy.md` format for new protocols
- Never add protocols that are vague advice instead of actionable processes
- Never duplicate content between protocols -- reference and link instead
