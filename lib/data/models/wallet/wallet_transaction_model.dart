import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';

/// Single item from GET /wallets/{user_type}/{user_id}/transactions
class WalletTransactionModel {
  WalletTransactionModel({
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

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'] as int,
      transactionType: json['transaction_type'] as String,
      amount: (json['amount'] as num).toDouble(),
      balanceBefore: (json['balance_before'] as num).toDouble(),
      balanceAfter: (json['balance_after'] as num).toDouble(),
      description: json['description'] as String?,
      referenceType: json['reference_type'] as String?,
      referenceId: json['reference_id'] as int?,
      initiatedByType: json['initiated_by_type'] as String?,
      initiatedById: json['initiated_by_id'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

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

  WalletTransaction toEntity() => WalletTransaction(
        id: id,
        transactionType: transactionType,
        amount: amount,
        balanceBefore: balanceBefore,
        balanceAfter: balanceAfter,
        description: description,
        referenceType: referenceType,
        referenceId: referenceId,
        initiatedByType: initiatedByType,
        initiatedById: initiatedById,
        createdAt: createdAt,
      );
}
