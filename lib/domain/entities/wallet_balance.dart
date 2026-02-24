/// Wallet balance from GET /wallets/{user_type}/{user_id}/balance
class WalletBalance {
  const WalletBalance({
    required this.walletId,
    required this.userType,
    required this.userId,
    required this.currentBalance,
    this.isActive = true,
  });

  final int walletId;
  final String userType;
  final int userId;
  final double currentBalance;
  final bool isActive;
}
