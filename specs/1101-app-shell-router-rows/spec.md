# Feature Specification: App Shell Router Support and In-Theme Row Primitive

**Feature Branch**: `1101-app-shell-router-rows`

**Created**: 2026-11-19

**Status**: Draft

**Input**: User description: "add router support to the app shell and a Material-free row primitive for surfaces that paint their own background"

## Context

This is a **package-level** specification for `zuraffa_ui`. It exists because three
defects surfaced in a consuming application and all three trace back to this package,
not to the consumer. The dependency rule applies: a defect in a shared package is
fixed in the package, once.

What a consuming application experienced:

1. Tapping a debug menu opened a dev sheet whose rows raised
   `ListTile background color or ink splashes may be invisible` — on every row, on
   every open.
2. Tapping two menu entries crashed with `No ScaffoldMessenger widget found`, and four
   further surfaces in the same shipped flows would crash identically when reached.
3. The application has no way to adopt the certified app shell: it routes with a
   router configuration object, and the shell accepts only a home widget plus named
   routes.

All three are reproducible in a stock consumer. None require the consumer to have
misused the package.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Router-based application adopts the certified shell (Priority: P1)

An application that navigates through a declarative router configuration wants to use
the certified app shell, so it gets the shell's scaffold messenger, violation chrome,
and contract auditing instead of hand-rolling them.

**Why this priority**: This is the blocking defect. The shell already solves the
missing-messenger problem, but a router application physically cannot use it. Every
router application is therefore forced to hand-roll a messenger — which is precisely
the workaround that produced the consumer's five crashing surfaces.

**Independent Test**: Mount the shell with a router configuration in a widget test,
resolve the scaffold messenger from a widget inside a route, and confirm the
resolution succeeds. No home widget or named routes are supplied.

**Acceptance Scenarios**:

1. **Given** an application supplies a router configuration, **When** it mounts the
   certified shell, **Then** the shell builds successfully and renders the router's
   initial route.
2. **Given** the shell is mounted with a router configuration, **When** a widget inside
   a route asks for the scaffold messenger, **Then** a messenger is found and a
   notification can be shown without an error.
3. **Given** the shell is mounted with a router configuration, **When** a route is
   pushed and a widget in the pushed route asks for the scaffold messenger, **Then**
   the same messenger is still found.
4. **Given** an application supplies a home widget and named routes (the existing
   contract), **When** it mounts the shell, **Then** behaviour is unchanged.

---

### User Story 2 - Rows render correctly inside surfaces that paint a background (Priority: P1)

A developer building a sheet or dialog wants to lay out tappable rows. The surface
paints its own background, border, and shadow. Today the only row primitive available
is a Material one, which trips a framework assertion in exactly that situation.

**Why this priority**: Equal-highest. This is the defect that produced the visible
error flood. A row primitive that paints nothing on the Material layer removes the
entire failure mode rather than asking every consumer to add a workaround widget.

**Independent Test**: Build a row inside a dialog surface that has a background colour
and confirm no framework error is reported, hover and press states still change
appearance, and a tap fires the row's callback.

**Acceptance Scenarios**:

1. **Given** a dialog or sheet surface that paints a background, **When** a row is
   placed inside it, **Then** no framework error about background or ink splashes is
   reported.
2. **Given** a row inside such a surface, **When** the pointer hovers over it, **Then**
   its background changes to the hover treatment and reverts on exit.
3. **Given** a row inside such a surface, **When** the user presses and releases it,
   **Then** the press treatment is applied and the row's callback fires.
4. **Given** a disabled row, **When** the user taps it, **Then** no callback fires and
   the row is not focusable.
5. **Given** rows are available in outline, muted, and primary treatments, **When** a
   consumer chooses one, **Then** that treatment's background, border, and text colours
   come from the active theme and follow light/dark switching.
6. **Given** the package's existing theme object, **When** a consumer supplies only
   their own colours, **Then** row styling merges over the package defaults without
   dropping unspecified properties.

---

### User Story 3 - Notification banners match the application's theme (Priority: P2)

An application shows a short confirmation or error banner. The banner should look like
the rest of the application, not like an unrelated dark slab.

**Why this priority**: Secondary — it does not crash, but it makes every notification in
every consumer look foreign, which is the defect the consumer would otherwise paper
over by replacing all their notification call sites.

**Independent Test**: Mount the shell with a light theme, show a notification from a
route, and confirm its background and text colours come from the shell's own theme
rather than from an unrelated default.

**Acceptance Scenarios**:

1. **Given** the shell is mounted with a light theme, **When** a notification is shown,
   **Then** its foreground and background colours derive from that theme.
2. **Given** the shell is mounted with a dark theme, **When** a notification is shown,
   **Then** its colours derive from the dark theme.
3. **Given** a consumer supplies their own notification styling to the shell, **When**
   a notification is shown, **Then** the consumer's styling wins over the default.

---

### User Story 4 - Consumers can obtain the packaged row primitive (Priority: P1)

A consumer wants to use the row primitive rather than build their own. Today the
primitive exists in the source tree but is not obtainable from a published release.

**Why this priority**: Highest gating factor — without a release, none of the other
work reaches a consumer. A fix consumers cannot install is not a fix.

**Independent Test**: From a clean consumer project, add the released package version
and confirm the row primitive and its companion pieces are importable, and that the
`Zfa`-prefixed aliases for them resolve.

**Acceptance Scenarios**:

1. **Given** a clean consumer project, **When** it depends on the released version,
   **Then** the row primitive, its media/content/title/description/actions/header/footer
   companions, and its variants are importable.
2. **Given** the aliased surface, **When** the consumer imports it, **Then** every
   row-related alias resolves to the corresponding primitive.
3. **Given** the release, **When** the changelog is read, **Then** the new surface is
   documented and the release is versioned per the package's existing convention.

---

### Edge Cases

- **Router configuration supplied together with a home widget**: the shell must reject
  the combination clearly rather than silently picking one.
- **Router configuration supplied with no initial route resolvable**: the shell must
  surface the router's own error, not a shell-specific one.
- **Rows used outside a surface that paints a background** (e.g. directly on the page):
  must render without requiring any wrapper.
- **Rows inside a surface that has no background colour**: must not assume one exists.
- **Row text over a themed background in dark mode**: title, description, and media
  colours must remain legible; contrast must follow the theme, not a hardcoded value.
- **A row with no callback**: must render as non-interactive and must not show hover or
  press treatments.
- **Notification shown before any route is mounted**: must not throw.
- **Consumer overrides only part of the row styling**: unspecified properties must fall
  back to package defaults rather than becoming absent.

## Requirements *(mandatory)*

### Functional Requirements

**Router-capable shell**

- **FR-001**: The app shell MUST offer a construction path that accepts a router
  configuration, so an application that navigates declaratively can mount it.
- **FR-002**: The router construction path MUST accept the same router inputs the
  package's underlying app accepts, so an application does not lose capability by
  adopting the shell.
- **FR-003**: The router construction path MUST mount a scaffold messenger above the
  navigator, so a widget in any route can resolve one.
- **FR-004**: The router construction path MUST preserve the shell's existing
  behaviours — violation chrome, contract auditing, and the consumer's own builder
  hook.
- **FR-005**: The shell MUST reject supplying both a router configuration and a home
  widget, with a message naming the conflict.
- **FR-006**: The existing home-widget and named-routes construction MUST keep its
  current behaviour unchanged.

**Rows for self-painting surfaces**

- **FR-007**: The package MUST provide a row primitive that renders and responds to
  input without requiring a Material ancestor.
- **FR-008**: The row primitive MUST provide hover and press treatments that are
  visibly distinct from its resting state.
- **FR-009**: The row primitive MUST NOT apply any treatment when it has no callback.
- **FR-010**: The row primitive MUST NOT be focusable when disabled.
- **FR-011**: The row primitive MUST offer at least the primary, outline, and muted
  treatments, and two sizes.
- **FR-012**: The row primitive MUST offer companion pieces for leading media, content,
  title, description, trailing actions, header, and footer, composable in the
  shadcn-style manner.
- **FR-013**: All row colours, borders, radii, and padding MUST resolve from the active
  theme and MUST follow light/dark switching.
- **FR-014**: The row's theme object MUST merge consumer-supplied values over package
  defaults, so partial overrides are valid.
- **FR-015**: Every row-related type MUST have a corresponding `Zfa`-prefixed alias on
  the aliased surface.

**Notification theming**

- **FR-016**: The theme the shell exposes to Material-layer widgets MUST define
  notification banner styling derived from the shell's own colour scheme.
- **FR-017**: That notification styling MUST follow light/dark switching.
- **FR-018**: A consumer-supplied override MUST take precedence over the default.

**Release**

- **FR-019**: The release MUST be versioned according to the package's existing
  convention for new surface area.
- **FR-020**: The changelog MUST describe the router-capable shell, the row surface, and
  the notification theming.
- **FR-021**: The router-capable shell and the row surface MUST be covered by tests that
  fail if the capability is removed.

### Key Entities

- **App Shell**: The certified top-level application widget. Owns theme resolution,
  violation chrome, contract auditing, and the messenger above the navigator. Gains a
  second construction path for declarative routing.
- **Row Primitive**: A themed horizontal row: leading media, content (title and
  description), and trailing actions. Resting / hovered / pressed states, enabled and
  disabled, three treatments, two sizes.
- **Row Theme**: The styling object for the row primitive, merged over package defaults,
  resolved per brightness.
- **Router Construction Path**: The shell's declarative-navigation entry point; carries
  the router inputs through to the underlying app and mounts the messenger on the
  builder hook.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A router-based application can mount the certified shell with no
  hand-rolled messenger; zero `No ScaffoldMessenger widget found` errors occur in a
  walkthrough of that application's notification surfaces.
- **SC-002**: Rows placed in a surface that paints a background produce zero framework
  errors, where the current primitive produces one error per row per open.
- **SC-003**: A consumer project installs the released version and imports the row
  surface on the first attempt, with zero unresolved names.
- **SC-004**: Notification banners adopt the application's theme in both light and dark
  modes, verified by colour sources rather than by eye.
- **SC-005**: Existing consumers of the home-widget construction path observe zero
  behavioural change — the entire pre-existing test suite passes unmodified.
- **SC-006**: Every capability above has a test that fails when the capability is
  removed.

## Assumptions

- **Router inputs mirror the underlying app.** The shell's router path accepts the same
  router parameters the package's app already accepts, rather than inventing a subset.
  This is why FR-002 is phrased as "the same inputs" — an application should lose
  nothing by adopting the shell.
- **The row primitive already exists in the source tree.** The row surface, its
  companions, its theme, and its aliases are present but unreleased, so this feature is
  primarily a release plus the verification that the existing surface satisfies
  FR-007–FR-015. Where a requirement is not met, it is implemented rather than the
  requirement being relaxed.
- **The Material layer stays.** Consumers still use Material-layer widgets extensively;
  the feature themes that layer rather than removing it. A full migration away from it
  is explicitly out of scope.
- **The underlying app has no messenger.** The shell supplies it. This assumption is the
  reason the router path must mount the messenger on the builder hook rather than
  relying on the app to provide one.
- **New surface area is a minor version bump** under the package's existing convention.
  No consumer is required to change existing calls.
- **Consumers migrate deliberately.** Replacing the current row primitive with the new
  one is the consumer's choice and is out of scope here; this feature only makes it
  possible.
