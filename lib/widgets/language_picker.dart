import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/localization/language_cubit.dart';
import '../core/localization/supported_locales.dart';
import '../generated/l10n/app_localizations.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: localizations.changeLanguage,
      onSelected: (String languageCode) {
        context.read<LanguageCubit>().changeLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) {
        return SupportedLocales.languages.map((LanguageModel language) {
          return PopupMenuItem<String>(
            value: language.code,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(language.flag, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(language.name),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final currentLanguage = SupportedLocales.getLanguageByCode(
          state.locale.languageCode,
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.language,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: currentLanguage.code,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: localizations.changeLanguage,
                  ),
                  items: SupportedLocales.languages.map((
                    LanguageModel language,
                  ) {
                    return DropdownMenuItem<String>(
                      value: language.code,
                      child: Row(
                        children: [
                          Text(
                            language.flag,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(language.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newLanguageCode) {
                    if (newLanguageCode != null) {
                      context.read<LanguageCubit>().changeLanguage(
                        newLanguageCode,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
