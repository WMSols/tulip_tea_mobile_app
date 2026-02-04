import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
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
          child: const AppShimmerList(itemCount: 5),
        );
      }
      if (c.shops.isEmpty) {
        return AppEmptyWidget(message: AppTexts.noShopsYet, icon: Iconsax.shop);
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
    return Hero(
      tag: 'shop_${shop.id}',
      child: Material(
        color: Colors.transparent,
        child: Card(
          child: ListTile(
            leading: const Icon(Iconsax.shop),
            title: Text(shop.name, style: AppTextStyles.bodyText(context)),
            subtitle: Text(
              '${shop.ownerName} • ${shop.ownerPhone}',
              style: AppTextStyles.hintText(context),
            ),
          ),
        ),
      ),
    );
  }
}
