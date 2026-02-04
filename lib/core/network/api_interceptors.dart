import 'package:dio/dio.dart'
    show
        DioException,
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler,
        ErrorInterceptorHandler;
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

/// Adds JWT to requests; on 401 runs [onUnauthorized] and redirects to login.
class ApiInterceptors extends Interceptor {
  ApiInterceptors({this.getToken, this.onUnauthorized});

  final String? Function()? getToken;
  final void Function()? onUnauthorized;

  final _log = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken?.call();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    _log.d('${options.method} ${options.uri}\nHeaders: ${options.headers}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.d('${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.e(
      '${err.response?.statusCode} ${err.requestOptions.uri} ${err.message}',
    );
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
      Get.offAllNamed<void>('/login');
    }
    handler.next(err);
  }
}
