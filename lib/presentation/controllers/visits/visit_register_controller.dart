import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_visit_use_case.dart';

class VisitRegisterController extends GetxController {
  VisitRegisterController(
    this._authUseCase,
    this._shopUseCase,
    this._shopVisitUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final ShopVisitUseCase _shopVisitUseCase;

  final shops = <Shop>[].obs;
  final isLoadingShops = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final visitType = ''.obs;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;
  final reason = ''.obs;

  static const List<String> visitTypeOptions = [
    'order_booking',
    'daily_collections',
    'inspection',
    'other',
  ];

  @override
  void onReady() {
    loadShops();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setVisitType(String v) => visitType.value = v;
  void setGpsLat(String v) => gpsLat.value = v;
  void setGpsLng(String v) => gpsLng.value = v;
  void setReason(String v) => reason.value = v;

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
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    if (selectedShopId.value == null || visitType.value.trim().isEmpty) {
      AppToast.showError('Error', 'Please select shop and visit type');
      return;
    }
    isSubmitting.value = true;
    try {
      await _shopVisitUseCase.registerVisit(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value,
        visitType: visitType.value.trim(),
        gpsLat: lat,
        gpsLng: lng,
        visitTime: DateTime.now().toIso8601String(),
        reason: reason.value.trim().isEmpty ? null : reason.value.trim(),
      );
      Get.back<void>();
      AppToast.showSuccess('Success', 'Visit registered successfully');
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isSubmitting.value = false;
    }
  }
}
