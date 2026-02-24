import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';

abstract class WalletRepository {
  Future<WalletBalance> getBalance(String userType, int userId);
  Future<List<WalletTransaction>> getTransactions(
    String userType,
    int userId, {
    int limit = 100,
  });
}
