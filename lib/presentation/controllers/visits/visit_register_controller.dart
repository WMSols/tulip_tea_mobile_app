import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';
import 'package:tulip_tea_mobile_app/domain/entities/visit_task.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/product_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/route_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_visit_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_history_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visits_controller.dart';

class VisitOrderLineInput {
  VisitOrderLineInput({this.product, this.quantity = 1, this.unitPrice = 0});
  Product? product;
  int quantity;
  double unitPrice;
}

/// For shop dropdown (today's tasks or approved shops).
class ShopOption {
  const ShopOption(this.id, this.name);
  final int id;
  final String name;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ShopOption && id == other.id);
  @override
  int get hashCode => id.hashCode;
}

/// Order resolution: "normal" | "payment_before_delivery" (no subsidy).
const String orderResolutionNormal = 'normal';
const String orderResolutionPaymentBeforeDelivery = 'payment_before_delivery';

class VisitRegisterController extends GetxController {
  VisitRegisterController(
    this._authUseCase,
    this._shopUseCase,
    this._productUseCase,
    this._shopVisitUseCase,
    this._routeUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final ProductUseCase _productUseCase;
  final ShopVisitUseCase _shopVisitUseCase;
  final RouteUseCase _routeUseCase;

  final todayTasks = <VisitTask>[].obs;
  final shops = <Shop>[].obs;
  final products = <Product>[].obs;
  final isLoadingShops = false.obs;
  final isLoadingProducts = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final shopCreditInfo = Rxn<ShopCreditInfo>();
  final isLoadingCreditInfo = false.obs;
  final selectedVisitTypes = <String>[].obs;
  final gpsLat = ''.obs;
  final gpsLng = ''.obs;
  final reason = ''.obs;
  final orderLines = <VisitOrderLineInput>[].obs;

  /// Order: scheduled date (display string), final total amount, resolution type.
  final scheduledDeliveryDate = ''.obs;
  final finalTotalAmount = ''.obs;
  final finalAmountController = TextEditingController();
  final orderResolutionType = orderResolutionNormal.obs;

  /// Collection (no link to order).
  final collectionAmount = ''.obs;
  final collectionRemarks = ''.obs;

  /// Visit time from picker; photo file path (converted to base64 on submit).
  final visitTime = Rxn<DateTime>();
  final photoPath = ''.obs;

  /// Incremented on form reset to force rebuild and clear uncontrolled fields.
  final formResetKey = 0.obs;

  static const List<String> visitTypeOptions = [
    'order_booking',
    'daily_collections',
    'inspection',
    'other',
  ];

  /// Unique shop options for dropdown: from today's visit tasks only.
  List<ShopOption> get shopDropdownOptions {
    if (todayTasks.isEmpty) return [];
    final seen = <int>{};
    return todayTasks
        .where((t) => seen.add(t.shopId))
        .map((t) => ShopOption(t.shopId, t.shopName ?? 'Shop #${t.shopId}'))
        .toList();
  }

  ShopOption? get selectedShopOption {
    final id = selectedShopId.value;
    if (id == null) return null;
    try {
      return shopDropdownOptions.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Today's unique shop count and route count (for hint).
  int get todayShopsCount {
    if (todayTasks.isEmpty) return 0;
    return todayTasks.map((t) => t.shopId).toSet().length;
  }

  int get todayRoutesCount {
    if (todayTasks.isEmpty) return 0;
    return todayTasks
        .map((t) => t.routeName ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .length;
  }

  /// Calculated total from order lines.
  double get calculatedOrderTotal {
    double sum = 0;
    for (final line in orderLines) {
      if (line.product != null && line.quantity > 0) {
        sum += line.quantity * (line.unitPrice);
      }
    }
    return sum;
  }

  /// Effective order total: parsed final amount or calculated total.
  double get effectiveOrderTotal {
    final finalVal = double.tryParse(finalTotalAmount.value.trim());
    if (finalVal != null && finalVal > 0) return finalVal;
    return calculatedOrderTotal;
  }

  /// True when Register Visit should be disabled: order_booking selected,
  /// credit insufficient, and normal delivery chosen (can't place normal order).
  bool get shouldDisableRegisterVisit {
    if (!selectedVisitTypes.contains('order_booking')) return false;
    final info = shopCreditInfo.value;
    if (info == null) return false;
    final availableCredit = info.availableCredit ?? 0;
    if (effectiveOrderTotal <= availableCredit) return false;
    return orderResolutionType.value == orderResolutionNormal;
  }

  @override
  void onReady() {
    loadShopsAndTasks();
    loadProducts();
    super.onReady();
  }

  /// Reload shops/tasks and products. Call on pull-to-refresh.
  Future<void> refreshData() async {
    await Future.wait([loadShopsAndTasks(), loadProducts()]);
  }

  void setSelectedShopId(int? v) {
    selectedShopId.value = v;
    shopCreditInfo.value = null;
    if (v != null) loadCreditInfo(v);
  }

  void setOrderResolutionType(String v) => orderResolutionType.value = v;
  void setScheduledDeliveryDate(String v) => scheduledDeliveryDate.value = v;
  void setFinalTotalAmount(String v) => finalTotalAmount.value = v;
  void setCollectionAmount(String v) => collectionAmount.value = v;
  void setCollectionRemarks(String v) => collectionRemarks.value = v;
  void setVisitTime(DateTime? v) => visitTime.value = v;
  void setPhotoPath(String? v) => photoPath.value = v ?? '';

  void toggleVisitType(String type) {
    if (selectedVisitTypes.contains(type)) {
      selectedVisitTypes.remove(type);
    } else {
      selectedVisitTypes.add(type);
    }
  }

  void setGpsLat(String v) => gpsLat.value = v;
  void setGpsLng(String v) => gpsLng.value = v;
  void setReason(String v) => reason.value = v;

  void addOrderLine() => orderLines.add(VisitOrderLineInput());
  void removeOrderLine(int index) {
    if (index >= 0 && index < orderLines.length) orderLines.removeAt(index);
  }

  void setLineProduct(int index, Product? p) {
    if (index >= 0 && index < orderLines.length) {
      orderLines[index].product = p;
      if (p?.unitPrice != null) orderLines[index].unitPrice = p!.unitPrice!;
      orderLines.refresh();
    }
  }

  void setLineQuantity(int index, int q) {
    if (index >= 0 && index < orderLines.length) {
      orderLines[index].quantity = q;
      orderLines.refresh();
    }
  }

  void setLineUnitPrice(int index, double v) {
    if (index >= 0 && index < orderLines.length) {
      orderLines[index].unitPrice = v;
    }
  }

  void resetFinalAmountToCalculated() {
    final value = calculatedOrderTotal.toStringAsFixed(2);
    finalTotalAmount.value = value;
    finalAmountController.text = value;
  }

  /// Clears the final order amount field (Reset button).
  void clearFinalAmount() {
    finalTotalAmount.value = '';
    finalAmountController.clear();
  }

  /// Clears all form fields and dropdowns after successful register visit.
  void resetForm() {
    selectedShopId.value = null;
    shopCreditInfo.value = null;
    selectedVisitTypes.clear();
    gpsLat.value = '';
    gpsLng.value = '';
    reason.value = '';
    orderLines.clear();
    scheduledDeliveryDate.value = '';
    finalTotalAmount.value = '';
    finalAmountController.clear();
    orderResolutionType.value = orderResolutionNormal;
    collectionAmount.value = '';
    collectionRemarks.value = '';
    visitTime.value = null;
    photoPath.value = '';
    formResetKey.value++;
  }

  @override
  void onClose() {
    finalAmountController.dispose();
    super.onClose();
  }

  Future<void> loadShopsAndTasks() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoadingShops.value = true;
    try {
      // 1. Get weekly schedules (route + day_of_week) for this order booker
      final schedules = await _routeUseCase.getWeeklySchedulesByOrderBooker(
        user.orderBookerId,
      );
      // 2. Filter by today's weekday. Backend (Python datetime.weekday) uses
      // Mon=0..Sun=6. Dart uses Mon=1..Sun=7, so backend_day = dartWeekday - 1.
      final dartWeekday = DateTime.now().weekday;
      final backendDayOfWeek = dartWeekday - 1; // 0=Mon, 6=Sun
      final todaySchedules = schedules
          .where((s) => s.isActive && s.dayOfWeek == backendDayOfWeek)
          .toList();
      final todayRouteIds = todaySchedules.map((s) => s.routeId).toSet();
      final routeIdToName = {
        for (final s in todaySchedules)
          s.routeId: s.routeName ?? 'Route #${s.routeId}',
      };
      // 3. Get shops for order booker (approved only)
      final allShops = await _shopUseCase.getShopsByOrderBooker(
        user.orderBookerId,
        approvedOnly: true,
      );
      // 4. Filter shops that belong to today's scheduled routes.
      // Fallback: if no shops have route_id but we have schedules, show all shops
      // (shops may not have route populated in API, or link is via zone/assignee).
      var filteredShops = allShops.where((s) {
        final rid = s.routeId;
        return rid != null && todayRouteIds.contains(rid);
      }).toList();
      if (filteredShops.isEmpty && todayRouteIds.isNotEmpty) {
        filteredShops = allShops;
      }
      // 5. Build visit tasks for dropdown (shopId, shopName, routeName)
      final tasks = filteredShops
          .map(
            (s) => VisitTask(
              id: s.id,
              shopId: s.id,
              shopName: s.name,
              routeName: s.routeId != null ? routeIdToName[s.routeId] : null,
            ),
          )
          .toList();
      todayTasks.assignAll(tasks);
      shops.clear();
    } catch (_) {
      todayTasks.clear();
      shops.clear();
    } finally {
      isLoadingShops.value = false;
    }
  }

  Future<void> loadCreditInfo(int shopId) async {
    isLoadingCreditInfo.value = true;
    try {
      final info = await _shopUseCase.getShopCreditInfo(shopId);
      shopCreditInfo.value = info;
    } catch (_) {
      shopCreditInfo.value = null;
    } finally {
      isLoadingCreditInfo.value = false;
    }
  }

  Future<void> loadProducts() async {
    final user = await _authUseCase.getCurrentUser();
    isLoadingProducts.value = true;
    try {
      final list = await _productUseCase.getActiveProducts(
        distributorId: user?.distributorId,
      );
      products.assignAll(list);
    } catch (_) {
      products.clear();
    } finally {
      isLoadingProducts.value = false;
    }
  }

  Future<void> submit() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    if (selectedVisitTypes.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseSelectShopAndVisitType);
      return;
    }
    final lat = double.tryParse(gpsLat.value.trim());
    final lng = double.tryParse(gpsLng.value.trim());

    List<OrderItemInput>? orderItems;
    String? scheduledDate;
    double? finalTotal;
    final hasOrderBooking = selectedVisitTypes.contains('order_booking');
    if (hasOrderBooking) {
      final validOrderLines = orderLines
          .where((l) => l.product != null && l.quantity > 0 && l.unitPrice >= 0)
          .toList();
      if (validOrderLines.isNotEmpty) {
        orderItems = validOrderLines
            .map(
              (l) => OrderItemInput(
                productId: l.product?.id,
                productName: l.product!.name,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ),
            )
            .toList();
        scheduledDate = AppHelper.isNullOrEmpty(scheduledDeliveryDate.value)
            ? null
            : scheduledDeliveryDate.value.trim();
        finalTotal = double.tryParse(finalTotalAmount.value.trim());
        if (finalTotal == null || finalTotal <= 0) {
          finalTotal = calculatedOrderTotal;
        }
      }
    }

    double? collAmount;
    String? collRemarks;
    if (selectedVisitTypes.contains('daily_collections')) {
      collAmount = double.tryParse(collectionAmount.value.trim());
      if (collAmount != null && collAmount >= 0) {
        collRemarks = AppHelper.isNullOrEmpty(collectionRemarks.value)
            ? null
            : collectionRemarks.value.trim();
      } else {
        collAmount = null;
      }
    }

    String? photoBase64;
    if (photoPath.value.isNotEmpty) {
      try {
        final file = File(photoPath.value);
        if (file.existsSync()) {
          final bytes = await file.readAsBytes();
          photoBase64 = 'data:image/jpeg;base64,${base64Encode(bytes)}';
        }
      } catch (_) {}
    }

    // If final order amount entered and credit sufficient, proceed with normal order
    // (not payment before delivery), regardless of radio selection
    var resolutionType = orderResolutionType.value;
    if (hasOrderBooking && finalTotal != null) {
      final availableCredit = shopCreditInfo.value?.availableCredit ?? 0;
      if (finalTotal <= availableCredit) {
        resolutionType = orderResolutionNormal;
      }
    }

    isSubmitting.value = true;
    try {
      // Backend expects visit_time from frontend; send current time if not captured
      final visitTimeStr = visitTime.value?.toIso8601String() ?? DateTime.now().toIso8601String();

      await _shopVisitUseCase.registerVisit(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value,
        visitTypes: selectedVisitTypes.toList(),
        gpsLat: lat,
        gpsLng: lng,
        visitTime: visitTimeStr,
        photo: photoBase64,
        reason: AppHelper.isNullOrEmpty(reason.value)
            ? null
            : reason.value.trim(),
        orderItems: orderItems,
        scheduledDate: scheduledDate,
        finalTotalAmount: finalTotal,
        orderResolutionType: resolutionType,
        collectionAmount: collAmount,
        collectionRemarks: collRemarks,
      );
      await Get.find<VisitHistoryController>().loadVisits();
      Get.find<VisitsController>().switchToVisitHistoryTab?.call();
      AppToast.showSuccess(
        AppTexts.success,
        AppTexts.visitRegisteredSuccessfully,
      );
      resetForm();
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
