# Phase 5 Transaction Feature Structure

Date: 2026-08-11

## Scope

This phase normalizes active Cart, Payment, and Wallet paths. It does not change
checkout behavior, API calls, models, BLoC states/events, or UI.

## Cart

```text
cart/
|-- data/
|   `-- datasources/
|-- domain/
|   |-- models/
|   `-- repositories/
`-- presentation/
    |-- bloc/
    |-- pages/
    `-- widgets/
```

The zero-byte and unused `cart_repository_imp.dart` placeholder was removed.
The existing repository contract remains for later ownership review.

## Payment

```text
payment/
|-- data/datasources/
|-- domain/models/
`-- presentation/
    |-- bloc/
    `-- pages/
```

## Wallet

```text
wallet/
|-- data/datasources/
|-- domain/models/
`-- presentation/
    |-- bloc/
    `-- pages/
```

## Deferred

- Repository implementation and contract reconstruction.
- Removal of direct API service dependencies from BLoCs.
- Typed transaction results and failures.
- Cart state preservation fixes.
- Payment and wallet behavior tests.
- Route/BLoC scope changes.
- UI changes.
