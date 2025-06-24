import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../flavors.dart';
import '../../../../widgets/language_picker.dart';
import '../bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(const GetCurrentUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${F.title} - ${localizations.home}'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: const [LanguagePicker()],
        ),
        body: const _HomeContent(),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.appInformation,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(localizations.flavor, F.name),
                  _InfoRow(localizations.title, F.title),
                  _InfoRow(localizations.apiBaseUrl, F.apiBaseUrl),
                  _InfoRow(
                    localizations.isDevelopment,
                    F.isDevelopment.toString(),
                  ),
                  _InfoRow(localizations.isStaging, F.isStaging.toString()),
                  _InfoRow(
                    localizations.isProduction,
                    F.isProduction.toString(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const LanguageDropdown(),
          const SizedBox(height: 24),
          Text(
            localizations.userInformation,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoRow('ID', state.user.id.toString()),
                          _InfoRow(localizations.name, state.user.name),
                          _InfoRow(localizations.email, state.user.email),
                          if (state.user.avatar != null)
                            _InfoRow(localizations.avatar, state.user.avatar!),
                          _InfoRow(
                            localizations.createdAt,
                            state.user.createdAt.toString(),
                          ),
                          _InfoRow(
                            localizations.updatedAt,
                            state.user.updatedAt.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is UserError) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            '${localizations.error}: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context.read<UserBloc>().add(
                              const GetCurrentUserEvent(),
                            ),
                            child: Text(localizations.retry),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
