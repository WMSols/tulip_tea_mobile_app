import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_loading_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_image_picker/app_image_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_edit_controller.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_register_controller.dart';

/// Reusable shop registration form: shop details, location picker, zone/route, CNIC, submit.
/// When [isEditMode] is true, [editController] is used, fields are pre-filled, and resubmit is shown.
class ShopRegisterForm extends StatelessWidget {
  const ShopRegisterForm({
    super.key,
    this.controller,
    this.editController,
    required this.formKey,
    this.isEditMode = false,
  }) : assert(
         (controller != null && !isEditMode) ||
             (editController != null && isEditMode),
         'Provide controller when not edit mode, editController when edit mode',
       );

  final ShopRegisterController? controller;
  final ShopEditController? editController;
  final GlobalKey<FormState> formKey;
  final bool isEditMode;

  dynamic get _c => isEditMode ? editController! : controller!;

  @override
  Widget build(BuildContext context) {
    final c = _c;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: AppTexts.shopName,
          hint: AppTexts.shopName,
          required: true,
          prefixIcon: Iconsax.shop,
          controller: isEditMode
              ? (c as ShopEditController).shopNameController
              : null,
          onChanged: isEditMode ? null : c.setShopName,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.ownerName,
          hint: AppTexts.ownerName,
          required: true,
          prefixIcon: Iconsax.user,
          controller: isEditMode
              ? (c as ShopEditController).ownerNameController
              : null,
          onChanged: isEditMode ? null : c.setOwnerName,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.ownerPhone,
          hint: AppTexts.ownerPhone,
          required: true,
          prefixIcon: Iconsax.call,
          keyboardType: TextInputType.phone,
          controller: isEditMode
              ? (c as ShopEditController).ownerPhoneController
              : null,
          onChanged: isEditMode ? null : c.setOwnerPhone,
        ),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          if (c.isLoadingRoutes.value) {
            return AppDropdownFieldLoadingPlaceholder(
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
          return AppDropdownField<RouteEntity>(
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
          controller: isEditMode
              ? (c as ShopEditController).creditLimitController
              : null,
          onChanged: isEditMode ? null : c.setCreditLimit,
        ),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.legacyBalance,
          hint: AppTexts.legacyBalance,
          prefixIcon: Iconsax.empty_wallet_time,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          controller: isEditMode
              ? (c as ShopEditController).legacyBalanceController
              : null,
          onChanged: isEditMode ? null : c.setLegacyBalance,
        ),
        if (!isEditMode) ...[
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppImagePicker(
              label: AppTexts.ownerPhotoLabel,
              required: false,
              currentPath: c.ownerPhoto.value,
              onPicked: c.setOwnerPhoto,
              onRemove: () => c.setOwnerPhoto(null),
              heroTag: 'shop_register_owner_photo',
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
              heroTag: 'shop_register_cnic_front',
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
              heroTag: 'shop_register_cnic_back',
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
              heroTag: 'shop_register_shop_exterior',
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
        ],
        AppSpacing.vertical(context, 0.03),
        Obx(
          () => AppButton(
            label: isEditMode ? AppTexts.resubmit : AppTexts.submit,
            onPressed: () {
              if (isEditMode) {
                (c as ShopEditController).resubmit();
              } else {
                (c as ShopRegisterController).submit();
              }
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
