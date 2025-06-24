enum Flavor { develop, staging, production }

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.develop:
        return 'Flutter Base Project Dev';
      case Flavor.staging:
        return 'Flutter Base Project Staging';
      case Flavor.production:
        return 'Flutter Base Project';
      default:
        return 'title';
    }
  }

  static String get apiBaseUrl {
    switch (appFlavor) {
      case Flavor.develop:
        return 'https://dev-api.example.com';
      case Flavor.staging:
        return 'https://staging-api.example.com';
      case Flavor.production:
        return 'https://api.example.com';
      default:
        return 'https://api.example.com';
    }
  }

  static bool get isDevelopment => appFlavor == Flavor.develop;
  static bool get isStaging => appFlavor == Flavor.staging;
  static bool get isProduction => appFlavor == Flavor.production;
}
