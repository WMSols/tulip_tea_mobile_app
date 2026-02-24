import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/wallet_repository.dart';

class WalletUseCase {
  WalletUseCase(this._repo);

  final WalletRepository _repo;

  static const String userTypeOrderBooker = 'order_booker';

  Future<WalletBalance> getBalance(String userType, int userId) =>
      _repo.getBalance(userType, userId);

  Future<List<WalletTransaction>> getTransactions(
    String userType,
    int userId, {
    int limit = 100,
  }) =>
      _repo.getTransactions(userType, userId, limit: limit);
}
