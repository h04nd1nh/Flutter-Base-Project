import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'flavors.dart';
import 'widgets/flavor_banner.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'core/localization/language_cubit.dart';
import 'core/localization/supported_locales.dart';
import 'generated/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LanguageCubit>()..loadLanguage(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp.router(
            title: F.title,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            routerConfig: AppRouter.router,
            locale: languageState.locale,
            supportedLocales: SupportedLocales.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return FlavorBanner(child: child!);
            },
          );
        },
      ),
    );
  }
}
