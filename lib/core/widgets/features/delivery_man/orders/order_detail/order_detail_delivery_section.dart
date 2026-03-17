import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_detail_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';

/// Delivery status and timeline section when delivery exists.
class OrderDetailDeliverySection extends StatelessWidget {
  const OrderDetailDeliverySection({super.key, required this.delivery});

  final DeliveryModel delivery;

  static String _statusDisplayText(String? status) {
    if (status == null || status.isEmpty) return AppTexts.dateTimeUnset;
    return AppHelper.dmDeliveryStatusLabel(status);
  }

  @override
  Widget build(BuildContext context) {
    final statusDisplay = _statusDisplayText(delivery.status);
    return AppSectionCard(
      icon: Iconsax.truck,
      title: AppTexts.deliverySectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDetailRow(
            icon: Iconsax.info_circle,
            label: AppTexts.status,
            value: statusDisplay,
            valueChild: AppStatusChip(
              status: delivery.status ?? '',
              text: statusDisplay,
            ),
          ),
          if (delivery.pickupDate != null)
            AppDetailRow(
              icon: Iconsax.box_tick,
              label: AppTexts.pickupAtLabel,
              value: AppFormatter.dateTime(delivery.pickupDate!),
            ),
          if (delivery.deliveryDate != null)
            AppDetailRow(
              icon: Iconsax.tick_circle,
              label: AppTexts.deliveredAtLabel,
              value: AppFormatter.dateTime(delivery.deliveryDate!),
            ),
          if (delivery.returnDate != null)
            AppDetailRow(
              icon: Iconsax.arrow_left,
              label: AppTexts.returnedAtLabel,
              value: AppFormatter.dateTime(delivery.returnDate!),
            ),
        ],
      ),
    );
  }
}
