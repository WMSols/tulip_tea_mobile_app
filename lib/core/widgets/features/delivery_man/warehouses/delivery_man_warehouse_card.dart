import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_info_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_status_chip.dart';
import 'package:tulip_tea_mobile_app/data/models/warehouse/warehouse_model.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

/// Card for a single warehouse in Delivery Man warehouses list.
/// Shows name, status chip, address snippet, total items; tap navigates to [DeliveryManWarehouseDetailScreen].
class DeliveryManWarehouseCard extends StatelessWidget {
  const DeliveryManWarehouseCard({super.key, required this.warehouse});

  final WarehouseModel warehouse;

  @override
  Widget build(BuildContext context) {
    final name = warehouse.name ?? '–';
    final address = warehouse.address?.isNotEmpty == true
        ? warehouse.address!
        : null;
    final itemCount = warehouse.inventory?.length ?? 0;
    final status = warehouse.isActive == true ? 'Active' : 'Inactive';

    return AppInfoCard(
      onTap: () =>
          Get.toNamed(AppRoutes.dmWarehouseDetail, arguments: warehouse),
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
                        name,
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                    ),
                    AppStatusChip(status: status),
                  ],
                ),
                if (address != null)
                  Text(
                    address,
                    style: AppTextStyles.hintText(context).copyWith(
                      fontSize: AppResponsive.screenWidth(context) * 0.032,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  '${AppTexts.totalItems}: $itemCount',
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
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
