import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/delivery_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/order_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/wallet_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/dashboard/delivery_man_dashboard_controller.dart';

class DeliveryManDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryManDashboardController>(
      () => DeliveryManDashboardController(
        Get.find<AuthUseCase>(),
        Get.find<WalletUseCase>(),
        Get.find<OrderUseCase>(),
        Get.find<DeliveryUseCase>(),
        Get.find<DailyCollectionUseCase>(),
      ),
    );
  }
}
