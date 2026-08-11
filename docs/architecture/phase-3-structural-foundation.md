# Phase 3 Structural Feature Foundation

Date: 2026-08-11

## Scope

This phase prepares the repository for later repair, reconstruction, and
feature development. It changes structure and naming only. It does not rebuild
business rules, API contracts, BLoC behavior, navigation behavior, or UI.

## Delivered

- Defined bounded contexts and ownership for all current top-level features.
- Defined full-feature and presentation-only structural profiles.
- Defined safe per-feature naming migration rules.
- Normalized Auth as the reference physical structure.

## Auth Structure

```text
auth/
|-- data/
|   |-- datasources/
|   `-- repositories/
|-- domain/
|   `-- repositories/
`-- presentation/
    |-- bloc/
    `-- pages/
```

Changes are limited to directory/file naming, import paths, and the repository
implementation suffix (`Imp` to `Impl`). Existing class behavior is preserved.

## Deferred

- DTO and entity creation.
- Typed Auth repository results.
- Auth use cases.
- Logout and token-flow reconstruction.
- BLoC event/state redesign.
- Route scope changes.
- UI changes.

These are behavioral changes and belong to a later, separately approved phase.
