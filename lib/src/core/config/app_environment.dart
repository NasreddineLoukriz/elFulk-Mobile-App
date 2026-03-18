enum AppFlavor { development, production }

class AppEnvironment {
  const AppEnvironment._({
    required this.flavor,
    required this.appName,
    required this.appTitle,
    required this.apiEnvironmentLabel,
  });

  final AppFlavor flavor;
  final String appName;
  final String appTitle;
  final String apiEnvironmentLabel;

  bool get isProduction => flavor == AppFlavor.production;

  static AppEnvironment fromFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.development:
        return const AppEnvironment._(
          flavor: AppFlavor.development,
          appName: 'ElFulk Dev',
          appTitle: 'ElFulk',
          apiEnvironmentLabel: 'development',
        );
      case AppFlavor.production:
        return const AppEnvironment._(
          flavor: AppFlavor.production,
          appName: 'ElFulk',
          appTitle: 'ElFulk',
          apiEnvironmentLabel: 'production',
        );
    }
  }
}

extension AppFlavorX on AppFlavor {
  String get label {
    switch (this) {
      case AppFlavor.development:
        return 'development';
      case AppFlavor.production:
        return 'production';
    }
  }
}
