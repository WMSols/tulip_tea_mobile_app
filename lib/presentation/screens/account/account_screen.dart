import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_shimmer.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/account/account_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/account/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AccountController>();
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.account),
      body: RefreshIndicator(
        backgroundColor: AppColors.primary,
        color: AppColors.white,
        onRefresh: () => c.loadUser(),
        child: Obx(() {
          if (c.isLoading.value && c.user.value == null) {
            return Padding(
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
              child: const AppShimmerList(itemCount: 8),
            );
          }
          return AccountContent(user: c.user.value, onLogout: c.logout);
        }),
      ),
    );
  }
}
