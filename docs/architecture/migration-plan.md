# Architecture Migration Plan

Date: 2026-08-11

This document maps the accepted architecture standard to the current codebase.
It is updated after each migrated feature.

## Current Baseline

- 22 top-level feature directories.
- 8 features currently expose `data`, `domain`, and `presentation` directories.
- Directory naming is mixed: `bloc`/`blocs`, `screen`/`screens`, and
  `widget`/`widgets`.
- Cart and payment contain duplicate BLoC implementations.
- Several presentation BLoCs depend directly on API services.
- Domain contracts in market and create-workspace import data or presentation.
- Cross-feature presentation dependencies are common around market, vendor,
  workspace, and create-workspace.
- The phase 0 analyzer baseline is 160 warning/info findings and zero compile
  errors.

## Migration Principles

1. Preserve user-visible behavior and UI.
2. Migrate vertical feature slices, not folders in isolation.
3. Add characterization tests before changing risky behavior.
4. Keep every commit buildable where practical.
5. Remove legacy code only after all call sites use the replacement.
6. Do not combine architecture migration with dependency upgrades.
7. Complete structural normalization before behavioral feature reconstruction.

## Phase 2: Core Infrastructure

Status: Completed on 2026-08-11. See `phase-2-core.md`.

Deliverables:

- Typed `Result<T>` and failure hierarchy.
- Network exception-to-failure mapping.
- Token storage contract and secure implementation.
- Auth, refresh-token, and safe logging interceptors.
- Feature-level DI registration modules.
- Environment/configuration boundary.
- Core unit tests.

Exit criteria:

- Core types contain no feature imports.
- Sensitive request/response data is not logged by default.
- Expected network failures are typed.
- Existing endpoints remain behavior-compatible.

## Phase 3: Structural Feature Foundation

Status: Completed on 2026-08-11. Behavioral reconstruction is explicitly
deferred. See `phase-3-structural-foundation.md`.

Auth is the reference for directory and naming normalization because its file
set is small and its boundaries are understandable.

Deliverables:

- Application capability catalog and ownership map.
- Structural profiles for full and presentation-only features.
- Standard Auth directory names: `datasources`, `repositories`, `bloc`, and
  `pages`.
- Import updates with no intentional logic or UI changes.
- Analyze, test, and Android build verification.

Exit criteria:

- Auth has one consistent physical structure.
- No legacy Auth paths remain imported.
- Existing behavior and public contracts are preserved.
- Login and OTP UI remain visually unchanged.

Typed Auth contracts, DTO/entity separation, logout reconstruction, and Auth
BLoC behavior tests are deferred to the later behavioral reconstruction phase.

## Phase 4: Small Feature Structural Normalization

Status: Completed on 2026-08-11. See
`phase-4-small-feature-structure.md`.

Deliverables:

- Normalize Splash, Chat, Notification, Reservation, Service, Profile, and
  Bookmarks under `presentation`.
- Standardize `bloc`, `pages`, and `widgets` directory names.
- Remove unused duplicate Cart and Payment BLoC skeletons.
- Preserve active Cart and Payment implementations.
- Update imports without changing application behavior.

## Phase 5: Transaction Feature Structure

Status: Completed on 2026-08-11. See
`phase-5-transaction-feature-structure.md`.

Migration order:

1. Cart
2. Payment
3. Wallet

Structural deliverables:

- Normalize `datasources`, `repositories`, and `pages` paths where present.
- Preserve active BLoCs, models, services, and page class names.
- Remove the zero-byte unused Cart repository implementation placeholder.
- Update imports without changing transaction behavior.

Repository boundaries, typed results, and transaction state tests remain part
of future behavioral reconstruction.

## Phase 6: Business Features

Status: In progress. Structural normalization only; behavioral and ownership
changes remain deferred.

Provisional migration order:

1. Create workspace
2. Vendor/workspace
3. Market
4. Product
5. Job management
6. Inquiry
7. Customer/profile
8. Remaining small features

Market, vendor, and create-workspace form a coupled cluster. Their domain
ownership must be decided before moving shared models. Files are not moved into
Core merely because multiple features currently import them.

The first Phase 6 increment normalizes the physical directory names in
create-workspace and vendor. Existing cross-feature dependencies and the
workspace BLoC location under vendor are preserved until ownership boundaries
can be migrated with characterization tests.

## Future: Behavioral Feature Reconstruction

After structural normalization is complete, features may be rebuilt one at a
time. The first behavioral reference feature remains Auth, followed by
transaction and business features. That work requires separate approval and is
not implied by moving or renaming files.

Navigation improvements such as typed route arguments, removal of route-builder
side effects, and page-scoped BLoCs are also deferred because they can change
runtime behavior and lifecycle.

## Known Violations To Remove During Migration

### Presentation to data

- Cart, payment, and wallet BLoCs import API services directly.
- Customer, create-workspace, vendor, market, job-management, and inquiry
  presentation import data models directly.

### Domain outward dependencies

- `market/domain/repository/product_repository.dart` imports presentation.
- `create_workspace/domain` imports data models from its own and vendor
  features.

### Data to presentation

- Market data source and repository import add-product BLoC types.

### Cross-feature presentation coupling

- Market screens/widgets consume vendor/workspace BLoCs.
- Customer, bookmarks, and business-card screens consume workspace BLoC.
- Job-management presentation consumes create-workspace BLoC.

These are migration inputs, not reasons for a single large rewrite.

## Per-feature Checklist

- [ ] Capture current behavior with focused tests.
- [ ] Identify the feature owner for every entity.
- [ ] Define typed domain repository operations.
- [ ] Isolate DTO parsing in data models.
- [ ] Map infrastructure errors to typed failures.
- [ ] Move BLoC dependencies to domain contracts/use cases.
- [ ] Scope BLoC at app, feature, or page boundary intentionally.
- [ ] Migrate all callers.
- [ ] Remove duplicate/legacy implementation.
- [ ] Run analyze and tests.
- [ ] Update this migration plan.

## Decision Log

- 2026-08-11: Adopt feature-first lightweight Clean Architecture.
- 2026-08-11: Keep GetIt during migration; split registration by feature.
- 2026-08-11: Keep BLoC as the presentation state-management standard.
- 2026-08-11: Make use cases conditional rather than mandatory wrappers.
- 2026-08-11: Keep UI changes outside architecture phases unless separately
  approved.
