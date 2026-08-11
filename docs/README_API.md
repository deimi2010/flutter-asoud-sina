API setup

Run with a specific API base URL:

```
flutter run --dart-define=API_BASE_URL=https://asoud.ir/api/v1/
```

Build with a specific API base URL:

```
flutter build apk --dart-define=API_BASE_URL=https://asoud.ir/api/v1/
```

Defaults to https://asoud.ir/api/v1/ if not provided.

Updated endpoints:

- Advertisements: `api/v1/advertisements/`
- Product comments list: `api/v1/user/comment/comments/product/{productId}/`
- Inquiry create: `api/v1/user/inquiries/create/` with required `expiry`

