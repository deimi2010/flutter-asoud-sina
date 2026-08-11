# Phase 2 Core Infrastructure

Date: 2026-08-11

## Scope

This phase introduces the target Core boundaries while preserving the public
interfaces used by legacy features. It does not change UI code.

## Delivered

### Typed operation outcomes

- `Result<T>` with explicit success and failure branches.
- Typed application failures for network, server, authorization, validation,
  storage, and unexpected conditions.
- Unit tests for result folding and network failure mapping.

### Configuration

- `AppConfig` owns environment-derived application configuration.
- The API base URL remains configurable through `--dart-define=API_BASE_URL=...`.
- Core DI creates the HTTP client from `AppConfig`.

### Token storage

- `TokenStorage` defines the access/refresh token boundary.
- `SecureTokenStorage` implements it with Flutter Secure Storage.
- Missing, empty, and legacy `ND` token values are normalized to `null` at the
  new boundary.
- The static `SecureStorage` helper remains temporarily for unmigrated callers.

### Network

- `AuthInterceptor` adds bearer tokens without overwriting an explicit header.
- `TokenRefreshInterceptor` refreshes once after a 401 and retries the original
  request.
- Concurrent 401 responses share one active refresh operation.
- Failed refresh clears both tokens.
- `SafeLogInterceptor` logs only method, URL, status, and Dio error type in
  debug mode. Request/response bodies and headers are not logged.
- `DioClient` now accepts every HTTP `2xx` status, including `204`.
- Existing `DioClient` request methods remain compatible with legacy services.

### Dependency injection

Registrations are split into:

- Core
- Auth
- Workspace
- Market
- Commerce
- Independent presentation BLoCs

`locator.dart` is now only the composition entry point. Existing factory and
singleton lifetimes are preserved.

## Verification

- Analyzer target: zero compile errors and no findings above the phase 0
  baseline of 160 warning/info findings.
- Unit and baseline tests must pass.
- DI composition is tested on a reset locator.
- Android debug APK must build before this phase is committed.

## Deliberately Deferred

- Legacy `apiStatus`, `Success`, and `Failure` remain until feature repositories
  migrate to `Result<T>`.
- Static `SecureStorage` call sites remain until Auth and legacy screens are
  migrated.
- Cart, wallet, and payment BLoCs still depend on API services; their repository
  migrations belong to the transaction-feature phase.
- User-facing localization of failures belongs to presentation migration.
- Existing analyzer findings unrelated to Core remain at their baseline.
