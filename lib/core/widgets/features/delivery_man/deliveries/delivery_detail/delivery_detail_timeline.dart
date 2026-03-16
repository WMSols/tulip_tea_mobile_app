import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/data/models/delivery/delivery_model.dart';

/// Reusable delivery timeline: pickup, delivered, returned dates (or empty state).
class DeliveryDetailTimeline extends StatelessWidget {
  const DeliveryDetailTimeline({super.key, required this.delivery});

  final DeliveryModel delivery;

  @override
  Widget build(BuildContext context) {
    final hasPickup = delivery.pickupDate != null;
    final hasDelivery = delivery.deliveryDate != null;
    final hasReturn = delivery.returnDate != null;
    if (!hasPickup && !hasDelivery && !hasReturn) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.verticalValue(context, 0.01),
        ),
        child: Text(
          AppTexts.noTimelineEvents,
          style: AppTextStyles.hintText(context),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (delivery.pickupDate != null)
          _TimelineRow(
            label: AppTexts.pickupAtLabel,
            date: AppFormatter.dateTime(delivery.pickupDate!),
          ),
        if (delivery.deliveryDate != null) ...[
          if (delivery.pickupDate != null) AppSpacing.vertical(context, 0.008),
          _TimelineRow(
            label: AppTexts.deliveredAtLabel,
            date: AppFormatter.dateTime(delivery.deliveryDate!),
          ),
        ],
        if (delivery.returnDate != null) ...[
          if (delivery.deliveryDate != null)
            AppSpacing.vertical(context, 0.008),
          _TimelineRow(
            label: AppTexts.returnedAtLabel,
            date: AppFormatter.dateTime(delivery.returnDate!),
          ),
        ],
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.label, required this.date});

  final String label;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Iconsax.tick_circle,
          size: AppResponsive.iconSize(context, factor: 0.9),
          color: AppColors.success,
        ),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Text('$label: $date', style: AppTextStyles.bodyText(context)),
        ),
      ],
    );
  }
}
