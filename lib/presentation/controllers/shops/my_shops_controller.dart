import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';

class MyShopsController extends GetxController {
  MyShopsController(this._authUseCase, this._shopUseCase);

  final AuthUseCase _authUseCase;
  final ShopUseCase _shopUseCase;

  final shops = <Shop>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    loadShops();
    super.onReady();
  }

  Future<void> loadShops() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    isLoading.value = true;
    try {
      final list = await _shopUseCase.getShopsByOrderBooker(user.orderBookerId);
      shops.assignAll(list);
    } catch (_) {
      shops.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
