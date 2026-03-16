import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/delivery_man/deliveries/delivery_man_deliveries_controller.dart';

/// Holds a single [DeliveryListItem] from arguments. No API calls — use the order + delivery passed from the list.
class DeliveryManDeliveryDetailController extends GetxController {
  DeliveryManDeliveryDetailController();

  DeliveryListItem? get item {
    final args = Get.arguments;
    if (args is DeliveryListItem) return args;
    return null;
  }

  OrderForDeliveryMan? get orderOrItemOrder => item?.order;
  DeliveryModel? get deliveryOrItemDelivery => item?.delivery;
}
