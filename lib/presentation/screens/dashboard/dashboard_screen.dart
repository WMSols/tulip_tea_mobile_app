import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_app_bar.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_empty_widget.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(DashboardController(Get.find(), Get.find()));
    return Scaffold(
      appBar: const AppAppBar(title: AppTexts.dashboard),
      body: Obx(() {
        if (c.isLoading.value) {
          return Padding(
            padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
            child: const AppShimmerList(itemCount: 6),
          );
        }
        if (c.routes.isEmpty) {
          return const AppEmptyWidget(
            message: 'No assigned routes yet',
            icon: Iconsax.route_square,
          );
        }
        return ListView.separated(
          padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
          itemCount: c.routes.length,
          separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
          itemBuilder: (_, i) {
            final r = c.routes[i];
            return Card(
              child: ListTile(
                leading: const Icon(Iconsax.route_square),
                title: Text(r.name, style: AppTextStyles.bodyText(context)),
                subtitle: r.zoneId != null
                    ? Text('Zone ID: ${r.zoneId}')
                    : null,
              ),
            );
          },
        );
      }),
    );
  }
}
