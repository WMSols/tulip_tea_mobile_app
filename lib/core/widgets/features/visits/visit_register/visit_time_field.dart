import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Visit time tap-to-capture field: on tap sets current date/time (no picker).
class VisitTimeField extends StatelessWidget {
  const VisitTimeField({super.key, required this.controller});

  final VisitRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final c = controller;
      final dt = c.visitTime.value;
      final display = dt != null ? AppFormatter.dateTime(dt) : '';
      return AppDateDisplayField(
        label: AppTexts.selectVisitTime,
        value: display,
        placeholder: AppTexts.tapToCaptureCurrentTime,
        onTap: () {
          c.setVisitTime(DateTime.now());
        },
      );
    });
  }
}
