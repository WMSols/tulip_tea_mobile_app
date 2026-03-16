import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';

class DailyCollectionController extends GetxController {
  DailyCollectionController(
    this._shopUseCase,
    this._dailyCollectionUseCase,
    this._authUseCase,
  );

  final ShopUseCase _shopUseCase;
  final DailyCollectionUseCase _dailyCollectionUseCase;
  final AuthUseCase _authUseCase;

  OrderForDeliveryMan? order;
  final creditInfo = Rxn<ShopCreditInfo>();
  final isLoadingCredit = true.obs;
  final isSubmitting = false.obs;
  final collectionAmount = ''.obs;

  void setCollectionAmount(String v) => collectionAmount.value = v;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is OrderForDeliveryMan) {
      order = args;
    } else if (args is Map) {
      order = args['order'] as OrderForDeliveryMan?;
    }
    if (order != null) {
      loadCreditInfo();
    }
  }

  Future<void> loadCreditInfo() async {
    final shopId = order?.shopId;
    if (shopId == null) {
      isLoadingCredit.value = false;
      return;
    }
    isLoadingCredit.value = true;
    try {
      final info = await _shopUseCase.getShopCreditInfo(shopId);
      creditInfo.value = info;
    } catch (_) {
      creditInfo.value = null;
    } finally {
      isLoadingCredit.value = false;
    }
  }

  Future<bool> submit({required double amount, String? remarks}) async {
    final shopId = order?.shopId;
    if (shopId == null) return false;
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return false;
    isSubmitting.value = true;
    try {
      await _dailyCollectionUseCase.submitCollectionByDeliveryMan(
        deliveryManId: user.id,
        shopId: shopId,
        amount: amount,
        collectedAt: DateTime.now().toIso8601String(),
        remarks: remarks?.trim().isEmpty == true ? null : remarks?.trim(),
        orderId: order!.id,
      );
      return true;
    } finally {
      isSubmitting.value = false;
    }
  }
}
