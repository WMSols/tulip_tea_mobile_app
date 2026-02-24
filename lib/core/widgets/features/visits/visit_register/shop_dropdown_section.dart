import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_loading_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_no_connection_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/no_routes_scheduled_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_section_text/app_form_section_text.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Shop selector: loading placeholder, empty state (no routes), or dropdown with hints.
class ShopDropdownSection extends StatelessWidget {
  const ShopDropdownSection({super.key, required this.controller});

  final VisitRegisterController controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final connectivity = Get.find<ConnectivityService>();
    return Obx(() {
      final isOffline = !connectivity.isOnline.value;
      if (isOffline &&
          (c.isLoadingShops.value || c.shopDropdownOptions.isEmpty)) {
        return AppDropdownFieldNoConnectionPlaceholder(
          label: AppTexts.selectShopOptional,
          required: false,
          prefixIcon: Iconsax.shop,
        );
      }
      if (c.isLoadingShops.value) {
        return AppDropdownFieldLoadingPlaceholder(
          label: AppTexts.selectShopOptional,
          hint: AppTexts.selectShop,
          required: false,
          prefixIcon: Iconsax.shop,
        );
      }
      final options = c.shopDropdownOptions;
      if (options.isEmpty) {
        final dayName = AppFormatter.dayNameFull(DateTime.now().weekday);
        final message = AppTexts.noRoutesScheduledForTodayContactDistributor
            .replaceAll('%s', dayName);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NoRoutesScheduledPlaceholder(
              message: message,
              onRetry: () => c.loadShopsAndTasks(),
            ),
            AppSpacing.vertical(context, 0.008),
            AppFormSectionText(AppTexts.onlyShopsFromRoutesScheduledToday),
            AppFormSectionText(message),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDropdownField<ShopOption>(
            label: AppTexts.selectShopOptional,
            hint: AppTexts.selectShop,
            required: false,
            value: c.selectedShopOption,
            items: options,
            getLabel: (o) => o.name,
            onChanged: (o) => c.setSelectedShopId(o?.id),
            prefixIcon: Iconsax.shop,
          ),
          if (c.todayTasks.isNotEmpty) ...[
            AppSpacing.vertical(context, 0.008),
            AppFormSectionText(AppTexts.onlyShopsFromRoutesScheduledToday),
            AppFormSectionText(
              AppFormatter.todayShopsHint(
                AppFormatter.dayNameShort(DateTime.now().weekday),
                c.todayShopsCount,
                c.todayRoutesCount,
              ),
            ),
          ],
        ],
      );
    });
  }
}
