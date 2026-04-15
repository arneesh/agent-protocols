# Agent Protocols

Structured engineering protocols for AI coding agents. Each protocol encodes a specific engineering discipline -- spec writing, testing, code review, deployment -- as a repeatable workflow with verification gates.

## Project Structure

```
skills/            25 engineering protocols (SKILL.md per directory)
agents/            Specialist personas (code-reviewer, test-engineer, security-auditor, performance-engineer, documentation-specialist, release-engineer, accessibility-specialist, spec-analyst)
hooks/             Session lifecycle hooks
.claude/commands/  7 slash commands (/spec, /plan, /build, /test, /review, /code-simplify, /ship)
references/        4 supplementary checklists (testing, performance, security, accessibility)
docs/              Setup guides
```

## Protocols by Phase

**Define:** idea-refine, spec-driven-development
**Plan:** planning-and-task-breakdown, research-spike-and-poc
**Build:** incremental-implementation, test-driven-development, context-engineering, source-driven-development, frontend-ui-engineering, api-and-interface-design, internationalization-and-localization
**Verify:** browser-testing-with-devtools, debugging-and-error-recovery
**Review:** code-review-and-quality, code-simplification, karpathy-guidelines, security-and-hardening, performance-optimization
**Ship:** git-workflow-and-versioning, ci-cd-and-automation, deprecation-and-migration, documentation-and-adrs, shipping-and-launch
**Operate:** incident-response-and-postmortems

## Conventions

- Every protocol lives in `skills/<name>/SKILL.md`
- YAML frontmatter with `name` and `description` fields
- Description starts with what the protocol does (third person), followed by trigger conditions ("Use when...")
- Every protocol has: Overview, When to Use, Process, Common Rationalizations, Red Flags, Verification
- References are in `references/`, not inside skill directories
- Supporting files only created when content exceeds 100 lines

## Validation

- Check that all SKILL.md files have valid YAML frontmatter with `name` and `description`
- Verify cross-references between protocols resolve to existing files

## Boundaries

- Always: Follow the skill-anatomy.md format for new protocols
- Never: Add protocols that are vague advice instead of actionable processes
- Never: Duplicate content between protocols -- reference other protocols instead
