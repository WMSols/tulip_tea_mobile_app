import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/auth_repository.dart';

class AuthUseCase {
  AuthUseCase(this._repo);
  final AuthRepository _repo;

  Future<AuthUser> login(String phone, String password) =>
      _repo.login(phone, password);

  Future<void> logout() => _repo.logout();

  Future<AuthUser?> getCurrentUser() => _repo.getCurrentUser();

  Future<bool> isLoggedIn() => _repo.isLoggedIn();

  Future<void> saveOnboardingCompleted(bool value) =>
      _repo.saveOnboardingCompleted(value);

  Future<bool> isOnboardingCompleted() => _repo.isOnboardingCompleted();

  Future<void> saveRememberMe(bool value) => _repo.saveRememberMe(value);

  Future<bool> getRememberMe() => _repo.getRememberMe();

  Future<void> saveRememberedCredentials(String phone, String password) =>
      _repo.saveRememberedCredentials(phone, password);

  Future<({String? phone, String? password})> getRememberedCredentials() =>
      _repo.getRememberedCredentials();

  Future<void> clearRememberedCredentials() =>
      _repo.clearRememberedCredentials();
}
