import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Visit type multi-select chips with required label.
class VisitTypeChips extends StatelessWidget {
  const VisitTypeChips({super.key, required this.controller});

  final VisitRegisterController controller;

  static final List<(String label, String value)> _options = [
    (AppTexts.orderBooking, 'order_booking'),
    (AppTexts.dailyCollections, 'daily_collections'),
    (AppTexts.inspection, 'inspection'),
    (AppTexts.other, 'other'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppFormFieldLabel(label: AppTexts.selectVisitTypes, required: true),
        Obx(() {
          return Wrap(
            spacing: AppSpacing.horizontalValue(context, 0.02),
            runSpacing: AppSpacing.verticalValue(context, 0.01),
            children: _options.map((e) {
              final selected = controller.selectedVisitTypes.contains(e.$2);
              return FilterChip(
                label: Text(e.$1),
                selected: selected,
                onSelected: (_) => controller.toggleVisitType(e.$2),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
