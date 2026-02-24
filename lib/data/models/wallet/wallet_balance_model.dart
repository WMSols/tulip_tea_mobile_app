import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';

/// Response for GET /wallets/{user_type}/{user_id}/balance
class WalletBalanceModel {
  WalletBalanceModel({
    required this.walletId,
    required this.userType,
    required this.userId,
    required this.currentBalance,
    this.isActive = true,
  });

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
      walletId: json['wallet_id'] as int,
      userType: json['user_type'] as String,
      userId: json['user_id'] as int,
      currentBalance: (json['current_balance'] as num).toDouble(),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  final int walletId;
  final String userType;
  final int userId;
  final double currentBalance;
  final bool isActive;

  WalletBalance toEntity() => WalletBalance(
        walletId: walletId,
        userType: userType,
        userId: userId,
        currentBalance: currentBalance,
        isActive: isActive,
      );
}
