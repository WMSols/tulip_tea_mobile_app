import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for a single shop in My Shops list: icon, title + status chip, subtitle, credit info, trailing arrow.
/// For rejected shops, shows an edit button at bottom-right. On tap navigates to [MyShopDetailsScreen].
class MyShopsCard extends StatelessWidget {
  const MyShopsCard({super.key, required this.shop});

  final Shop shop;

  static bool _isRejected(Shop s) {
    final status = s.registrationStatus?.toLowerCase().trim() ?? '';
    return status == 'rejected';
  }

  @override
  Widget build(BuildContext context) {
    final creditStr = shop.creditLimit != null
        ? '${AppTexts.rupeeSymbol} ${shop.creditLimit!.toStringAsFixed(0)}'
        : '–';
    final availableStr = shop.availableCredit != null
        ? '${AppTexts.rupeeSymbol} ${shop.availableCredit!.toStringAsFixed(0)}'
        : '–';
    final status = shop.registrationStatus ?? '';
    final isRejected = _isRejected(shop);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.myShopDetails, arguments: shop),
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Padding(
            padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              shop.name,
                              style: AppTextStyles.bodyText(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          if (status.isNotEmpty) AppStatusChip(status: status),
                          if (isRejected)
                            Padding(
                              padding: AppSpacing.symmetric(
                                context,
                                h: 0.02,
                                v: 0,
                              ).copyWith(right: 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: AppIconButton(
                                  icon: Iconsax.edit_2,
                                  backgroundColor: AppColors.error,
                                  color: AppColors.white,
                                  onPressed: () => Get.toNamed(
                                    AppRoutes.shopEdit,
                                    arguments: shop,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        shop.ownerName.isNotEmpty ? shop.ownerName : '–',
                        style: AppTextStyles.hintText(
                          context,
                        ).copyWith(color: AppColors.black),
                      ),
                      Text(
                        '${AppTexts.creditLimit}: $creditStr',
                        style: AppTextStyles.hintText(context).copyWith(
                          fontSize: AppResponsive.screenWidth(context) * 0.032,
                        ),
                      ),
                      Text(
                        '${AppTexts.availableCredit}: $availableStr',
                        style: AppTextStyles.hintText(context).copyWith(
                          fontSize: AppResponsive.screenWidth(context) * 0.032,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  size: AppResponsive.iconSize(context, factor: 1.1),
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
