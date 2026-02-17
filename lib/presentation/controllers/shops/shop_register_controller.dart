import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/my_shops_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shops_controller.dart';

class ShopRegisterController extends GetxController {
  ShopRegisterController(
    this._authUseCase,
    this._routeUseCase,
    this._shopUseCase,
  );

  final AuthUseCase _authUseCase;
  final RouteUseCase _routeUseCase;
  final ShopUseCase _shopUseCase;

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

  /// Increment to force register form to rebuild (clears uncontrolled text fields).
  final formResetKey = 0.obs;

  @override
  void onReady() {
    super.onReady();
    _loadRoutes();
  }

  /// Ensures token is in [AuthTokenHolder] (via getCurrentUser) before any API call.
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

  /// Resets all form fields to initial values and forces form UI to clear. Call after successful registration.
  void clearForm() {
    shopName.value = '';
    ownerName.value = '';
    ownerPhone.value = '';
    gpsLat.value = '';
    gpsLng.value = '';
    creditLimit.value = '';
    legacyBalance.value = '';
    selectedRouteId.value = null;
    ownerCnicFrontPhoto.value = null;
    ownerCnicBackPhoto.value = null;
    ownerPhoto.value = null;
    shopExteriorPhoto.value = null;
    formResetKey.value++;
  }

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

  Future<void> submit() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    final credit = double.tryParse(creditLimit.value.trim());
    final legacy = double.tryParse(legacyBalance.value.trim());
    if (AppHelper.isNullOrEmpty(shopName.value) ||
        AppHelper.isNullOrEmpty(ownerName.value) ||
        AppHelper.isNullOrEmpty(ownerPhone.value) ||
        lat == null ||
        lng == null ||
        ownerCnicFrontPhoto.value == null ||
        ownerCnicFrontPhoto.value!.isEmpty ||
        ownerCnicBackPhoto.value == null ||
        ownerCnicBackPhoto.value!.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    final zoneId = user.zoneId;
    final routeId = selectedRouteId.value;
    final creditVal = (credit != null && credit >= 0) ? credit : 0.0;
    final legacyVal = (legacy != null && legacy >= 0) ? legacy : 0.0;

    String? frontBase64;
    String? backBase64;
    try {
      frontBase64 = base64Encode(
        await File(ownerCnicFrontPhoto.value!).readAsBytes(),
      );
      backBase64 = base64Encode(
        await File(ownerCnicBackPhoto.value!).readAsBytes(),
      );
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.couldNotReadCnicPhotos);
      return;
    }
    String? ownerPhotoBase64;
    if (ownerPhoto.value != null && ownerPhoto.value!.isNotEmpty) {
      try {
        ownerPhotoBase64 = base64Encode(
          await File(ownerPhoto.value!).readAsBytes(),
        );
      } catch (_) {}
    }
    String? shopExteriorBase64;
    if (shopExteriorPhoto.value != null &&
        shopExteriorPhoto.value!.isNotEmpty) {
      try {
        shopExteriorBase64 = base64Encode(
          await File(shopExteriorPhoto.value!).readAsBytes(),
        );
      } catch (_) {}
    }

    isSubmitting.value = true;
    try {
      await _shopUseCase.registerShop(
        orderBookerId: user.orderBookerId,
        name: shopName.value.trim(),
        ownerName: ownerName.value.trim(),
        ownerPhone: ownerPhone.value.trim(),
        gpsLat: lat,
        gpsLng: lng,
        zoneId: zoneId,
        routeId: routeId,
        creditLimit: creditVal,
        legacyBalance: legacyVal,
        ownerCnicFrontPhoto: frontBase64,
        ownerCnicBackPhoto: backBase64,
        ownerPhoto: ownerPhotoBase64,
        shopExteriorPhoto: shopExteriorBase64,
      );
      clearForm();
      await Get.find<MyShopsController>().loadShops();
      Get.find<ShopsController>().goToMyShopsTab();
      AppToast.showSuccess(
        AppTexts.success,
        AppTexts.shopRegisteredSuccessfully,
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
