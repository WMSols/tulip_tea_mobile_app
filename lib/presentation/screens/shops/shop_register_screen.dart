import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_validators/app_validators.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_image_picker.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';
import 'package:tulip_tea_order_booker/domain/entities/zone.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shop_register_controller.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopRegisterController>();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            label: AppTexts.shopName,
            hint: AppTexts.shopName,
            prefixIcon: Iconsax.shop,
            onChanged: c.setShopName,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.shopName),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.ownerName,
            hint: AppTexts.ownerName,
            prefixIcon: Iconsax.user,
            onChanged: c.setOwnerName,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.ownerName),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.ownerPhone,
            hint: AppTexts.ownerPhone,
            prefixIcon: Iconsax.call,
            keyboardType: TextInputType.phone,
            onChanged: c.setOwnerPhone,
            validator: AppValidators.validatePhone,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.latitude,
            hint: AppTexts.gpsLocation,
            prefixIcon: Iconsax.location,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: c.setGpsLat,
            validator: AppValidators.validateLatitude,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.longitude,
            hint: AppTexts.gpsLocation,
            prefixIcon: Iconsax.location,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: c.setGpsLng,
            validator: AppValidators.validateLongitude,
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(() {
            Zone? selectedZone;
            if (c.selectedZoneId.value != null && c.zones.isNotEmpty) {
              try {
                selectedZone = c.zones.firstWhere(
                  (z) => z.id == c.selectedZoneId.value,
                );
              } catch (_) {}
            }
            return AppDropdown<Zone>(
              label: AppTexts.zone,
              hint: AppTexts.selectZone,
              value: selectedZone,
              items: c.zones,
              getLabel: (z) => z.name,
              onChanged: (z) => c.setSelectedZoneId(z?.id),
              validator: (v) => v == null
                  ? AppValidators.validateRequired(null, AppTexts.zone)
                  : null,
            );
          }),
          AppSpacing.vertical(context, 0.02),
          Obx(() {
            RouteEntity? selectedRoute;
            if (c.selectedRouteId.value != null && c.routes.isNotEmpty) {
              try {
                selectedRoute = c.routes.firstWhere(
                  (r) => r.id == c.selectedRouteId.value,
                );
              } catch (_) {}
            }
            return AppDropdown<RouteEntity>(
              label: AppTexts.route,
              hint: AppTexts.selectRoute,
              value: selectedRoute,
              items: c.routes,
              getLabel: (r) => r.name,
              onChanged: (r) => c.setSelectedRouteId(r?.id),
              validator: (v) => v == null
                  ? AppValidators.validateRequired(null, AppTexts.route)
                  : null,
            );
          }),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.creditLimit,
            hint: AppTexts.creditLimit,
            prefixIcon: Iconsax.wallet_3,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: c.setCreditLimit,
            validator: (v) =>
                AppValidators.validatePositiveNumber(v, AppTexts.creditLimit),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppImagePicker(
              label: AppTexts.ownerCnicFront,
              currentPath: c.ownerCnicFrontPhoto.value,
              onPicked: c.setOwnerCnicFrontPhoto,
              onRemove: () => c.setOwnerCnicFrontPhoto(null),
              validator: (v) => (v == null || v.isEmpty)
                  ? '${AppTexts.ownerCnicFront} is required'
                  : null,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppImagePicker(
              label: AppTexts.ownerCnicBack,
              currentPath: c.ownerCnicBackPhoto.value,
              onPicked: c.setOwnerCnicBackPhoto,
              onRemove: () => c.setOwnerCnicBackPhoto(null),
              validator: (v) => (v == null || v.isEmpty)
                  ? '${AppTexts.ownerCnicBack} is required'
                  : null,
            ),
          ),
          AppSpacing.vertical(context, 0.03),
          Obx(
            () => AppButton(
              label: AppTexts.submit,
              onPressed: c.submit,
              isLoading: c.isSubmitting.value,
              icon: Iconsax.tick_circle,
              iconPosition: IconPosition.right,
            ),
          ),
          AppSpacing.vertical(context, 0.03),
        ],
      ),
    );
  }
}
