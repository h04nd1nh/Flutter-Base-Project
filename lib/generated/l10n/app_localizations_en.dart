// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Flutter Base Project';

  @override
  String get appNameDev => 'Flutter Base Project Dev';

  @override
  String get appNameStaging => 'Flutter Base Project Staging';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get appInformation => 'App Information';

  @override
  String get userInformation => 'User Information';

  @override
  String get flavor => 'Flavor';

  @override
  String get title => 'Title';

  @override
  String get apiBaseUrl => 'API Base URL';

  @override
  String get isDevelopment => 'Is Development';

  @override
  String get isStaging => 'Is Staging';

  @override
  String get isProduction => 'Is Production';

  @override
  String get id => 'ID';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get avatar => 'Avatar';

  @override
  String get createdAt => 'Created At';

  @override
  String get updatedAt => 'Updated At';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get goToProfile => 'Go to Profile';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get profilePageDescription =>
      'This is where user profile information would be displayed.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Favorites';

  @override
  String get explorePageDescription =>
      'Discover interesting things around you.';

  @override
  String get favoritesPageDescription => 'Your favorite items are stored here.';
}
