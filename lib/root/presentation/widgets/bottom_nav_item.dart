import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String labelKey;

  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.labelKey,
  });
}

class BottomNavConfig {
  static const List<BottomNavItem> items = [
    BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      labelKey: 'home',
    ),
    BottomNavItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      labelKey: 'explore',
    ),
    BottomNavItem(
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      labelKey: 'favorites',
    ),
    BottomNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      labelKey: 'profile',
    ),
  ];
}
