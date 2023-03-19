class AppSecretValues {
  AppSecretValues({
    required this.baseUrl,
    required this.apiKey,
  });

  final String baseUrl;
  final String apiKey;
}

class AppSecretConfig {
  late final AppSecretValues values;
  bool _lock = false;
  static final AppSecretConfig instance = AppSecretConfig._internal();

  AppSecretConfig._internal();

  factory AppSecretConfig.instantiate({
    required AppSecretValues values,
  }) {
    if (instance._lock) return instance;

    instance.values = values;
    instance._lock = true;
    return instance;
  }
}
