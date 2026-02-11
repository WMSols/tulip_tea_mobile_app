import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/account/account_content.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/account/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AccountController(Get.find()));
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.account),
      body: RefreshIndicator(
        backgroundColor: AppColors.primary,
        color: AppColors.white,
        onRefresh: () => c.loadUser(),
        child: Obx(
          () => AccountContent(user: c.user.value, onLogout: c.logout),
        ),
      ),
    );
  }
}
