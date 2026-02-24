import 'package:tulip_tea_mobile_app/data/data_sources/remote/wallets_api.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/wallet_repository.dart';
import 'package:tulip_tea_mobile_app/core/network/api_exceptions.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._api);

  final WalletsApi _api;

  @override
  Future<WalletBalance> getBalance(String userType, int userId) async {
    try {
      final model = await _api.getBalance(userType, userId);
      return model.toEntity();
    } catch (e, st) {
      throw ApiExceptions.handle<WalletBalance>(e, st);
    }
  }

  @override
  Future<List<WalletTransaction>> getTransactions(
    String userType,
    int userId, {
    int limit = 100,
  }) async {
    try {
      final list = await _api.getTransactions(userType, userId, limit: limit);
      return list.map((m) => m.toEntity()).toList();
    } catch (e, st) {
      throw ApiExceptions.handle<List<WalletTransaction>>(e, st);
    }
  }
}
