import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:tulip_tea_order_booker/core/constants/storage_keys.dart';
import 'package:tulip_tea_order_booker/domain/entities/auth_user.dart';

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

  Future<void> clearAuth() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.tokenType);
    await _storage.delete(key: StorageKeys.user);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
