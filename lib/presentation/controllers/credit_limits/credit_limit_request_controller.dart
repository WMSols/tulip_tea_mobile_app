import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/credit_limit_request_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';

class CreditLimitRequestController extends GetxController {
  CreditLimitRequestController(
    this._authUseCase,
    this._shopUseCase,
    this._creditLimitRequestUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final CreditLimitRequestUseCase _creditLimitRequestUseCase;

  final shops = <Shop>[].obs;
  final isLoadingShops = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final requestedCreditLimit = ''.obs;
  final remarks = ''.obs;

  @override
  void onReady() {
    loadShops();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setRequestedCreditLimit(String v) => requestedCreditLimit.value = v;
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
    final amount = double.tryParse(requestedCreditLimit.value.trim());
    if (selectedShopId.value == null || amount == null || amount < 0) {
      AppToast.showError(
        'Error',
        'Please select shop and enter a valid credit limit',
      );
      return;
    }
    isSubmitting.value = true;
    try {
      await _creditLimitRequestUseCase.createRequest(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value!,
        requestedCreditLimit: amount,
        remarks: remarks.value.trim().isEmpty ? null : remarks.value.trim(),
      );
      Get.back<void>();
      AppToast.showSuccess('Success', 'Credit limit request submitted');
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isSubmitting.value = false;
    }
  }
}
