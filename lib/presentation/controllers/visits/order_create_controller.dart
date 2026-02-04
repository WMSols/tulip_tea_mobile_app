import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_order_booker/domain/entities/product.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/repositories/order_repository.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/product_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';

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

  @override
  void onReady() {
    loadShops();
    loadProducts();
    if (orderLines.isEmpty) addLine();
    super.onReady();
  }

  void setSelectedShopId(int? v) => selectedShopId.value = v;
  void setScheduledDate(String v) => scheduledDate.value = v;

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
    if (index >= 0 && index < orderLines.length)
      orderLines[index].unitPrice = v;
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
      AppToast.showError('Error', 'Please log in again');
      return;
    }
    if (selectedShopId.value == null) {
      AppToast.showError('Error', 'Please select a shop');
      return;
    }
    final validLines = orderLines
        .where((l) => l.product != null && l.quantity > 0 && l.unitPrice >= 0)
        .toList();
    if (validLines.isEmpty) {
      AppToast.showError(
        'Error',
        'Add at least one product with quantity and unit price',
      );
      return;
    }
    isSubmitting.value = true;
    try {
      await _orderUseCase.createOrder(
        orderBookerId: user.orderBookerId,
        shopId: selectedShopId.value!,
        orderItems: validLines
            .map(
              (l) => OrderItemInput(
                productName: l.product!.name,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ),
            )
            .toList(),
        scheduledDate: scheduledDate.value.trim().isEmpty
            ? null
            : scheduledDate.value.trim(),
      );
      orderLines.clear();
      addLine();
      AppToast.showSuccess('Success', 'Order created');
    } catch (e) {
      AppToast.showError('Error', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isSubmitting.value = false;
    }
  }
}
