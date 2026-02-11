import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/shops/my_shop_details/my_shop_details_content.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Displays full shop details: account-style rows only (no photos or location sections).
/// For rejected shops, app bar shows a trailing edit [AppIconButton] that navigates to [ShopEditScreen].
class MyShopDetailsScreen extends StatelessWidget {
  const MyShopDetailsScreen({super.key});

  static bool _isRejected(Shop shop) {
    final status = shop.registrationStatus?.toLowerCase().trim() ?? '';
    return status == 'rejected';
  }

  @override
  Widget build(BuildContext context) {
    final shop = Get.arguments as Shop?;
    if (shop == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.shopDetails),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    return Scaffold(
      appBar: AppCustomAppBar(
        title: shop.name,
        actions: _isRejected(shop)
            ? [
                Padding(
                  padding: AppSpacing.symmetric(context, h: 0.04, v: 0),
                  child: AppIconButton(
                    icon: Iconsax.edit,
                    onPressed: () =>
                        Get.toNamed(AppRoutes.shopEdit, arguments: shop),
                    color: AppColors.white,
                  ),
                ),
              ]
            : null,
      ),
      body: MyShopDetailsContent(shop: shop),
    );
  }
}
