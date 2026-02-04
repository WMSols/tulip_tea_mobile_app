import 'package:dio/dio.dart';

import 'package:tulip_tea_order_booker/core/config/env_config.dart';
import 'package:tulip_tea_order_booker/core/constants/api_constants.dart';
import 'api_interceptors.dart';

/// Singleton Dio instance with base URL and interceptors.
class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio get instance {
    if (_dio == null) {
      throw StateError(
        'DioClient not initialized. Call instanceWith from injection first.',
      );
    }
    return _dio!;
  }

  static Dio instanceWith({
    String? Function()? getToken,
    void Function()? onUnauthorized,
  }) {
    if (_dio != null) return _dio!;
    _dio =
        Dio(
            BaseOptions(
              baseUrl: EnvConfig.baseUrl,
              connectTimeout: Duration(
                milliseconds: ApiConstants.connectTimeoutMs,
              ),
              receiveTimeout: Duration(
                milliseconds: ApiConstants.receiveTimeoutMs,
              ),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          )
          ..interceptors.addAll([
            ApiInterceptors(getToken: getToken, onUnauthorized: onUnauthorized),
          ]);
    return _dio!;
  }

  static void reset() {
    _dio = null;
  }
}
