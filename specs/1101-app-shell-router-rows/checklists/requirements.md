# Specification Quality Checklist: App Shell Router Support and In-Theme Row Primitive

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: 2026-11-19
**Feature**: [spec.md](../spec.md)

## Content Quality

- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

## Requirement Completeness

- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous
- [x] Success criteria are measurable
- [x] Success criteria are technology-agnostic (no implementation details)
- [x] All acceptance scenarios are defined
- [x] Edge cases are identified
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

## Feature Readiness

- [x] All functional requirements have clear acceptance criteria
- [x] User scenarios cover primary flows
- [x] Feature meets measurable outcomes defined in Success Criteria
- [x] No implementation details leak into specification

## Notes

- Items marked incomplete require spec updates before `/skill:speckit-clarify` or `/skill:speckit-plan`

### Validation record

**Iteration 1** — all 16 items pass.

Deliberate decisions, recorded so a reviewer can challenge them:

- **Terms are descriptive, not named.** The spec says "the certified app shell",
  "row primitive", "router configuration", "notification banner" rather than
  `ZuraffaApp`, `ShadItem`, `routerConfig`, `SnackBar`. A reader who has never seen
  the package can follow it, and the plan is free to choose the exact surface.
- **Citations of observed behaviour stay.** The `ListTile background color…` and
  `No ScaffoldMessenger widget found` strings are quoted because they are the
  evidence that the defects are real, not because the solution depends on them.
- **FR-002 says "the same inputs", not a list.** Enumerating the router parameters
  would be an implementation detail; requiring parity is the actual contract.
- **Assumptions carry the load-bearing decisions** — router parity, the row
  primitive already existing in the tree, the Material layer staying, and a minor
  version bump. Each is a default a reviewer may overrule rather than a silent gap.
- **No [NEEDS CLARIFICATION] markers.** Every gap had a defensible default from the
  evidence gathered before writing: the consumer's five crashing surfaces settle the
  messenger scope, the framework's own error hint settles the row requirement, and
  the package's release convention settles versioning.
