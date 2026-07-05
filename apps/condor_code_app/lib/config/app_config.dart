enum BuildType { dev, staging, prod }

enum DataSource { mock, remote }

class AppConfig {
  final BuildType buildType;
  final DataSource dataSource;

  const AppConfig({required this.buildType, required this.dataSource});

  bool get isDev => buildType == BuildType.dev;

  bool get isProd => buildType == BuildType.prod;

  bool get isStaging => buildType == BuildType.staging;

  bool get isMock => dataSource == DataSource.mock;

  String get bannerLabel => switch (buildType) {
    BuildType.dev => 'DEV',
    BuildType.staging => 'ST',
    BuildType.prod => 'PR',
  };
}
