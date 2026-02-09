import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown_field/dropdown_loading_placeholder.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_image_picker/app_image_picker.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/route_entity.dart';
import 'package:tulip_tea_order_booker/domain/entities/zone.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shop_register_controller.dart';

/// Reusable shop registration form: shop details, location picker, zone/route, CNIC, submit.
class ShopRegisterForm extends StatelessWidget {
  const ShopRegisterForm({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final ShopRegisterController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: AppTexts.shopName,
          hint: AppTexts.shopName,
          required: true,
          prefixIcon: Iconsax.shop,
          onChanged: c.setShopName,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.ownerName,
          hint: AppTexts.ownerName,
          required: true,
          prefixIcon: Iconsax.user,
          onChanged: c.setOwnerName,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.ownerPhone,
          hint: AppTexts.ownerPhone,
          required: true,
          prefixIcon: Iconsax.call,
          keyboardType: TextInputType.phone,
          onChanged: c.setOwnerPhone,
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          if (c.isLoadingZones.value) {
            return DropdownLoadingPlaceholder(
              label: AppTexts.zoneOptional,
              hint: AppTexts.loadingZones,
              prefixIcon: Iconsax.map_1,
            );
          }
          Zone? selectedZone;
          if (c.selectedZoneId.value != null && c.zones.isNotEmpty) {
            try {
              selectedZone = c.zones.firstWhere(
                (z) => z.id == c.selectedZoneId.value,
              );
            } catch (_) {}
          }
          return AppDropdown<Zone>(
            label: AppTexts.zoneOptional,
            hint: AppTexts.selectZone,
            required: false,
            value: selectedZone,
            items: c.zones,
            getLabel: (z) => z.name,
            onChanged: (z) => c.setSelectedZoneId(z?.id),
            prefixIcon: Iconsax.map_1,
          );
        }),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          if (c.isLoadingRoutes.value) {
            return DropdownLoadingPlaceholder(
              label: AppTexts.routeOptional,
              hint: AppTexts.loadingRoutes,
              prefixIcon: Iconsax.routing,
            );
          }
          RouteEntity? selectedRoute;
          if (c.selectedRouteId.value != null && c.routes.isNotEmpty) {
            try {
              selectedRoute = c.routes.firstWhere(
                (r) => r.id == c.selectedRouteId.value,
              );
            } catch (_) {}
          }
          return AppDropdown<RouteEntity>(
            label: AppTexts.routeOptional,
            hint: AppTexts.selectRoute,
            required: false,
            value: selectedRoute,
            items: c.routes,
            getLabel: (r) => r.name,
            onChanged: (r) => c.setSelectedRouteId(r?.id),
            prefixIcon: Iconsax.routing,
          );
        }),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.creditLimitOptional,
          hint: AppTexts.creditLimit,
          prefixIcon: Iconsax.wallet_3,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: c.setCreditLimit,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.legacyBalance,
          hint: AppTexts.legacyBalance,
          prefixIcon: Iconsax.empty_wallet_time,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: c.setLegacyBalance,
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppImagePicker(
            label: AppTexts.ownerPhotoLabel,
            required: false,
            currentPath: c.ownerPhoto.value,
            onPicked: c.setOwnerPhoto,
            onRemove: () => c.setOwnerPhoto(null),
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppImagePicker(
            label: AppTexts.ownerCnicFront,
            required: true,
            currentPath: c.ownerCnicFrontPhoto.value,
            onPicked: c.setOwnerCnicFrontPhoto,
            onRemove: () => c.setOwnerCnicFrontPhoto(null),
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppImagePicker(
            label: AppTexts.ownerCnicBack,
            required: true,
            currentPath: c.ownerCnicBackPhoto.value,
            onPicked: c.setOwnerCnicBackPhoto,
            onRemove: () => c.setOwnerCnicBackPhoto(null),
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppImagePicker(
            label: AppTexts.shopExteriorPhotoLabel,
            required: false,
            currentPath: c.shopExteriorPhoto.value,
            onPicked: c.setShopExteriorPhoto,
            onRemove: () => c.setShopExteriorPhoto(null),
          ),
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppLocationPicker(
            label: AppTexts.gpsLocation,
            required: true,
            lat: c.gpsLat.value,
            lng: c.gpsLng.value,
            onLocationSelected: (lat, lng) {
              c.setGpsLat(lat.toString());
              c.setGpsLng(lng.toString());
            },
            onLocationCleared: () {
              c.setGpsLat('');
              c.setGpsLng('');
            },
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        Obx(
          () => AppButton(
            label: AppTexts.submit,
            onPressed: () {
              c.submit();
            },
            isLoading: c.isSubmitting.value,
            icon: Iconsax.tick_circle,
            iconPosition: IconPosition.right,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
      ],
    );
  }
}
