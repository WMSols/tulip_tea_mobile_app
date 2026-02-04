import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, this.width, this.height, this.borderRadius});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? AppResponsive.shimmerDefaultHeight(context),
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ??
            BorderRadius.circular(AppResponsive.radius(context)),
        color: AppColors.lightGrey,
      ),
      child: null,
    );
  }
}

class AppShimmerList extends StatelessWidget {
  const AppShimmerList({super.key, this.itemCount = 5, this.itemHeight});

  final int itemCount;
  final double? itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
      itemBuilder: (_, __) => AppShimmer(
        height: itemHeight ?? AppResponsive.shimmerItemHeight(context),
        width: double.infinity,
      ),
    );
  }
}
