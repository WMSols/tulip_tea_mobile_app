import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shops_controller.dart';
import 'package:tulip_tea_order_booker/presentation/screens/shops/my_shops_screen.dart';
import 'package:tulip_tea_order_booker/presentation/screens/shops/shop_register_screen.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ShopsController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppTexts.shops,
            style: AppTextStyles.heading(
              context,
            ).copyWith(color: AppColors.white),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          bottom: TabBar(
            indicatorColor: AppColors.white,
            indicatorWeight: AppResponsive.scaleSize(context, 3).clamp(2.0, 4.0),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.white.withValues(alpha: 0.7),
            labelStyle: AppTextStyles.bodyText(context).copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.primaryFont,
              color: AppColors.white,
            ),
            unselectedLabelStyle: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
              fontFamily: AppFonts.primaryFont,
            ),
            tabs: [
              Tab(
                icon: Icon(
                  Iconsax.shop_add,
                  size: AppResponsive.iconSize(context, factor: 1.2),
                ),
                text: AppTexts.registerShop,
              ),
              Tab(
                icon: Icon(
                  Iconsax.shop,
                  size: AppResponsive.iconSize(context, factor: 1.2),
                ),
                text: AppTexts.myShops,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [ShopRegisterScreen(), MyShopsScreen()],
        ),
      ),
    );
  }
}
