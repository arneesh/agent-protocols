# Protocol Anatomy

The structure and format of protocol files. Use this as a guide when creating new protocols or understanding existing ones.

## File Location

Every protocol lives in its own directory under `skills/`:

```
skills/
  protocol-name/
    SKILL.md              Required: the protocol definition
    supporting-file.md    Optional: reference material loaded on demand
```

## SKILL.md Format

### Frontmatter (Required)

```yaml
---
name: protocol-name-with-hyphens
description: Brief statement of what the protocol does. Use when [specific trigger conditions].
---
```

**Rules:**
- `name`: Lowercase, hyphen-separated. Must match the directory name.
- `description`: Starts with what the protocol does (third person), followed by trigger conditions. Maximum 1024 characters.

**Why this matters:** Agents discover protocols by reading descriptions. The description is injected into the system prompt, so it must tell the agent both what the protocol provides and when to activate it. Do not summarize the workflow in the description -- if it contains process steps, the agent may follow the summary instead of reading the full protocol.

### Standard Sections

```markdown
# Protocol Title

## Overview
One-two sentences explaining what this protocol does and why it matters.

## When to Use
- Triggering conditions (symptoms, task types)
- When NOT to use (exclusions)

## Process
The main workflow, broken into numbered steps or phases.
Include code examples where they help.
Use ASCII flowcharts where decision points exist.

## Common Rationalizations
| Rationalization | Reality |
|---|---|
| Excuse agents use to skip steps | Why the excuse is wrong |

## Red Flags
- Signs the protocol is being violated
- Patterns to watch for during review

## Verification
After completing the process, confirm:
- [ ] Evidence requirement 1
- [ ] Evidence requirement 2
```

## Section Purposes

### Overview
The elevator pitch. What does this protocol do, and why should an agent follow it?

### When to Use
Helps agents decide if this protocol applies. Include positive triggers ("Use when X") and negative exclusions ("NOT for Y").

### Process
The heart of the protocol. Step-by-step workflow the agent follows. Must be specific and actionable.

- Good: "Run `npm test` and verify all tests pass"
- Bad: "Make sure the tests work"

### Common Rationalizations
The most distinctive feature. These are excuses agents use to skip important steps, paired with rebuttals. They prevent the agent from rationalizing its way out of the process.

Every time an agent says "I'll add tests later" or "This is too simple for a spec" -- those go here with factual counter-arguments.

### Red Flags
Observable signs the protocol is being violated. Useful during review and self-monitoring.

### Verification
Exit criteria. A checklist the agent uses to confirm the process is complete. Every checkbox must be verifiable with evidence -- test output, build result, screenshot, runtime data.

## Supporting Files

Create supporting files only when:
- Reference material exceeds 100 lines
- Code tools or scripts are needed
- Checklists are long enough to justify separation

Keep patterns and principles inline when under 50 lines.

## Writing Principles

1. **Process over knowledge.** Protocols are workflows, not reference docs. Steps, not facts.
2. **Specific over general.** "Run `npm test`" beats "verify the tests".
3. **Evidence over assumption.** Every verification checkbox requires proof.
4. **Anti-rationalization.** Every skip-worthy step needs a counter-argument.
5. **Progressive disclosure.** SKILL.md is the entry point. Supporting files load only when needed.
6. **Token-conscious.** Every section must justify its inclusion. If removing it wouldn't change agent behavior, remove it.

## Naming Conventions

- Protocol directories: `lowercase-hyphen-separated`
- Protocol files: `SKILL.md` (always uppercase)
- Supporting files: `lowercase-hyphen-separated.md`
- References: stored in `references/` at the project root, not inside protocol directories

## Cross-Protocol References

Reference other protocols by name:

```markdown
Follow the `test-driven-development` protocol for writing tests.
If the build breaks, use the `debugging-and-error-recovery` protocol.
```

Don't duplicate content between protocols -- reference and link instead.
