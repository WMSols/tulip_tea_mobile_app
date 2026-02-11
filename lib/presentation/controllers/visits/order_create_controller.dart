import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/domain/repositories/order_repository.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/product_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';

class OrderLineInput {
  OrderLineInput({this.product, this.quantity = 1, this.unitPrice = 0});

  Product? product;
  int quantity;
  double unitPrice;
}

class OrderCreateController extends GetxController {
  OrderCreateController(
    this._authUseCase,
    this._shopUseCase,
    this._productUseCase,
    this._orderUseCase,
  );

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;
  final ProductUseCase _productUseCase;
  final OrderUseCase _orderUseCase;

  final shops = <Shop>[].obs;
  final products = <Product>[].obs;
  final orderLines = <OrderLineInput>[].obs;
  final isLoadingShops = false.obs;
  final isLoadingProducts = false.obs;
  final isSubmitting = false.obs;

  final selectedShopId = Rxn<int>();
  final scheduledDate = ''.obs;
  final finalTotalAmount = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _ensureAuthThenLoad();
    if (orderLines.isEmpty) addLine();
  }

  /// Ensures token is in [AuthTokenHolder] before any API call so both
  /// shops and products requests send the Authorization header.
  Future<void> _ensureAuthThenLoad() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    loadShops();
    loadProducts();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setScheduledDate(String v) => scheduledDate.value = v;
  void setFinalTotalAmount(String v) => finalTotalAmount.value = v;

  void addLine() {
    orderLines.add(OrderLineInput());
  }

  void removeLine(int index) {
    if (index >= 0 && index < orderLines.length) orderLines.removeAt(index);
  }

  void setLineProduct(int index, Product? p) {
    if (index >= 0 && index < orderLines.length) {
      orderLines[index].product = p;
      if (p?.unitPrice != null) orderLines[index].unitPrice = p!.unitPrice!;
    }
  }

  void setLineQuantity(int index, int q) {
    if (index >= 0 && index < orderLines.length) orderLines[index].quantity = q;
  }

  void setLineUnitPrice(int index, double v) {
    if (index >= 0 && index < orderLines.length) {
      orderLines[index].unitPrice = v;
    }
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

  Future<void> loadProducts() async {
    isLoadingProducts.value = true;
    try {
      final list = await _productUseCase.getActiveProducts();
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
    if (selectedShopId.value == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseSelectShop);
      return;
    }
    final validLines = orderLines
        .where((l) => l.product != null && l.quantity > 0 && l.unitPrice >= 0)
        .toList();
    if (validLines.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.addAtLeastOneProduct);
      return;
    }
    final total = double.tryParse(finalTotalAmount.value.trim());
    isSubmitting.value = true;
    try {
      await _orderUseCase.createOrder(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value!,
        orderItems: validLines
            .map(
              (l) => OrderItemInput(
                productId: l.product?.id,
                productName: l.product!.name,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ),
            )
            .toList(),
        scheduledDate: scheduledDate.value.trim().isEmpty
            ? null
            : scheduledDate.value.trim(),
        finalTotalAmount: total != null && total > 0 ? total : null,
      );
      orderLines.clear();
      addLine();
      finalTotalAmount.value = '';
      AppToast.showSuccess(AppTexts.success, AppTexts.orderCreated);
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
