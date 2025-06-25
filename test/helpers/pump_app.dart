import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base_project/generated/l10n/app_localizations.dart';

/// Extension to help with widget testing setup
extension WidgetTesterExtensions on WidgetTester {
  /// Pumps a widget wrapped in MaterialApp with localization support
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('vi')],
      ),
    );
  }

  /// Pumps a widget with BlocProvider support
  Future<void> pumpBlocProvider<B extends BlocBase<S>, S>(
    B bloc,
    Widget child,
  ) {
    return pumpApp(BlocProvider<B>.value(value: bloc, child: child));
  }

  /// Pumps a widget with multiple BlocProviders
  Future<void> pumpMultiBlocProvider(
    List<BlocProvider> providers,
    Widget child,
  ) {
    return pumpApp(MultiBlocProvider(providers: providers, child: child));
  }

  /// Pumps a full app scaffold for testing
  Future<void> pumpAppScaffold(Widget body) {
    return pumpApp(
      Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: body,
      ),
    );
  }
}

/// Custom finders for testing
final class CustomFinders {
  /// Finds a widget by type
  static Finder byWidgetType<T extends Widget>() => find.byType(T);

  /// Finds text containing substring
  static Finder textContaining(String substring) =>
      find.textContaining(substring);

  /// Finds a loading indicator
  static Finder loadingIndicator() => find.byType(CircularProgressIndicator);

  /// Finds an error message
  static Finder errorMessage(String message) => find.text('Error: $message');

  /// Finds widget by key
  static Finder byTestKey(String key) => find.byKey(Key(key));
}
