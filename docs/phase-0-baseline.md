# Phase 0 Baseline

Date: 2026-08-11

## Scope

This phase establishes a reproducible engineering baseline. It does not change
the visual design or intentionally change user-facing behavior.

## Toolchain

- Flutter: 3.29.3 (stable)
- Dart: 3.7.2
- Android build: debug APK

The machine-level `PUB_HOSTED_URL` points to `https://pub.flutter-io.cn`, which
was unreachable during this phase. Dependency commands succeeded when scoped to
the official `https://pub.dev` host. No permanent machine setting was changed.

## Verification

### Dependency resolution

`pub get` succeeds. `http` and the Flutter SDK test package are now declared
directly because application and test sources import them directly.

### Static analysis

`flutter analyze --no-pub` completes with no compile errors. It reports 160
existing warning/info findings. These are retained as the cleanup baseline;
visual deprecations and UI-only lint findings are outside the current scope.

### Tests

`flutter test --no-pub` passes:

- 1 test passed
- 0 tests failed

The invalid Flutter template counter test was replaced with an application-root
construction test. This is only a baseline guard and is not sufficient feature
coverage.

### Android build

`flutter build apk --debug --no-pub` succeeds and produces:

`build/app/outputs/flutter-apk/app-debug.apk`

The first build installed the required Android NDK and CMake packages. Kotlin
daemon connection warnings occurred, after which Gradle used its fallback
compiler path and completed the APK successfully.

## Compile Blockers Fixed

- Added the missing Flutter test SDK dependency.
- Declared the directly imported `http` package.
- Added the missing Flutter foundation import in the auth API service.
- Corrected invalid nested product-image parsing in the cart model.
- Converted raw API maps to `Map<String, dynamic>` before model parsing in cart,
  wallet, and payment BLoCs.

## Deferred Findings

- 160 analyzer warning/info findings.
- Only one minimal baseline test exists.
- Several BLoCs depend directly on API services.
- Duplicate BLoC directories and implementations still exist.
- Kotlin daemon stability should be rechecked on the next clean Android build.
- Dependency upgrades are intentionally deferred until architecture boundaries
  and regression tests are in place.
