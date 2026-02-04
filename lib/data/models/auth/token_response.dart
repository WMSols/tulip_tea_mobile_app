import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';
import 'package:tulip_tea_order_booker/data/models/auth/user_model.dart';

class TokenResponse {
  TokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  final String accessToken;
  final String tokenType;
  final UserModel user;

  AuthUser toEntity() => user.toEntity();
}
