import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';

class DailyCollectionController extends GetxController {
  DailyCollectionController(
    this._authUseCase,
    this._shopUseCase,
    this._dailyCollectionUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final DailyCollectionUseCase _dailyCollectionUseCase;

  final shops = <Shop>[].obs;
  final isLoadingShops = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final amount = ''.obs;
  final remarks = ''.obs;

  @override
  void onReady() {
    loadShops();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
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

  Future<void> submit() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      AppToast.showError('Error', 'Please log in again');
      return;
    }
    final amt = double.tryParse(amount.value.trim());
    if (selectedShopId.value == null || amt == null || amt < 0) {
      AppToast.showError('Error', 'Select shop and enter a valid amount');
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
      );
      amount.value = '';
      remarks.value = '';
      AppToast.showSuccess('Success', 'Collection submitted');
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isSubmitting.value = false;
    }
  }
}
