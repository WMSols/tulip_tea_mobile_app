import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Scheduled delivery date tap-to-pick field (date + time, min tomorrow).
/// Stores ISO string; displays and picker initial use selected value when present.
class ScheduledDateField extends StatelessWidget {
  const ScheduledDateField({super.key, required this.controller});

  final VisitRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final s = controller.scheduledDeliveryDate.value;
      final parsed = AppHelper.parseDateTimeOrNull(s);
      final tomorrow = AppHelper.tomorrow;
      final display = parsed != null ? AppFormatter.dateTime(parsed) : '';
      final initial = parsed != null && !parsed.isBefore(tomorrow)
          ? parsed
          : tomorrow;
      return AppDateDisplayField(
        label: AppTexts.scheduledDeliveryDate,
        value: display,
        placeholder: AppTexts.deliveryDate,
        onTap: () async {
          final picked = await AppDateTimePicker.show(
            context,
            title: AppTexts.deliveryDate,
            initial: initial,
            minDate: tomorrow,
          );
          if (picked != null) {
            controller.setScheduledDeliveryDate(picked.toIso8601String());
          }
        },
      );
    });
  }
}
