import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';
import 'package:tulip_tea_order_booker/domain/repositories/auth_repository.dart';

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
}
