# Phase 6: Business Feature Structure

Status: In progress
Date: 2026-08-11

## Scope Of This Increment

This increment normalizes the physical structure of the coupled
create-workspace and vendor features without changing runtime behavior or UI.

The target directory names are:

- `data/datasources`
- `data/models`
- `data/repositories`
- `domain/repositories`
- `presentation/pages`
- `presentation/pages/tabs` for create-workspace tab content
- `presentation/bloc`
- `presentation/widgets`

## Preserved Boundaries

The current ownership boundaries are intentionally unchanged:

- `WorkspaceBloc` remains under the vendor feature.
- Vendor models used by create-workspace remain under vendor.
- Create-workspace repository contracts continue to expose legacy data models.
- Existing cross-feature presentation imports remain in place.
- Class names, routes, dependency registrations, and widget behavior remain
  unchanged.

These are known architecture violations, but correcting them requires typed
domain contracts, ownership decisions, and behavioral tests. That work belongs
to behavioral reconstruction rather than structural normalization.

## Verification

- No legacy singular directory imports remain for create-workspace or vendor.
- Flutter analyze introduces no new findings relative to the baseline.
- Existing tests pass.
- Android debug build succeeds.
