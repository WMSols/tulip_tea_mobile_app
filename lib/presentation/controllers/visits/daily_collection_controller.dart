import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/order_entity.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';

class DailyCollectionController extends GetxController {
  DailyCollectionController(
    this._authUseCase,
    this._shopUseCase,
    this._orderUseCase,
    this._dailyCollectionUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final OrderUseCase _orderUseCase;
  final DailyCollectionUseCase _dailyCollectionUseCase;

  final shops = <Shop>[].obs;
  final orders = <OrderEntity>[].obs;
  final isLoadingShops = false.obs;
  final isLoadingOrders = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final selectedOrderId = Rxn<int>();
  final amount = ''.obs;
  final remarks = ''.obs;

  @override
  void onReady() {
    loadShops();
    loadOrders();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setSelectedOrderId(int? v) => selectedOrderId.value = v;
  void setAmount(String v) => amount.value = v;
  void setRemarks(String v) => remarks.value = v;

  Future<void> loadShops() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingShops.value = true;
    try {
      final list = await _shopUseCase.getShopsByOrderBooker(
        user.orderBookerId,
        approvedOnly: true,
      );
      shops.assignAll(list);
    } catch (_) {
      shops.clear();
    } finally {
      isLoadingShops.value = false;
    }
  }

  Future<void> loadOrders() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingOrders.value = true;
    try {
      final list = await _orderUseCase.getOrdersByOrderBooker(
        user.orderBookerId,
      );
      orders.assignAll(list);
    } catch (_) {
      orders.clear();
    } finally {
      isLoadingOrders.value = false;
    }
  }

  Future<void> submit() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    final amt = double.tryParse(amount.value.trim());
    if (selectedShopId.value == null || amt == null || amt < 0) {
      AppToast.showError(
        AppTexts.error,
        AppTexts.selectShopAndEnterValidAmount,
      );
      return;
    }
    isSubmitting.value = true;
    try {
      await _dailyCollectionUseCase.submitCollection(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value!,
        amount: amt,
        collectedAt: DateTime.now().toIso8601String(),
        remarks: remarks.value.trim().isEmpty ? null : remarks.value.trim(),
        orderId: selectedOrderId.value,
      );
      amount.value = '';
      remarks.value = '';
      AppToast.showSuccess(AppTexts.success, AppTexts.collectionSubmitted);
    } catch (e) {
      AppToast.showError(
        AppTexts.error,
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
