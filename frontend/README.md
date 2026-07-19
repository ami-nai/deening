# Frontend - Prayer Tracker App

Production-ready Flutter application with Clean Architecture, SOLID principles, and modern state management.

## Quick Start

```bash
# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run
flutter run
```

## Architecture Overview

### Clean Architecture with Feature-First Structure
```
lib/
├── main.dart              # Entry point
├── app.dart               # App widget & routing
├── core/                  # Shared utilities
│   ├── api/              # Dio client & interceptors
│   ├── storage/          # Secure storage
│   ├── error/            # Failures & exceptions
│   ├── router/           # GoRouter config
│   └── utils/            # Helpers
├── features/             # Feature modules
│   ├── auth/             # Authentication
│   ├── prayers/          # Prayer tracking
│   └── stats/            # Statistics
└── shared/              # Shared widgets & theme
```

### Dependency Flow
**UI → Domain ← Data**
- UI imports Domain only
- Domain is framework-agnostic
- Data implements Domain contracts

## Tech Stack

- **State Management**: Flutter Riverpod (AsyncNotifier)
- **Navigation**: GoRouter with auth guard
- **HTTP**: Dio with custom interceptors
- **Secure Storage**: flutter_secure_storage
- **Serialization**: Freezed + JSON Serializable

## Key Features

### ✅ Complete Auth System
- Login/Register screens with validation
- JWT token management with auto-refresh
- Secure storage (EncryptedSharedPreferences-backed)
- Automatic logout on auth failure

### ✅ API Integration
- Dio singleton with base configuration
- Custom error interceptor (exception → failure mapping)
- Custom auth interceptor (JWT + token refresh)
- Network error handling

### ✅ Production-Ready UI
- Material 3 theming (light/dark)
- Custom reusable widgets
- Loading states & overlays
- Form validation

### ✅ Clean Code
- Proper separation of concerns
- SOLID principles followed
- Sealed classes for type safety
- Comprehensive error handling

## Installation

1. **Prerequisites**
   - Flutter 3.22+
   - Dart 3.2+

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Configuration

### API Base URL
Edit `lib/core/constants/api_constants.dart`:
```dart
static const String baseUrl = 'http://10.0.2.2:8000';  // Android emulator
// Use '192.x.x.x' for physical device
```

## API Endpoints

```
POST   /auth/register      { username, password, email? }
POST   /auth/login         { username, password }
POST   /auth/refresh       { refresh_token }
POST   /auth/recover       { email }
POST   /auth/reset         { email, code, new_password }
GET    /auth/me            → { id, username, has_recovery_email }
```

## Development

### Adding a New Feature
1. Create `features/[feature]/{data,domain,ui}` directories
2. Implement domain layer (entities, repositories, usecases)
3. Implement data layer (datasources, models, repository impl)
4. Implement UI layer (providers, screens, widgets)

### Code Generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Clean Build
```bash
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

## Project Structure

### Core Layer
- **api/**: Dio client setup, interceptors
- **storage/**: Secure token storage wrapper
- **error/**: Failure sealed class & exceptions
- **router/**: GoRouter with auth logic
- **constants/**: API endpoints, app constants
- **utils/**: Date utilities, helpers

### Auth Feature (Complete Example)
- **Domain**: Entities, abstract repository, usecases
- **Data**: Remote datasource, models (JSON), repository impl
- **UI**: Login/register screens, providers

### Shared
- **theme/**: Colors, text styles, Material theme
- **widgets/**: Reusable components

## Error Handling

### Failure Types
- `NetworkFailure`: Connection issues
- `ServerFailure`: 5xx errors
- `UnauthorizedFailure`: 401/403
- `ValidationFailure`: 400, invalid input
- `UnknownFailure`: Unexpected errors

### Interceptor Flow
```
Request → AuthInterceptor (add JWT) → ErrorInterceptor → API
Response → ErrorInterceptor (map errors) → AuthInterceptor (refresh if 401) → Riverpod
```

## File Naming

- Screens: `*_screen.dart`
- Widgets: `*_widget.dart`
- Providers: `*_provider.dart`
- Models: `*_model.dart`
- Entities: `*_entity.dart`
- Repositories: `*_repository.dart`
- Datasources: `*_datasource.dart`
- Usecases: `*_usecase.dart`

## Common Tasks

### Login User
```dart
await ref.read(authNotifierProvider.notifier).login(
  username: 'user',
  password: 'pass',
);
```

### Get Current User
```dart
final authState = ref.watch(authNotifierProvider);
authState.whenData((auth) => print(auth?.username));
```

### Logout
```dart
await ref.read(authNotifierProvider.notifier).logout();
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Build errors | `flutter clean && flutter pub get && flutter pub run build_runner build` |
| Port not found | Check backend running on port 8000 |
| Auth not working | Verify tokens in SecureStorage, check network URL |
| Widget not updating | Check Riverpod provider is being watched |

## Next Steps

1. Implement Prayers feature (log, track, view)
2. Implement Stats feature (user statistics)
3. Add UI tests
4. Implement push notifications
5. Add offline support (local caching)

---

**Created**: Production-ready Flutter template with Clean Architecture  
**Flutter Version**: 3.22+  
**State Management**: Riverpod  
**Backend**: http://10.0.2.2:8000 (Android) or 192.x.x.x (physical device)
