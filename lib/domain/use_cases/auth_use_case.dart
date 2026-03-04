import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/auth_repository.dart';

class AuthUseCase {
  AuthUseCase(this._repo);
  final AuthRepository _repo;

  Future<AuthUser> login(String phone, String password, String role) =>
      _repo.login(phone, password, role);

  Future<void> logout() => _repo.logout();

  Future<AuthUser?> getCurrentUser() => _repo.getCurrentUser();

  Future<bool> isLoggedIn() => _repo.isLoggedIn();

  Future<void> saveOnboardingCompleted(bool value) =>
      _repo.saveOnboardingCompleted(value);

  Future<bool> isOnboardingCompleted() => _repo.isOnboardingCompleted();

  Future<void> saveRememberMe(bool value, String role) =>
      _repo.saveRememberMe(value, role);

  Future<bool> getRememberMe(String role) => _repo.getRememberMe(role);

  Future<void> saveRememberedCredentials(
    String phone,
    String password,
    String role,
  ) => _repo.saveRememberedCredentials(phone, password, role);

  Future<({String? phone, String? password})> getRememberedCredentials(
    String role,
  ) => _repo.getRememberedCredentials(role);

  Future<void> clearRememberedCredentials(String role) =>
      _repo.clearRememberedCredentials(role);
}
