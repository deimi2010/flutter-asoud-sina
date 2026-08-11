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

## Phase 3: Auth Reference Feature

Auth is the reference migration because its boundaries are understandable and
it exercises network, secure storage, session state, and routing.

Deliverables:

- Auth DTOs and domain entities.
- Typed repository contract and implementation.
- Request OTP, verify OTP, and logout behavior.
- Auth BLoC using only domain dependencies.
- Correct awaited token persistence.
- Repository and BLoC tests.

Exit criteria:

- Auth presentation has no data-layer imports.
- Logout is implemented and tested.
- No `dynamic` in the auth domain API.
- Login and OTP UI remain visually unchanged.

## Phase 4: Navigation And Scope

Deliverables:

- Typed route arguments.
- Removal of route-builder side effects.
- Route/page-scoped feature BLoCs.
- Only true application state remains globally provided.

## Phase 5: Transaction Features

Migration order:

1. Cart
2. Payment
3. Wallet

Reasons:

- They currently compile but bypass repository boundaries.
- Cart and payment contain duplicate BLoCs.
- Their state transitions affect money/order workflows and require tests before
  further feature work.

## Phase 6: Business Features

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
