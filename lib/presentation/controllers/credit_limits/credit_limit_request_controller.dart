import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/credit_limit_request_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/credit_limits_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/my_requests_controller.dart';

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

  /// Increment to force request form to rebuild (clears uncontrolled text fields).
  final formResetKey = 0.obs;

  @override
  void onReady() {
    loadShops();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setRequestedCreditLimit(String v) => requestedCreditLimit.value = v;
  void setRemarks(String v) => remarks.value = v;

  /// Resets all form fields and forces form UI to clear. Call after successful request.
  void clearForm() {
    selectedShopId.value = null;
    requestedCreditLimit.value = '';
    remarks.value = '';
    formResetKey.value++;
  }

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
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    final amount = double.tryParse(requestedCreditLimit.value.trim());
    if (selectedShopId.value == null || amount == null || amount < 0) {
      AppToast.showError(
        AppTexts.error,
        AppTexts.selectShopAndEnterCreditLimit,
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
      clearForm();
      await Get.find<MyRequestsController>().loadRequests();
      Get.find<CreditLimitsController>().goToMyRequestsTab();
      AppToast.showSuccess(
        AppTexts.success,
        AppTexts.creditLimitRequestSubmitted,
      );
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
