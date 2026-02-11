import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String phone, String password);
  Future<void> logout();
  Future<AuthUser?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<void> saveOnboardingCompleted(bool value);
  Future<bool> isOnboardingCompleted();
  Future<void> saveRememberMe(bool value);
  Future<bool> getRememberMe();
  Future<void> saveRememberedCredentials(String phone, String password);
  Future<({String? phone, String? password})> getRememberedCredentials();
  Future<void> clearRememberedCredentials();
  String? getCachedToken();
}
