import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tulip_tea_mobile_app/core/constants/storage_keys.dart';
import 'package:tulip_tea_mobile_app/domain/entities/auth_user.dart';

class SecureStorageSource {
  SecureStorageSource() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) async {
    await _storage.write(key: StorageKeys.accessToken, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: StorageKeys.accessToken);
  }

  Future<void> saveUser(AuthUser user) async {
    final json = {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
      'zone_id': user.zoneId,
      'distributor_id': user.distributorId,
      'role': user.role,
    };
    await _storage.write(key: StorageKeys.user, value: jsonEncode(json));
  }

  Future<AuthUser?> getUser() async {
    final raw = await _storage.read(key: StorageKeys.user);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AuthUser(
        id: map['id'] as int,
        name: map['name'] as String,
        phone: map['phone'] as String,
        email: map['email'] as String?,
        zoneId: map['zone_id'] as int?,
        distributorId: map['distributor_id'] as int?,
        role: map['role'] as String,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveOnboardingCompleted(bool value) async {
    await _storage.write(
      key: StorageKeys.onboardingCompleted,
      value: value.toString(),
    );
  }

  Future<bool> isOnboardingCompleted() async {
    final v = await _storage.read(key: StorageKeys.onboardingCompleted);
    return v == 'true';
  }

  Future<void> saveRememberMe(bool value, String role) async {
    final key = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberMeDeliveryMan
        : StorageKeys.rememberMeOrderBooker;
    await _storage.write(key: key, value: value.toString());
  }

  Future<bool> getRememberMe(String role) async {
    final key = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberMeDeliveryMan
        : StorageKeys.rememberMeOrderBooker;
    final v = await _storage.read(key: key);
    return v == 'true';
  }

  Future<void> saveRememberedCredentials(
    String phone,
    String password,
    String role,
  ) async {
    final phoneKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPhoneDeliveryMan
        : StorageKeys.rememberedPhoneOrderBooker;
    final passwordKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPasswordDeliveryMan
        : StorageKeys.rememberedPasswordOrderBooker;
    await _storage.write(key: phoneKey, value: phone);
    await _storage.write(key: passwordKey, value: password);
  }

  Future<({String? phone, String? password})> getRememberedCredentials(
    String role,
  ) async {
    final phoneKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPhoneDeliveryMan
        : StorageKeys.rememberedPhoneOrderBooker;
    final passwordKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPasswordDeliveryMan
        : StorageKeys.rememberedPasswordOrderBooker;
    final phone = await _storage.read(key: phoneKey);
    final password = await _storage.read(key: passwordKey);
    return (phone: phone, password: password ?? '');
  }

  Future<void> clearRememberedCredentials(String role) async {
    final rememberMeKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberMeDeliveryMan
        : StorageKeys.rememberMeOrderBooker;
    final phoneKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPhoneDeliveryMan
        : StorageKeys.rememberedPhoneOrderBooker;
    final passwordKey = role == StorageKeys.roleDeliveryMan
        ? StorageKeys.rememberedPasswordDeliveryMan
        : StorageKeys.rememberedPasswordOrderBooker;
    await _storage.delete(key: rememberMeKey);
    await _storage.delete(key: phoneKey);
    await _storage.delete(key: passwordKey);
  }

  Future<void> clearAuth() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.tokenType);
    await _storage.delete(key: StorageKeys.user);
    await _storage.delete(key: StorageKeys.userRole);
  }

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: StorageKeys.userRole, value: role);
  }

  Future<String?> getUserRole() async {
    return _storage.read(key: StorageKeys.userRole);
  }

  Future<void> saveDeliveryManOnboardingCompleted(bool value) async {
    await _storage.write(
      key: StorageKeys.deliveryManOnboardingCompleted,
      value: value.toString(),
    );
  }

  Future<bool> isDeliveryManOnboardingCompleted() async {
    final v = await _storage.read(
      key: StorageKeys.deliveryManOnboardingCompleted,
    );
    return v == 'true';
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
