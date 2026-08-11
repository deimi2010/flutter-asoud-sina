# Feature Catalog And Ownership

Date: 2026-08-11

## Purpose

This catalog defines application capabilities and ownership before behavior is
rebuilt. It is a structural map, not a request to combine feature directories
or rewrite business logic.

Top-level feature directories remain flat under `lib/features` during the
incremental migration. Bounded contexts describe ownership and dependency
decisions; they are not additional path nesting.

## Bounded Contexts

### Identity And Session

Owns authentication state, session lifecycle, and application entry decisions.

- `auth`
- `splash`

Profile data is not owned by Auth. Auth may expose a user/session identifier;
profile details belong to Account.

### Workspace And Merchant Operations

Owns merchant workspaces, vendor dashboards, work configuration, and merchant
operational categories.

- `create_workspace`
- `vendor`
- `job_managment` (target name: `job_management`)
- `store_setting_screens` (target name: `store_settings`)
- `panel`

Workspace is the owner of workspace identity and location. Market must consume
a domain contract instead of importing Workspace presentation BLoCs.

### Catalog And Storefront

Owns stores, products, themes, product publication, and storefront browsing.

- `market`
- `product`

The current separation between Market and Product must be clarified during
their later migration. Until then, neither feature's data models move to Core.

### Commerce And Finance

Owns cart/order lifecycle, payment processing, wallet balances, and saved bank
card presentation.

- `cart`
- `payment`
- `wallet`
- `bank_card`

Payment and Wallet are separate capabilities even if the same checkout flow
coordinates them. Checkout orchestration belongs in an app/domain coordinator,
not in either feature's presentation layer.

### Engagement And Requests

Owns customer-vendor communication, service requests, reservations, inquiries,
and notifications.

- `inquiry`
- `reservation`
- `service`
- `chat`
- `notification`

These features may share identifiers and small domain value objects, but they
must not share presentation BLoCs.

### Account And Customer Utilities

Owns customer/profile data and user-managed utility content.

- `customer`
- `profile`
- `bookmarks`
- `business_card`

Bookmarks reference catalog identifiers but do not own product/store models.
Business cards reference account/workspace identifiers but remain independently
owned.

## Structural Profiles

### Full feature

Use when a capability has external data or business rules:

```text
feature_name/
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

Only directories containing files are created.

### Presentation-only feature

Use for a local/static capability with no data boundary or business policy:

```text
feature_name/
`-- presentation/
    |-- bloc/       # only when state management is required
    |-- pages/
    `-- widgets/
```

Data and domain directories are added only when a real boundary appears.

### Shared capability

Code moves to Core only if it is feature-agnostic infrastructure. A domain
concept used by multiple features requires an explicit owner or a dedicated
domain module; reuse alone is not enough to place it in Core.

## Naming Migration

Target names:

- `data_source` -> `datasources`
- `repository` -> `repositories`
- `model` -> `models`
- `blocs` -> `bloc`
- `screen` or `screens` -> `pages`
- `widget` -> `widgets`
- `*_repository_imp.dart` -> `*_repository_impl.dart`
- `job_managment` -> `job_management`
- `store_setting_screens` -> `store_settings`

Naming changes are applied one feature at a time with analyzer and test checks.
Repository-wide moves are prohibited because current cross-feature imports make
them unnecessarily risky.

## Dependency Policy Between Contexts

- A feature may import another feature's public domain contract only when the
  dependency is explicit and unavoidable.
- A feature must not import another feature's data or presentation layer.
- Cross-context workflows are composed in the app layer.
- Shared UI primitives remain in Core only when they contain no feature policy.
- Existing violations remain migration tasks and are not legitimized by this
  catalog.

## Structural Migration Order

1. Auth reference structure.
2. Small presentation-only features.
3. Cart, Payment, and Wallet duplicate structure cleanup.
4. Workspace and Vendor ownership cleanup.
5. Market and Product ownership cleanup.
6. Engagement features.
7. Account utilities.

Behavioral reconstruction, repository contracts, use cases, and UI changes are
separate future work unless explicitly approved.
