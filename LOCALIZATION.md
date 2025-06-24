# Flutter Base Project - Internationalization (i18n)

## Overview

This project supports multiple languages using Flutter's built-in internationalization features. Currently supports Vietnamese (default) and English.

## Supported Languages

| Language | Code | Country | Flag |
|----------|------|---------|------|
| Vietnamese | vi | VN | 🇻🇳 |
| English | en | US | 🇺🇸 |

## File Structure

```
lib/
├── l10n/                          # Translation files
│   ├── app_en.arb                 # English translations  
│   └── app_vi.arb                 # Vietnamese translations
├── generated/l10n/                # Generated localization files
│   ├── app_localizations.dart     # Main localization class
│   ├── app_localizations_en.dart  # English implementation
│   └── app_localizations_vi.dart  # Vietnamese implementation
├── core/localization/             # Localization management
│   ├── language_cubit.dart        # Language state management
│   └── supported_locales.dart     # Supported languages config
└── widgets/
    └── language_picker.dart       # Language selection widgets
```

## Configuration Files

### 1. l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/generated/l10n
nullable-getter: false
```

### 2. pubspec.yaml
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2

flutter:
  generate: true
```

## Usage

### 1. In Widget
```dart
import 'package:flutter/material.dart';
import 'generated/l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
      ),
      body: Text(l10n.appInformation),
    );
  }
}
```

### 2. Change Language
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/localization/language_cubit.dart';

// Switch to English
context.read<LanguageCubit>().changeLanguage('en');

// Switch to Vietnamese  
context.read<LanguageCubit>().changeLanguage('vi');
```

### 3. Language Picker Widget
```dart
import 'widgets/language_picker.dart';

// AppBar action
AppBar(
  actions: [
    LanguagePicker(),
  ],
)

// Dropdown form
LanguageDropdown()
```

## Adding New Translations

### 1. Add to English (app_en.arb)
```json
{
  "@@locale": "en",
  "newKey": "English Text",
  "@newKey": {
    "description": "Description of the new key"
  }
}
```

### 2. Add to Vietnamese (app_vi.arb)
```json
{
  "@@locale": "vi",
  "newKey": "Văn bản tiếng Việt"
}
```

### 3. Generate Code
```bash
flutter gen-l10n
```

### 4. Use in Code
```dart
Text(AppLocalizations.of(context)!.newKey)
```

## Adding New Language

### 1. Create ARB File
Create `lib/l10n/app_[locale].arb` with all translations:
```json
{
  "@@locale": "ja",
  "appName": "フラッター基本プロジェクト",
  "home": "ホーム",
  ...
}
```

### 2. Update Supported Locales
Add to `lib/core/localization/supported_locales.dart`:
```dart
class SupportedLocales {
  static const List<Locale> supportedLocales = [
    Locale('vi', 'VN'),
    Locale('en', 'US'),
    Locale('ja', 'JP'), // Add new locale
  ];

  static const List<LanguageModel> languages = [
    LanguageModel(code: 'vi', name: 'Tiếng Việt', flag: '🇻🇳'),
    LanguageModel(code: 'en', name: 'English', flag: '🇺🇸'),
    LanguageModel(code: 'ja', name: '日本語', flag: '🇯🇵'), // Add new language
  ];
}
```

### 3. Generate Code
```bash
flutter gen-l10n
```

## String Interpolation

### With Parameters
```json
{
  "welcome": "Welcome {name}!",
  "@welcome": {
    "description": "Welcome message",
    "placeholders": {
      "name": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

### Usage
```dart
Text(AppLocalizations.of(context)!.welcome('John'))
```

## Pluralization

### ARB File
```json
{
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Number of items",
    "placeholders": {
      "count": {
        "type": "int",
        "format": "compact"
      }
    }
  }
}
```

### Usage
```dart
Text(AppLocalizations.of(context)!.itemCount(5))
```

## Date/Time Formatting

### ARB File
```json
{
  "lastUpdated": "Last updated: {date}",
  "@lastUpdated": {
    "description": "Last update time",
    "placeholders": {
      "date": {
        "type": "DateTime",
        "format": "yMd"
      }
    }
  }
}
```

### Usage
```dart
Text(AppLocalizations.of(context)!.lastUpdated(DateTime.now()))
```

## Best Practices

### 1. Key Naming
- Use camelCase: `appInformation`, `userProfile`
- Be descriptive: `loginButtonText` vs `btn1`
- Group related keys: `error.network`, `error.validation`

### 2. Description
Always add descriptions for context:
```json
{
  "@key": {
    "description": "Clear description of when/where this is used"
  }
}
```

### 3. Consistency
- Keep string order consistent across ARB files
- Use same key names in all languages
- Maintain consistent terminology

### 4. Testing
Test all languages in the app:
```bash
# Test with English
flutter run --flavor develop -t lib/main_develop.dart

# Change language in app and verify all texts display correctly
```

## Commands Summary

```bash
# Generate localization files
flutter gen-l10n

# Run with specific language (device setting)
flutter run --locale vi
flutter run --locale en

# Build with all languages
flutter build apk --flavor production -t lib/main_production.dart
```

## Current Translations

The project includes translations for:
- App names and titles
- Navigation labels
- Form labels and buttons
- Error messages
- User interface elements
- Feature-specific text

All strings are fully translated between Vietnamese and English. 