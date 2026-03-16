import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/daily_collection.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/wallet_use_case.dart';

class DeliveryManDashboardController extends GetxController {
  DeliveryManDashboardController(
    this._authUseCase,
    this._walletUseCase,
    this._orderUseCase,
    this._deliveryUseCase,
    this._dailyCollectionUseCase,
  );

  final AuthUseCase _authUseCase;
  final WalletUseCase _walletUseCase;
  final OrderUseCase _orderUseCase;
  final DeliveryUseCase _deliveryUseCase;
  final DailyCollectionUseCase _dailyCollectionUseCase;

  final walletBalance = Rxn<WalletBalance>();
  final transactions = <WalletTransaction>[].obs;
  final deliveries = <DeliveryModel>[].obs;
  final orders = <OrderForDeliveryMan>[].obs;
  final dailyCollections = <DailyCollection>[].obs;

  final isLoading = true.obs;
  final isLoadingWallet = false.obs;
  final isLoadingTransactions = false.obs;

  static const int _dashboardTransactionLimit = 20;

  /// Active deliveries: status not delivered/returned/failed/cancelled
  List<DeliveryModel> get activeDeliveries => deliveries.where((d) {
    final s = (d.status ?? '').toLowerCase();
    return s != 'delivered' &&
        s != 'returned' &&
        s != 'failed' &&
        s != 'cancelled';
  }).toList();

  /// Completed deliveries
  List<DeliveryModel> get completedDeliveries => deliveries.where((d) {
    final s = (d.status ?? '').toLowerCase();
    return s == 'delivered' || s == 'returned' || s == 'failed';
  }).toList();

  /// Pending orders (PENDING or CONFIRMED, not yet delivered/cancelled)
  List<OrderForDeliveryMan> get pendingOrders => orders.where((o) {
    final s = (o.status ?? '').toUpperCase();
    return s == 'PENDING' || s == 'CONFIRMED';
  }).toList();

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
        _loadDailyCollections(user.id),
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
      final list = await _orderUseCase.getOrdersByDeliveryMan(deliveryManId);
      orders.assignAll(list);
    } catch (_) {
      orders.clear();
    }
  }

  Future<void> _loadDailyCollections(int deliveryManId) async {
    try {
      final list = await _dailyCollectionUseCase.getCollectionsByDeliveryMan(
        deliveryManId,
      );
      dailyCollections.assignAll(list);
    } catch (_) {
      dailyCollections.clear();
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
