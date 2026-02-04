import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String phone, String password);
  Future<void> logout();
  Future<AuthUser?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<void> saveOnboardingCompleted(bool value);
  Future<bool> isOnboardingCompleted();
  String? getCachedToken();
}
