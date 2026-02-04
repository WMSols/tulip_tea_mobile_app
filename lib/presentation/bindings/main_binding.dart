import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/presentation/bindings/account_binding.dart';
import 'package:tulip_tea_order_booker/presentation/bindings/credit_limits_binding.dart';
import 'package:tulip_tea_order_booker/presentation/bindings/dashboard_binding.dart';
import 'package:tulip_tea_order_booker/presentation/bindings/shops_binding.dart';
import 'package:tulip_tea_order_booker/presentation/bindings/visits_binding.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/main/main_shell_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainShellController>(() => MainShellController());
    // Register tab bindings so controllers are available when switching tabs
    ShopsBinding().dependencies();
    VisitsBinding().dependencies();
    CreditLimitsBinding().dependencies();
    DashboardBinding().dependencies();
    AccountBinding().dependencies();
  }
}
