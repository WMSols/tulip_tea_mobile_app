import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';
import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/auth_repository.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/auth_token_holder.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/remote/auth_api.dart';
import 'package:tulip_tea_mobile_app/data/models/auth/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api, this._storage, this._tokenHolder);

  final AuthApi _api;
  final SecureStorageSource _storage;
  final AuthTokenHolder _tokenHolder;

  @override
  Future<AuthUser> login(String phone, String password) async {
    try {
      final res = await _api.login(
        LoginRequest(phone: phone, password: password),
      );
      final user = res.toEntity();
      await _storage.saveToken(res.accessToken);
      await _storage.saveUser(user);
      _tokenHolder.setToken(res.accessToken);
      return user;
    } catch (e, st) {
      final failure = ApiExceptions.handle<AuthUser>(e, st);
      throw Exception(failure.message);
    }
  }

  @override
  Future<void> logout() async {
    _tokenHolder.clear();
    await _storage.clearAuth();
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final user = await _storage.getUser();
    if (user != null) {
      final token = await _storage.getToken();
      _tokenHolder.setToken(token);
    }
    return user;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> saveOnboardingCompleted(bool value) async {
    await _storage.saveOnboardingCompleted(value);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _storage.isOnboardingCompleted();
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _storage.saveRememberMe(value);
  }

  @override
  Future<bool> getRememberMe() async {
    return _storage.getRememberMe();
  }

  @override
  Future<void> saveRememberedCredentials(String phone, String password) async {
    await _storage.saveRememberedCredentials(phone, password);
  }

  @override
  Future<({String? phone, String? password})> getRememberedCredentials() async {
    return _storage.getRememberedCredentials();
  }

  @override
  Future<void> clearRememberedCredentials() async {
    await _storage.clearRememberedCredentials();
  }

  @override
  String? getCachedToken() => _tokenHolder.token;
}
