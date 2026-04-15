# Getting Started

Agent Protocols works with any AI coding agent that accepts Markdown instructions. Each protocol is a self-contained SKILL.md file that describes a specific engineering workflow. When loaded into an agent's context, the agent follows the workflow -- including verification steps, anti-patterns to avoid, and exit criteria.

Protocols are not reference docs. They are step-by-step processes the agent executes.

---

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/arneesh/agent-protocols
```

### 2. Choose a protocol

Browse the `skills/` directory. Each subdirectory contains a `SKILL.md` with:

- **When to Use** -- triggers that indicate this protocol applies
- **Process** -- step-by-step workflow
- **Common Rationalizations** -- excuses agents use to skip steps, with rebuttals
- **Red Flags** -- signs the protocol is being violated
- **Verification** -- evidence requirements for completion

### 3. Load it into your agent

**System prompt:** Paste the protocol content at the start of the session.

**Rules file:** Add protocol content to your project's rules file (`CLAUDE.md`, `.cursor/rules/`, etc.).

**Conversation:** Reference the protocol by name: "Follow the test-driven-development process for this change."

### 4. Use the meta-skill for discovery

Start with the `using-agent-skills` protocol loaded. It contains a flowchart that maps task types to the appropriate protocol.

---

## Recommended Configurations

### Minimal -- Start Here

Load four essential protocols into your rules file:

1. **karpathy-guidelines** -- Behavioral guardrails against common LLM coding mistakes
2. **spec-driven-development** -- Define what to build before writing code
3. **test-driven-development** -- Prove every change works
4. **code-review-and-quality** -- Verify quality before merge

These four cover the most critical quality gaps in AI-assisted development.

### Full Lifecycle

For comprehensive coverage, load protocols by phase:

```
Starting a project:  spec-driven-development -> planning-and-task-breakdown
Tech unknowns:       research-spike-and-poc (timeboxed, before heavy implementation)
During development:  incremental-implementation + test-driven-development
Locales:             internationalization-and-localization (with frontend-ui-engineering)
Before merge:        code-review-and-quality + security-and-hardening
Before deploy:       shipping-and-launch
After / during outage: incident-response-and-postmortems
```

### Context-Aware Loading

Don't load all protocols at once -- it wastes context. Load protocols relevant to the current task:

- Working on UI? Load `frontend-ui-engineering`
- Adding languages or locales? Load `internationalization-and-localization`
- Debugging? Load `debugging-and-error-recovery`
- Production incident? Load `incident-response-and-postmortems`
- Library or integration unknown? Load `research-spike-and-poc`
- Setting up CI? Load `ci-cd-and-automation`

---

## Using Agent Personas

The `agents/` directory contains specialist personas:

| Persona                      | Purpose                                                |
| ---------------------------- | ------------------------------------------------------ |
| `code-reviewer.md`           | Five-axis code review                                  |
| `test-engineer.md`           | Test strategy and coverage analysis                    |
| `security-auditor.md`        | Vulnerability detection and threat modeling            |
| `performance-engineer.md`    | Measurement-first performance and profiling            |
| `documentation-specialist.md`| ADRs, API docs, runbooks, doc accuracy                 |
| `release-engineer.md`        | CI/CD, deploy safety, rollback, launch readiness       |
| `accessibility-specialist.md`| WCAG-oriented UI audit, keyboard and screen reader     |
| `spec-analyst.md`            | PRD quality, scope, testable acceptance criteria       |

Load a persona when you need a specific engineering perspective. Example: "Review this change using the code-reviewer persona" and provide the agent definition.

---

## Using Commands

The `.claude/commands/` directory contains slash commands for Claude Code:

| Command          | Protocol Activated                                   |
| ---------------- | ---------------------------------------------------- |
| `/spec`          | spec-driven-development                              |
| `/plan`          | planning-and-task-breakdown                          |
| `/build`         | incremental-implementation + test-driven-development |
| `/test`          | test-driven-development                              |
| `/review`        | code-review-and-quality                              |
| `/code-simplify` | code-simplification                                  |
| `/ship`          | shipping-and-launch                                  |

---

## Using References

The `references/` directory contains supplementary checklists that protocols pull in on demand:

| Reference                    | Use With                 |
| ---------------------------- | ------------------------ |
| `testing-patterns.md`        | test-driven-development  |
| `performance-checklist.md`   | performance-optimization |
| `security-checklist.md`      | security-and-hardening   |
| `accessibility-checklist.md` | frontend-ui-engineering  |

---

## Working Artifacts

The `/spec` and `/plan` commands create working artifacts (`SPEC.md`, `tasks/plan.md`, `tasks/todo.md`). These are living documents:

- Keep them in version control during development as a shared source of truth.
- Update them when scope or decisions change.
- Delete them before merge or add the folder to `.gitignore` if your repo doesn't want them long-term.

---

## Tips

1. **Start with spec-driven-development** for any non-trivial work
2. **Always load test-driven-development** when writing code
3. **Don't skip verification steps** -- they are the entire point
4. **Load protocols selectively** -- more context is not always better
5. **Use personas for review** -- different perspectives catch different issues
