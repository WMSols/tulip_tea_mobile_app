/// App-wide constants (pagination, limits, etc.).
class AppConstants {
  AppConstants._();

  static const int defaultPageSize = 100;
  static const int maxPageSize = 1000;
  static const int visitHistoryPageSize = 100;
  static const int maxImageSizeBytes = 2 * 1024 * 1024; // 2MB
  static const int imageQualityCompression = 85;
}
