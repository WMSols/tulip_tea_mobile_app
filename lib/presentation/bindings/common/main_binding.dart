import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/presentation/bindings/common/account_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_dashboard_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_deliveries_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_orders_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/delivery_man/delivery_man_warehouses_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/credit_limits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/dashboard_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/shops_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/bindings/order_booker/visits_binding.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/common/main/main_shell_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainShellController>(() => MainShellController());
    // Register tab bindings so controllers are available when switching tabs
    ShopsBinding().dependencies();
    VisitsBinding().dependencies();
    CreditLimitsBinding().dependencies();
    OrderBookerDashboardBinding().dependencies();
    DeliveryManDashboardBinding().dependencies();
    DeliveryManOrdersBinding().dependencies();
    DeliveryManDeliveriesBinding().dependencies();
    DeliveryManWarehousesBinding().dependencies();
    AccountBinding().dependencies();
  }
}
