import 'package:flutter/material.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_empty_widget.dart';

class DeliveryManDashboardScreen extends StatelessWidget {
  const DeliveryManDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.dashboard),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: AppResponsive.screenHeight(context) * 0.7,
            child: Center(
              child: AppEmptyWidget(
                message: AppTexts.noDataYet,
                imagePath: AppImages.noDataYet,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
