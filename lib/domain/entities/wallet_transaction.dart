/// Single transaction from GET /wallets/{user_type}/{user_id}/transactions
class WalletTransaction {
  const WalletTransaction({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    this.description,
    this.referenceType,
    this.referenceId,
    this.initiatedByType,
    this.initiatedById,
    this.createdAt,
  });

  final int id;
  final String transactionType;
  final double amount;
  final double balanceBefore;
  final double balanceAfter;
  final String? description;
  final String? referenceType;
  final int? referenceId;
  final String? initiatedByType;
  final int? initiatedById;
  final String? createdAt;
}
