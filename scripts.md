# Flutter Flavors Scripts

## Run Commands

### Development
```bash
flutter run --flavor develop -t lib/main_develop.dart
```

### Staging
```bash
flutter run --flavor staging -t lib/main_staging.dart
```

### Production
```bash
flutter run --flavor production -t lib/main_production.dart
```

## Build Commands

### Android APK

#### Development
```bash
flutter build apk --flavor develop -t lib/main_develop.dart
```

#### Staging
```bash
flutter build apk --flavor staging -t lib/main_staging.dart
```

#### Production
```bash
flutter build apk --flavor production -t lib/main_production.dart
```

### Android App Bundle

#### Development
```bash
flutter build appbundle --flavor develop -t lib/main_develop.dart
```

#### Staging
```bash
flutter build appbundle --flavor staging -t lib/main_staging.dart
```

#### Production
```bash
flutter build appbundle --flavor production -t lib/main_production.dart
```

### iOS

#### Development
```bash
flutter build ios --flavor develop -t lib/main_develop.dart
```

#### Staging
```bash
flutter build ios --flavor staging -t lib/main_staging.dart
```

#### Production
```bash
flutter build ios --flavor production -t lib/main_production.dart
```

## VSCode Debug Configurations

Bạn có thể sử dụng các cấu hình debug sau trong VSCode:
- Flutter (Develop) - Debug mode cho development
- Flutter (Staging) - Debug mode cho staging
- Flutter (Production) - Debug mode cho production
- Flutter (Profile - *) - Profile mode cho performance testing
- Flutter (Release - *) - Release mode cho testing production builds

## Environment Variables

Trong code, bạn có thể sử dụng:
```dart
import 'flavors.dart';

// Kiểm tra flavor hiện tại
if (F.isDevelopment) {
  // Development specific code
}

// Lấy API base URL
String apiUrl = F.apiBaseUrl;

// Lấy app title
String appTitle = F.title;
``` 