import 'package:flutter/foundation.dart';
import '../enums/app_enums.dart';

/// App configuration class
class AppConfig {
  // Singleton instance
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  // Current environment
  Environment _environment = Environment.development;

  // API URLs for different environments
  static const String _devApiUrl = 'https://dev-api.example.com';
  static const String _stagingApiUrl = 'https://staging-api.example.com';
  static const String _prodApiUrl = 'https://api.example.com';

  // App versions
  static const String appVersion = '1.0.0';
  static const int appBuildNumber = 1;

  // Feature flags
  bool enablePushNotifications = true;
  bool enableCrashReporting = !kDebugMode;
  bool enableAnalytics = !kDebugMode;

  /// Initialize app configuration with the given environment
  void init({required Environment environment}) {
    _environment = environment;

    // Set up environment-specific configurations
    switch (_environment) {
      case Environment.development:
        enablePushNotifications = false;
        enableCrashReporting = false;
        enableAnalytics = false;
        break;
      case Environment.staging:
        enablePushNotifications = true;
        enableCrashReporting = true;
        enableAnalytics = true;
        break;
      case Environment.production:
        enablePushNotifications = true;
        enableCrashReporting = true;
        enableAnalytics = true;
        break;
    }
  }

  /// Get current environment
  Environment get environment => _environment;

  /// Get API URL based on current environment
  String get apiUrl {
    switch (_environment) {
      case Environment.development:
        return _devApiUrl;
      case Environment.staging:
        return _stagingApiUrl;
      case Environment.production:
        return _prodApiUrl;
    }
  }

  /// Check if the app is running in debug mode
  bool get isDebug => kDebugMode;

  /// Check if the app is running in production
  bool get isProduction => _environment == Environment.production;
}
