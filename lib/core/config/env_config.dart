import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Loads and exposes env variables. Call [load] in main before runApp.
class EnvConfig {
  EnvConfig._();

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://tulip-tea-backend.onrender.com';

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // .env may be missing (e.g. clone without .env); use defaults
    }
  }
}
