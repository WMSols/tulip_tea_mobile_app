import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';
import 'package:tulip_tea_order_booker/domain/entities/zone.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/zone_use_case.dart';

class ShopRegisterController extends GetxController {
  ShopRegisterController(
    this._authUseCase,
    this._zoneUseCase,
    this._routeUseCase,
    this._shopUseCase,
  );

  final AuthUseCase _authUseCase;
  final ZoneUseCase _zoneUseCase;
  final RouteUseCase _routeUseCase;
  final ShopUseCase _shopUseCase;

  final shopName = ''.obs;
  final ownerName = ''.obs;
  final ownerPhone = ''.obs;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;
  final creditLimit = ''.obs;
  final selectedZoneId = Rxn<int>();
  final selectedRouteId = Rxn<int>();
  final ownerCnicFrontPhoto = Rxn<String>();
  final ownerCnicBackPhoto = Rxn<String>();

  final zones = <Zone>[].obs;
  final routes = <RouteEntity>[].obs;
  final isLoadingZones = false.obs;
  final isLoadingRoutes = false.obs;
  final isSubmitting = false.obs;

  @override
  void onReady() {
    loadZones();
    loadRoutes();
    super.onReady();
  }

  void setShopName(String v) => shopName.value = v;
  void setOwnerName(String v) => ownerName.value = v;
  void setOwnerPhone(String v) => ownerPhone.value = v;
  void setGpsLat(String v) => gpsLat.value = v;
  void setGpsLng(String v) => gpsLng.value = v;
  void setCreditLimit(String v) => creditLimit.value = v;
  void setSelectedZoneId(int? v) {
    selectedZoneId.value = v;
  }

  void setSelectedRouteId(int? v) => selectedRouteId.value = v;
  void setOwnerCnicFrontPhoto(String? v) => ownerCnicFrontPhoto.value = v;
  void setOwnerCnicBackPhoto(String? v) => ownerCnicBackPhoto.value = v;

  Future<void> loadZones() async {
    isLoadingZones.value = true;
    try {
      final list = await _zoneUseCase.getZones();
      zones.assignAll(list);
    } catch (_) {
      zones.clear();
    } finally {
      isLoadingZones.value = false;
    }
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
      AppToast.showError('Error', 'Please log in again');
      return;
    }
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());
    final credit = double.tryParse(creditLimit.value.trim());
    if (shopName.value.trim().isEmpty ||
        ownerName.value.trim().isEmpty ||
        ownerPhone.value.trim().isEmpty ||
        lat == null ||
        lng == null ||
        selectedZoneId.value == null ||
        selectedRouteId.value == null ||
        credit == null ||
        credit < 0 ||
        ownerCnicFrontPhoto.value == null ||
        ownerCnicFrontPhoto.value!.isEmpty ||
        ownerCnicBackPhoto.value == null ||
        ownerCnicBackPhoto.value!.isEmpty) {
      AppToast.showError(
        'Error',
        'Please fill all required fields including CNIC photos',
      );
      return;
    }
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
      AppToast.showError('Error', 'Could not read CNIC photos');
      return;
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
        zoneId: selectedZoneId.value!,
        routeId: selectedRouteId.value!,
        creditLimit: credit,
        ownerCnicFrontPhoto: frontBase64,
        ownerCnicBackPhoto: backBase64,
      );
      Get.back<void>();
      AppToast.showSuccess('Success', 'Shop registered successfully');
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isSubmitting.value = false;
    }
  }
}
