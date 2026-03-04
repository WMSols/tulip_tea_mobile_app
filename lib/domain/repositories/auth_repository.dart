import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String phone, String password, String role);
  Future<void> logout();
  Future<AuthUser?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<void> saveOnboardingCompleted(bool value);
  Future<bool> isOnboardingCompleted();
  Future<void> saveRememberMe(bool value, String role);
  Future<bool> getRememberMe(String role);
  Future<void> saveRememberedCredentials(
    String phone,
    String password,
    String role,
  );
  Future<({String? phone, String? password})> getRememberedCredentials(
    String role,
  );
  Future<void> clearRememberedCredentials(String role);
  String? getCachedToken();
}
