import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/auth/login_request.dart';
import 'package:tulip_tea_mobile_app/data/models/auth/token_response.dart';

class AuthApi {
  AuthApi() : _dio = DioClient.instance;

  final Dio _dio;

  Future<TokenResponse> login(LoginRequest request) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiConstants.loginOrderBooker,
      data: request.toJson(),
    );
    return TokenResponse.fromJson(res.data!);
  }
}
