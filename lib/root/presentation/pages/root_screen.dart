import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../features/user/presentation/pages/home_page.dart';
import '../../../features/user/presentation/pages/profile_page.dart';
import '../cubit/root_cubit.dart';
import '../widgets/bottom_nav_item.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  static const List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RootCubit>(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(index: state.currentIndex, children: _pages),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, RootState state) {
    final localizations = AppLocalizations.of(context);
    final rootCubit = context.read<RootCubit>();

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: state.currentIndex,
      onTap: rootCubit.changeTab,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: BottomNavConfig.items.map((item) {
        final isSelected =
            BottomNavConfig.items.indexOf(item) == state.currentIndex;
        return BottomNavigationBarItem(
          icon: Icon(isSelected ? item.activeIcon : item.icon),
          label: _getLocalizedLabel(localizations, item.labelKey),
        );
      }).toList(),
    );
  }

  String _getLocalizedLabel(AppLocalizations localizations, String key) {
    switch (key) {
      case 'home':
        return localizations.home;
      case 'explore':
        return localizations.explore;
      case 'favorites':
        return localizations.favorites;
      case 'profile':
        return localizations.profile;
      default:
        return key;
    }
  }
}

// Placeholder pages - bạn có thể tạo các feature riêng cho chúng
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.explore),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.explore, size: 100, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              localizations.explore,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.explorePageDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.favorites),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 100, color: Colors.red),
            const SizedBox(height: 24),
            Text(
              localizations.favorites,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.favoritesPageDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
