import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/my_shops_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shops_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

class ShopEditController extends GetxController {
  ShopEditController(
    this._authUseCase,
    this._routeUseCase,
    this._shopUseCase,
    this.shop,
  );

  final AuthUseCase _authUseCase;
  final RouteUseCase _routeUseCase;
  final ShopUseCase _shopUseCase;
  final Shop shop;

  /// Text controllers so edit form fields are editable (avoid initialValue reset on rebuild).
  late final TextEditingController shopNameController;
  late final TextEditingController ownerNameController;
  late final TextEditingController ownerPhoneController;
  late final TextEditingController gpsLatController;
  late final TextEditingController gpsLngController;
  late final TextEditingController creditLimitController;
  late final TextEditingController legacyBalanceController;

  final shopName = ''.obs;
  final ownerName = ''.obs;
  final ownerPhone = ''.obs;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;
  final creditLimit = ''.obs;
  final legacyBalance = ''.obs;
  final selectedRouteId = Rxn<int>();
  final ownerCnicFrontPhoto = Rxn<String>();
  final ownerCnicBackPhoto = Rxn<String>();
  final ownerPhoto = Rxn<String>();
  final shopExteriorPhoto = Rxn<String>();

  final routes = <RouteEntity>[].obs;
  final isLoadingRoutes = false.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    shopNameController = TextEditingController(text: shop.name);
    ownerNameController = TextEditingController(text: shop.ownerName);
    ownerPhoneController = TextEditingController(text: shop.ownerPhone);
    gpsLatController = TextEditingController(
      text: shop.gpsLat?.toString() ?? '',
    );
    gpsLngController = TextEditingController(
      text: shop.gpsLng?.toString() ?? '',
    );
    creditLimitController = TextEditingController(
      text: shop.creditLimit?.toString() ?? '',
    );
    legacyBalanceController = TextEditingController(text: '');
    selectedRouteId.value = shop.routeId;
  }

  @override
  void onClose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    ownerPhoneController.dispose();
    gpsLatController.dispose();
    gpsLngController.dispose();
    creditLimitController.dispose();
    legacyBalanceController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRoutes();
    });
  }

  Future<void> _loadRoutes() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    loadRoutes();
  }

  void setShopName(String v) => shopName.value = v;
  void setOwnerName(String v) => ownerName.value = v;
  void setOwnerPhone(String v) => ownerPhone.value = v;
  void setGpsLat(String v) => gpsLat.value = v;
  void setGpsLng(String v) => gpsLng.value = v;
  void setCreditLimit(String v) => creditLimit.value = v;
  void setLegacyBalance(String v) => legacyBalance.value = v;
  void setSelectedRouteId(int? v) => selectedRouteId.value = v;
  void setOwnerCnicFrontPhoto(String? v) => ownerCnicFrontPhoto.value = v;
  void setOwnerCnicBackPhoto(String? v) => ownerCnicBackPhoto.value = v;
  void setOwnerPhoto(String? v) => ownerPhoto.value = v;
  void setShopExteriorPhoto(String? v) => shopExteriorPhoto.value = v;

  Future<void> loadRoutes() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingRoutes.value = true;
    try {
      final list = await _routeUseCase.getRoutesByOrderBooker(
        user.orderBookerId,
      );
      routes.assignAll(list);
    } catch (_) {
      routes.clear();
    } finally {
      isLoadingRoutes.value = false;
    }
  }

  Future<void> resubmit() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    final name = shopNameController.text.trim();
    final owner = ownerNameController.text.trim();
    final phone = ownerPhoneController.text.trim();
    final lat = double.tryParse(gpsLatController.text.trim()) ?? shop.gpsLat;
    final lng = double.tryParse(gpsLngController.text.trim()) ?? shop.gpsLng;
    final credit = double.tryParse(creditLimitController.text.trim());
    final legacy = double.tryParse(legacyBalanceController.text.trim());
    if (name.isEmpty ||
        owner.isEmpty ||
        phone.isEmpty ||
        lat == null ||
        lng == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    final zoneId = user.zoneId;
    final routeId = selectedRouteId.value;
    final creditVal = (credit != null && credit >= 0) ? credit : 0.0;
    final legacyVal = (legacy != null && legacy >= 0) ? legacy : 0.0;

    isSubmitting.value = true;
    try {
      await _shopUseCase.resubmitRejectedShop(
        shop.id,
        name: name,
        ownerName: owner,
        ownerPhone: phone,
        gpsLat: lat,
        gpsLng: lng,
        zoneId: zoneId,
        routeId: routeId,
        creditLimit: creditVal,
        legacyBalance: legacyVal,
        ownerCnicFrontPhoto: null,
        ownerCnicBackPhoto: null,
        ownerPhoto: null,
        shopExteriorPhoto: null,
      );
      // Navigate first so toast uses a valid context (AppToast uses Get.context).
      Get.back();
      if (Get.currentRoute == AppRoutes.myShopDetails) Get.back();
      Get.find<ShopsController>().goToMyShopsTab();
      // Refresh list after navigation; don't block or override success on failure.
      if (Get.isRegistered<MyShopsController>()) {
        Get.find<MyShopsController>().loadShops();
      }
      // Defer toast to next frame so Get.context is the new route.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppToast.showSuccess(
          AppTexts.success,
          AppTexts.shopResubmittedSuccessfully,
        );
      });
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
