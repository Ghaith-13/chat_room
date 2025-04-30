/// Enum for app environment
enum Environment {
  development,
  staging,
  production,
}

/// Enum for network status
enum NetworkStatus {
  initial,
  loading,
  success,
  error,
}

/// Enum for user roles
enum UserRole {
  guest,
  user,
  admin,
}

/// Enum for chat message status
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

/// Enum for chat message type
enum MessageType {
  text,
  image,
  video,
  file,
  audio,
}

/// Enum for theme mode
enum AppThemeMode {
  light,
  dark,
  system,
}
