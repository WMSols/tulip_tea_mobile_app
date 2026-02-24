import 'package:dio/dio.dart';

import 'package:tulip_tea_mobile_app/core/constants/api_constants.dart';
import 'package:tulip_tea_mobile_app/core/network/dio_client.dart';
import 'package:tulip_tea_mobile_app/data/models/wallet/wallet_balance_model.dart';
import 'package:tulip_tea_mobile_app/data/models/wallet/wallet_transaction_model.dart';

class WalletsApi {
  WalletsApi() : _dio = DioClient.instance;

  final Dio _dio;

  /// GET /wallets/{user_type}/{user_id}/balance
  /// userType: 'distributor' | 'order_booker' | 'delivery_man'
  Future<WalletBalanceModel> getBalance(String userType, int userId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      ApiConstants.walletBalance(userType, userId),
    );
    return WalletBalanceModel.fromJson(res.data!);
  }

  /// GET /wallets/{user_type}/{user_id}/transactions?limit=100
  Future<List<WalletTransactionModel>> getTransactions(
    String userType,
    int userId, {
    int limit = 100,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      ApiConstants.walletTransactions(userType, userId, limit: limit),
    );
    final list = res.data ?? [];
    return list
        .map(
          (e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
