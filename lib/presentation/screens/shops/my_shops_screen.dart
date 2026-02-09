import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/my_shops_controller.dart';

class MyShopsScreen extends StatelessWidget {
  const MyShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyShopsController>();
    return Obx(() {
      if (c.isLoading.value) {
        return Padding(
          padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
          child: const AppShimmerList(),
        );
      }
      if (c.shops.isEmpty) {
        return AppEmptyWidget(
          message: AppTexts.noShopsYet,
          imagePath: AppImages.noShopsYet,
        );
      }
      return ListView.separated(
        padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
        itemCount: c.shops.length,
        separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
        itemBuilder: (_, i) {
          final shop = c.shops[i];
          return _ShopCard(shop: shop);
        },
      );
    });
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final gpsStr = (shop.gpsLat != null && shop.gpsLng != null)
        ? '${shop.gpsLat!.toStringAsFixed(4)}, ${shop.gpsLng!.toStringAsFixed(4)}'
        : '–';
    final creditStr = shop.creditLimit != null
        ? '${AppTexts.rupeeSymbol} ${shop.creditLimit!.toStringAsFixed(0)}'
        : '–';
    final availableStr = shop.availableCredit != null
        ? '${AppTexts.rupeeSymbol} ${shop.availableCredit!.toStringAsFixed(0)}'
        : '–';
    final statusStr = shop.registrationStatus ?? '–';
    final createdStr = shop.createdAt ?? '–';

    return Hero(
      tag: 'shop_${shop.id}',
      child: Material(
        color: Colors.transparent,
        child: AppInfoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.shop,
                    size: AppResponsive.iconSize(context, factor: 1.2),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(
                      shop.name,
                      style: AppTextStyles.bodyText(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.012),
              AppInfoRow(
                label: AppTexts.owner,
                value: shop.ownerName.isNotEmpty ? shop.ownerName : '–',
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.ownerPhone,
                value: shop.ownerPhone.isNotEmpty ? shop.ownerPhone : '–',
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.gps,
                value: gpsStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.creditLimit,
                value: creditStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.availableCredit,
                value: availableStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: AppTexts.registrationStatus,
                value: statusStr,
                showDivider: true,
              ),
              AppInfoRow(
                label: '${AppTexts.id} | ${AppTexts.created}',
                value: '${shop.id} | $createdStr',
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
