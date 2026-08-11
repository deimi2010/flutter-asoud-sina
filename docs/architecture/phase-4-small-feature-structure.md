# Phase 4 Small Feature Structure

Date: 2026-08-11

## Scope

This phase normalizes small presentation-focused features and removes proven
unused duplicate skeletons. It does not redesign state, routes, APIs, or UI.

## Normalized Features

- Splash: `presentation/bloc` and `presentation/pages`
- Chat: `presentation/bloc` and `presentation/pages`
- Notification: `presentation/bloc`
- Reservation: `presentation/bloc`
- Service: `presentation/bloc`
- Profile: `presentation/pages` and `presentation/widgets`
- Bookmarks: `presentation/pages`

Class names remain unchanged to avoid changing public presentation contracts.

## Duplicate Cleanup

Removed the unused skeleton implementations from:

- `cart/presentation/blocs`
- `payment/blocs`

Repository-wide import search confirmed that neither directory was imported or
registered. The active implementations remain in:

- `cart/presentation/bloc`
- `payment/presentation/bloc`

## Deferred

- Active Cart and Payment directory normalization.
- BLoC behavior and state redesign.
- Route and BLoC scope changes.
- Business logic reconstruction.
- UI changes.
