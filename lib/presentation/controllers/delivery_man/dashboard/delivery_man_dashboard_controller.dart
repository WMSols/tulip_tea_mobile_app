import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/wallet_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';

class DeliveryManDashboardController extends GetxController {
  DeliveryManDashboardController(
    this._authUseCase,
    this._walletUseCase,
    this._orderUseCase,
    this._deliveryUseCase,
  );

  final AuthUseCase _authUseCase;
  final WalletUseCase _walletUseCase;
  final OrderUseCase _orderUseCase;
  final DeliveryUseCase _deliveryUseCase;

  final walletBalance = Rxn<WalletBalance>();
  final transactions = <WalletTransaction>[].obs;
  final deliveries = <DeliveryModel>[].obs;
  final ordersWithDelivery = <OrderWithDelivery>[].obs;

  final isLoading = true.obs;
  final isLoadingWallet = false.obs;
  final isLoadingTransactions = false.obs;

  static const int _dashboardTransactionLimit = 20;

  static String _normStatus(String? s) {
    final v = (s ?? '').trim().toLowerCase();
    return v.replaceAll(' ', '_');
  }

  /// Delivered deliveries only (dashboard completed count).
  List<DeliveryModel> get deliveredDeliveriesOnly => deliveries.where((d) {
    final s = _normStatus(d.status);
    return s == 'delivered';
  }).toList();

  /// Pending orders on dashboard: only Not Started (delivery missing or status not_started).
  List<OrderForDeliveryMan> get pendingOrdersNotStarted => ordersWithDelivery
      .where((item) {
        final d = item.delivery as DeliveryModel?;
        final s = _normStatus(d?.status);
        return d == null || s == 'not_started';
      })
      .map((e) => e.order)
      .toList();

  /// Active on dashboard: orders whose delivery status is in_transit or partially_delivered.
  List<OrderForDeliveryMan> get activeOrdersInTransitOrPartiallyDelivered =>
      ordersWithDelivery
          .where((item) {
            final d = item.delivery as DeliveryModel?;
            final s = _normStatus(d?.status);
            return s == 'in_transit' || s == 'partially_delivered';
          })
          .map((e) => e.order)
          .toList();

  @override
  void onReady() {
    loadAll();
    super.onReady();
  }

  Future<void> loadAll() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      await Future.wait([
        _loadWallet(user.id),
        _loadDeliveries(user.id),
        _loadOrders(user.id),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadWallet(int deliveryManId) async {
    isLoadingWallet.value = true;
    try {
      final balance = await _walletUseCase.getBalance(
        WalletUseCase.userTypeDeliveryMan,
        deliveryManId,
      );
      walletBalance.value = balance;
      final list = await _walletUseCase.getTransactions(
        WalletUseCase.userTypeDeliveryMan,
        deliveryManId,
        limit: _dashboardTransactionLimit,
      );
      transactions.assignAll(list);
    } catch (_) {
      walletBalance.value = null;
      transactions.clear();
    } finally {
      isLoadingWallet.value = false;
    }
  }

  Future<void> _loadDeliveries(int deliveryManId) async {
    try {
      final list = await _deliveryUseCase.getDeliveriesByDeliveryMan(
        deliveryManId,
      );
      deliveries.assignAll(list);
    } catch (_) {
      deliveries.clear();
    }
  }

  Future<void> _loadOrders(int deliveryManId) async {
    try {
      final list = await _orderUseCase
          .getPendingOrdersWithDeliveryByDeliveryMan(deliveryManId);
      ordersWithDelivery.assignAll(list);
    } catch (_) {
      ordersWithDelivery.clear();
    }
  }

  Future<void> refreshBalance() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingWallet.value = true;
    try {
      final balance = await _walletUseCase.getBalance(
        WalletUseCase.userTypeDeliveryMan,
        user.id,
      );
      walletBalance.value = balance;
    } catch (_) {
      walletBalance.value = null;
    } finally {
      isLoadingWallet.value = false;
    }
  }

  Future<void> refreshTransactions() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingTransactions.value = true;
    try {
      final list = await _walletUseCase.getTransactions(
        WalletUseCase.userTypeDeliveryMan,
        user.id,
        limit: _dashboardTransactionLimit,
      );
      transactions.assignAll(list);
    } catch (_) {
      transactions.clear();
    } finally {
      isLoadingTransactions.value = false;
    }
  }
}
