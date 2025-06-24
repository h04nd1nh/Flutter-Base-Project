import 'package:flutter/material.dart';
import '../flavors.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [child, if (!F.isProduction) _buildBanner()]);
  }

  Widget _buildBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _getBannerColor().withValues(alpha: 0.8),
                _getBannerColor().withValues(alpha: 0.6),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Text(
              '${F.name.toUpperCase()} MODE',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBannerColor() {
    switch (F.appFlavor) {
      case Flavor.develop:
        return Colors.red;
      case Flavor.staging:
        return Colors.orange;
      case Flavor.production:
      default:
        return Colors.green;
    }
  }
}
