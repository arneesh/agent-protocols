# Cursor Setup

## Setup Options

### Option 1: Rules Directory (Recommended)

Cursor supports a `.cursor/rules/` directory for project-specific rules:

```bash
mkdir -p .cursor/rules

cp /path/to/agent-protocols/skills/test-driven-development/SKILL.md .cursor/rules/test-driven-development.md
cp /path/to/agent-protocols/skills/code-review-and-quality/SKILL.md .cursor/rules/code-review-and-quality.md
cp /path/to/agent-protocols/skills/incremental-implementation/SKILL.md .cursor/rules/incremental-implementation.md
```

Rules in this directory are automatically loaded into Cursor's context.

### Option 2: .cursorrules File

Create a `.cursorrules` file in your project root with essential protocols inlined:

```bash
cat /path/to/agent-protocols/skills/test-driven-development/SKILL.md > .cursorrules
echo "\n---\n" >> .cursorrules
cat /path/to/agent-protocols/skills/code-review-and-quality/SKILL.md >> .cursorrules
```

### Option 3: Notepads

Cursor's Notepads feature stores reusable context. Create a notepad per protocol:

1. Open Cursor Settings, go to Notepads
2. Create a new notepad (e.g., "Test-Driven Development")
3. Paste the content of the relevant `SKILL.md`
4. Reference it in chat with `@notepad`

## Recommended Configuration

### Always-On Protocols

Add these to `.cursor/rules/`:

1. `test-driven-development.md` -- TDD workflow and Prove-It pattern
2. `code-review-and-quality.md` -- Five-axis review
3. `incremental-implementation.md` -- Build in small verifiable slices

### On-Demand Protocols (Notepads)

Create notepads for protocols you use contextually:

- Spec Development: `spec-driven-development/SKILL.md`
- Frontend UI: `frontend-ui-engineering/SKILL.md`
- Security: `security-and-hardening/SKILL.md`
- Performance: `performance-optimization/SKILL.md`

## Usage Tips

1. **Don't load all protocols at once** -- Cursor has context limits. Load 2-3 as rules and keep others as notepads.
2. **Reference protocols explicitly** -- Tell Cursor "Follow the test-driven-development rules for this change."
3. **Use personas for review** -- Copy `agents/code-reviewer.md` content and ask Cursor to "review this diff using this code review framework."
4. **Load references on demand** -- When working on performance, reference the performance checklist notepad.
