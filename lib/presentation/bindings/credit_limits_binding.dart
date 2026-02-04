import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/credit_limit_request_use_case.dart';
import 'package:tulip_tea_order_booker/domain/use_cases/shop_use_case.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/credit_limit_request_controller.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/credit_limits_controller.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/credit_limits/my_requests_controller.dart';

class CreditLimitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditLimitsController>(() => CreditLimitsController());
    Get.lazyPut<CreditLimitRequestController>(
      () => CreditLimitRequestController(
        Get.find<AuthUseCase>(),
        Get.find<ShopUseCase>(),
        Get.find<CreditLimitRequestUseCase>(),
      ),
    );
    Get.lazyPut<MyRequestsController>(
      () => MyRequestsController(
        Get.find<AuthUseCase>(),
        Get.find<CreditLimitRequestUseCase>(),
      ),
    );
  }
}
