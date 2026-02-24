import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_balance.dart';
import 'package:tulip_tea_mobile_app/domain/entities/wallet_transaction.dart';
import 'package:tulip_tea_mobile_app/domain/entities/weekly_route_schedule.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/wallet_use_case.dart';

class DashboardController extends GetxController {
  DashboardController(
    this._authUseCase,
    this._routeUseCase,
    this._walletUseCase,
  );

  final AuthUseCase _authUseCase;
  final RouteUseCase _routeUseCase;
  final WalletUseCase _walletUseCase;

  final routes = <RouteEntity>[].obs;
  final walletBalance = Rxn<WalletBalance>();
  final transactions = <WalletTransaction>[].obs;
  final schedules = <WeeklyRouteSchedule>[].obs;

  final isLoading = true.obs;
  final isLoadingWallet = false.obs;
  final isLoadingTransactions = false.obs;
  final isLoadingSchedules = false.obs;

  static const int _dashboardTransactionLimit = 20;

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
        _loadRoutes(user.orderBookerId),
        _loadWallet(user.orderBookerId),
        _loadSchedules(user.orderBookerId),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadRoutes(int orderBookerId) async {
    try {
      final list = await _routeUseCase.getRoutesByOrderBooker(orderBookerId);
      routes.assignAll(list);
    } catch (_) {
      routes.clear();
    }
  }

  Future<void> _loadWallet(int orderBookerId) async {
    isLoadingWallet.value = true;
    try {
      final balance = await _walletUseCase.getBalance(
        WalletUseCase.userTypeOrderBooker,
        orderBookerId,
      );
      walletBalance.value = balance;
      final list = await _walletUseCase.getTransactions(
        WalletUseCase.userTypeOrderBooker,
        orderBookerId,
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

  Future<void> _loadSchedules(int orderBookerId) async {
    isLoadingSchedules.value = true;
    try {
      final list = await _routeUseCase.getWeeklySchedulesByOrderBooker(
        orderBookerId,
      );
      schedules.assignAll(list);
    } catch (_) {
      schedules.clear();
    } finally {
      isLoadingSchedules.value = false;
    }
  }

  Future<void> refreshBalance() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingWallet.value = true;
    try {
      final balance = await _walletUseCase.getBalance(
        WalletUseCase.userTypeOrderBooker,
        user.orderBookerId,
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
        WalletUseCase.userTypeOrderBooker,
        user.orderBookerId,
        limit: _dashboardTransactionLimit,
      );
      transactions.assignAll(list);
    } catch (_) {
      transactions.clear();
    } finally {
      isLoadingTransactions.value = false;
    }
  }

  /// Schedules grouped by day_of_week (0=Monday..6=Sunday). Keys are 0..6.
  Map<int, List<WeeklyRouteSchedule>> get schedulesByDay {
    final map = <int, List<WeeklyRouteSchedule>>{};
    for (final s in schedules) {
      map.putIfAbsent(s.dayOfWeek, () => []).add(s);
    }
    for (final key in map.keys) {
      map[key]!.sort((a, b) => a.routeName?.compareTo(b.routeName ?? '') ?? 0);
    }
    return map;
  }
}
