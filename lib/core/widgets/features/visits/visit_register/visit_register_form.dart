import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/collection_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/order_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/shop_credit_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/shop_dropdown_section.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/visit_time_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/visit_type_chips.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_section_text/app_form_section_text.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_image_picker/app_image_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_location_picker/app_location_picker.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Full Register Visit form per flow: shop (today's tasks), credit info card,
/// visit types, order/collection sections, GPS, visit time, photo, reason.
class VisitRegisterForm extends StatelessWidget {
  const VisitRegisterForm({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final VisitRegisterController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Obx(
      () => Column(
        key: ValueKey(c.formResetKey.value),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        AppSpacing.vertical(context, 0.01),
        Text(
          AppTexts.registerVisitDescription,
          style: AppTextStyles.hintText(
            context,
          ).copyWith(color: AppColors.primary),
        ),
        AppSpacing.vertical(context, 0.02),
        ShopDropdownSection(controller: c),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          final isLoading = c.isLoadingCreditInfo.value;
          final info = c.shopCreditInfo.value;
          final hasShopSelected = c.selectedShopId.value != null;
          if (!hasShopSelected) return const SizedBox.shrink();
          if (isLoading) {
            return AppSectionCard(
              icon: Iconsax.wallet_money,
              title: AppTexts.shopCreditInformation,
              titleColor: AppColors.primary,
              child: Center(
                child: Padding(
                  padding: AppSpacing.symmetric(context, v: 0.03),
                  child: SizedBox(
                    width: AppResponsive.scaleSize(context, 36),
                    height: AppResponsive.scaleSize(context, 36),
                    child: Lottie.asset(AppLotties.loadingPrimary),
                  ),
                ),
              ),
            );
          }
          if (info == null) return const SizedBox.shrink();
          return ShopCreditInfoCard(info: info);
        }),
        AppSpacing.vertical(context, 0.02),
        VisitTypeChips(controller: c),
        AppSpacing.vertical(context, 0.015),
        AppFormSectionText(AppTexts.selectMultipleVisitTypesHint),
        AppSpacing.vertical(context, 0.02),
        Obx(() {
          if (!c.selectedVisitTypes.contains('order_booking')) {
            return const SizedBox.shrink();
          }
          return OrderSection(controller: c);
        }),
        Obx(() {
          if (!c.selectedVisitTypes.contains('daily_collections')) {
            return const SizedBox.shrink();
          }
          return CollectionSection(controller: c);
        }),
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
        AppSpacing.vertical(context, 0.02),
        VisitTimeField(controller: c),
        AppSpacing.vertical(context, 0.02),
        Obx(
          () => AppImagePicker(
            label: AppTexts.photoOptional,
            required: false,
            currentPath: c.photoPath.value.isEmpty ? null : c.photoPath.value,
            onPicked: c.setPhotoPath,
            onRemove: () => c.setPhotoPath(null),
            heroTag: 'visit_register_photo',
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        AppFormSectionText(AppTexts.uploadPhotoProofVisit),
        AppSpacing.vertical(context, 0.02),
        AppTextField(
          label: AppTexts.reason,
          hint: AppTexts.reasonForVisit,
          prefixIcon: Iconsax.note,
          maxLines: 2,
          onChanged: c.setReason,
        ),
        AppSpacing.vertical(context, 0.03),
        Obx(
          () => AppButton(
            label: AppTexts.registerVisitButton,
            onPressed: c.shouldDisableRegisterVisit
                ? null
                : () {
                    if (formKey.currentState?.validate() ?? true) c.submit();
                  },
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
