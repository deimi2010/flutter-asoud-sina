# Workspace Draft Contract

Status: Local-first frontend and backend synchronization implemented

## Save Strategy

- Every field change updates the in-memory BLoC state immediately.
- Local persistence is debounced by 400 milliseconds.
- Previous and next navigation never clears entered values.
- Reopening the form restores the last local step and values.
- Pressing next persists the completed section to the server-side market draft
  when reachable; local persistence remains the offline fallback.
- Publishing must be a separate operation from saving a draft.

## Backend Lifecycle

```text
POST /api/v1/owner/market/create/
PUT  /api/v1/owner/market/update/{market_id}/
POST /api/v1/owner/market/contact/create/
PUT  /api/v1/owner/market/contact/update/{market_id}/
POST /api/v1/owner/market/location/create/
PUT  /api/v1/owner/market/location/update/{market_id}/
POST /api/v1/owner/market/schedules/create/
POST /api/v1/user/payments/create/
POST /api/v1/owner/market/queue/{market_id}/
```

The create endpoint returns the market identifier used by subsequent sections.

## Publication State Machine

- An API-backed form starts as `draft`. Offline progress is `localOnly` and
  cannot be paid or queued.
- Contact and location must be synchronized before subscription payment.
- Verified payment sets `is_paid=true` and moves the market to `queue`.
- Admin `approve` moves `queue -> published`.
- Admin `reject` moves `queue -> not_published`.
- Admin `request_changes` moves `queue -> needs_editing`.
- A successful payment remains valid after rejection or requested changes, so
  correction and resubmission do not charge the owner again.
- `inactive` is an explicit owner/admin action, not a payment result.

## Working Hours

Each day supports at most two non-overlapping intervals:

```json
{
  "day": 1,
  "is_closed": false,
  "intervals": [
    {"interval_index": 1, "start": "08:00", "end": "12:00"},
    {"interval_index": 2, "start": "14:00", "end": "18:00"}
  ]
}
```

Rules:

- A complete interval requires both start and end.
- End must be later than start.
- The two intervals must not overlap.
- Clearing an interval removes it from the draft.
- A closed day has an empty interval list.
- The server must validate these rules again; frontend validation is not a
  security or data-integrity boundary.

## Business Identifier

The business identifier is intended for a subdomain label. The frontend
accepts 5 to 63 lowercase Latin letters, digits, and hyphens. It must start
with a letter, end with a letter or digit, and cannot contain consecutive
hyphens. Uniqueness must be checked and enforced by the backend.
