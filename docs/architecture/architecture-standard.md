# Architecture Standard

Status: Accepted for incremental adoption  
Date: 2026-08-11

## Goals

- Make dependency direction explicit and testable.
- Migrate one feature at a time without changing UI behavior.
- Keep business rules independent from Flutter, Dio, storage, and navigation.
- Use typed contracts instead of `dynamic`, raw maps, or transport responses.
- Avoid abstractions that do not protect a real boundary.

This is a feature-first, lightweight Clean Architecture. Existing features are
not required to move all at once. A feature must follow this standard after it
has been migrated.

## Source Layout

```text
lib/
|-- app/
|   |-- app.dart
|   |-- bootstrap.dart
|   |-- di/
|   `-- router/
|-- core/
|   |-- error/
|   |-- network/
|   |-- storage/
|   `-- utils/
`-- features/
    `-- feature_name/
        |-- data/
        |   |-- datasources/
        |   |-- models/
        |   `-- repositories/
        |-- domain/
        |   |-- entities/
        |   |-- repositories/
        |   `-- usecases/
        `-- presentation/
            |-- bloc/
            |-- pages/
            `-- widgets/
```

Empty directories must not be created. For example, a local-only feature does
not need a remote data source. A use case is optional when it only forwards one
repository call and adds no policy, reuse, validation, or orchestration.

## Dependency Rule

Dependencies point inward:

```text
presentation ----> domain <---- data
        app/DI composes concrete implementations
```

### Domain may import

- Dart SDK libraries.
- Other files in the same feature's domain layer.
- Small framework-independent core types such as `Result` and `Failure`.

Domain must not import Flutter, Dio, GetIt, storage plugins, data models,
presentation types, BLoCs, or another feature's implementation.

### Data may import

- Its own feature's domain contracts and entities.
- Its own models and data sources.
- Core network, storage, serialization, and error adapters.
- Third-party infrastructure packages such as Dio.

Data must not import presentation. A repository implementation converts DTOs
and infrastructure errors into domain entities and typed failures.

### Presentation may import

- Its own feature's domain layer.
- Flutter and presentation libraries.
- Shared UI primitives that contain no feature business logic.

Presentation must not import API services, Dio, database adapters, secure
storage, or data DTOs. A BLoC depends on a repository contract or a use case.

### Cross-feature dependencies

One feature must not import another feature's data or presentation layer.
Shared business concepts belong in an explicitly owned domain module. Workflow
composition belongs in a coordinator at the app layer. Temporary exceptions
must be recorded in the migration plan and removed when the owning feature is
migrated.

## Naming Rules

- Directories use plural nouns consistently: `datasources`, `repositories`,
  `entities`, `usecases`, `pages`, and `widgets`.
- Use `bloc`, not both `bloc` and `blocs`.
- Use `pages`, not both `screen` and `screens`.
- Interfaces use the business name: `AuthRepository`.
- Implementations use the `Impl` suffix: `AuthRepositoryImpl`.
- Transport objects use the `Dto` suffix: `AuthTokenDto`.
- Domain objects use no transport suffix: `AuthSession`.
- Events are past-tense user/system facts where practical; commands may use an
  imperative name when clearer.

Renaming is performed during feature migration, not as a repository-wide bulk
change.

## Result And Failure Contract

All expected operation outcomes cross domain boundaries as a typed result:

```dart
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);
  final Failure failure;
}

sealed class Failure {
  const Failure({required this.message, this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;
}
```

The concrete implementation may evolve in Core phase 2, but these rules are
fixed:

- No `dynamic` repository return types.
- No Dio `Response` outside data/core infrastructure.
- No throwing for expected API, validation, authorization, or connectivity
  failures after the repository boundary.
- Unexpected programmer errors are not silently converted into generic errors.
- User-facing localized messages are selected in presentation, not embedded in
  domain failures.

## DTO And Entity Rules

- DTOs own `fromJson` and `toJson`.
- Entities do not parse JSON and do not know API field names.
- DTO parsing validates required fields and tolerates only documented optional
  fields.
- Repository implementations map DTOs to entities.
- Raw `Map` values do not leave data sources.
- Feature-specific models must not live in `core/models`.

## Repository And Use Case Rules

A repository contract describes business capability, not HTTP endpoints:

```dart
abstract interface class AuthRepository {
  Future<Result<void>> requestOtp(PhoneNumber phoneNumber);
  Future<Result<AuthSession>> verifyOtp(VerifyOtpCommand command);
  Future<Result<void>> logout();
}
```

Add a use case when at least one condition applies:

- The operation contains business validation or policy.
- Multiple repositories must be coordinated.
- The operation is reused by multiple presentation entry points.
- Authorization, idempotency, or sequencing is part of the business operation.

Do not add a one-method class solely to satisfy a folder template.

## BLoC Rules

- A BLoC depends only on domain contracts/use cases.
- Events and states are immutable and typed.
- State contains durable screen data plus operation status; loading must not
  discard previously loaded data unless the product behavior requires it.
- Exceptions are handled at the repository boundary. BLoC maps `Failure` to a
  presentation state.
- Navigation, dialogs, and snack bars are reactions in the UI, not BLoC calls.
- Do not dispatch events from a widget `build` method.
- Avoid a catch-all `on<BaseEvent>` handler.
- Use event transformers only for an explicit concurrency requirement.

Global BLoCs are limited to process-wide state such as authentication/session.
Feature and page BLoCs are created at their route/page boundary and disposed
with that scope.

## Dependency Injection

- GetIt remains the composition mechanism during migration.
- Registrations are split by core and feature; a single growing `locator.dart`
  is not the target architecture.
- Data sources and repository implementations are not accessed through GetIt
  inside application classes. Dependencies are constructor-injected.
- Factory is used for BLoCs and mutable page-scoped objects.
- Lazy singleton is used only for stateless shared infrastructure or explicitly
  shared state.
- Tests instantiate classes directly and do not depend on the global locator.

## Routing

- Routes accept typed argument objects instead of positional `List` extras.
- Route builders do not perform business side effects.
- Page-scoped BLoCs are provided at the route boundary.
- Redirect decisions may read session state through an app-level coordinator.

## Testing Standard

Each migrated feature must include tests proportional to its behavior:

- DTO parsing tests for representative, optional, and malformed payloads.
- Repository tests for success and infrastructure-to-failure mapping.
- Use case tests when a use case contains policy.
- BLoC tests for initial, loading/success, and failure transitions.
- A focused widget test only when presentation wiring is changed.

Tests use fakes or mocks at architectural boundaries. They do not call live
services and do not use the global service locator.

## Definition Of Done For A Migrated Feature

- No imports that violate the dependency rule.
- No `dynamic` in public domain contracts.
- No raw JSON or Dio response outside data infrastructure.
- No data source dependency in BLoC.
- Duplicate legacy implementations removed after usage is migrated.
- New behavior is covered by focused tests.
- `flutter analyze` introduces no new findings.
- `flutter test` passes.
- Android debug build passes when platform integration changed.
- UI appearance and behavior remain unchanged unless separately approved.

## Explicit Non-goals

- No repository-wide UI refactor.
- No package upgrade campaign during architecture migration.
- No immediate rewrite of every feature.
- No forced use case, mapper, or interface for objects without a boundary.
- No code generation solely for architectural appearance.
