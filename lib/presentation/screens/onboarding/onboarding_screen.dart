import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OnboardingController>();
    final pages = [
      _Page(
        image: AppImages.onboarding1,
        title: AppTexts.onBoardingTitle1,
        subtitle: AppTexts.onBoardingSubtitle1,
      ),
      _Page(
        image: AppImages.onboarding2,
        title: AppTexts.onBoardingTitle2,
        subtitle: AppTexts.onBoardingSubtitle2,
      ),
      _Page(
        image: AppImages.onboarding3,
        title: AppTexts.onBoardingTitle3,
        subtitle: AppTexts.onBoardingSubtitle3,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: c.skip,
                child: Text(
                  AppTexts.skip,
                  style: AppTextStyles.bodyText(
                    context,
                  ).copyWith(color: AppColors.primary),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: c.pageController,
                onPageChanged: (i) => c.currentPage.value = i,
                itemCount: pages.length,
                itemBuilder: (_, i) => Padding(
                  padding: AppSpacing.symmetric(context, h: 0.06, v: 0.02),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'onboarding_title_$i',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            pages[i].title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headline(context),
                          ),
                        ),
                      ),
                      AppSpacing.vertical(context, 0.01),
                      Expanded(
                        flex: 2,
                        child: Hero(
                          tag: 'onboarding_image_$i',
                          child: Image.asset(
                            pages[i].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      AppSpacing.vertical(context, 0.01),
                      Text(
                        pages[i].subtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSpacing.horizontalValue(context, 0.01),
                    ),
                    width: c.currentPage.value == i
                        ? AppResponsive.scaleSize(context, 24)
                        : AppResponsive.scaleSize(context, 8),
                    height: AppResponsive.scaleSize(context, 8),
                    decoration: BoxDecoration(
                      color: c.currentPage.value == i
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: c.currentPage.value == i
                            ? Colors.transparent
                            : AppColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.vertical(context, 0.03),
            Padding(
              padding: AppSpacing.symmetric(context, h: 0.06),
              child: AppButton(
                label: c.currentPage.value < 2
                    ? AppTexts.next
                    : AppTexts.getStarted,
                onPressed: c.nextPage,
                icon: Iconsax.arrow_right_3,
                iconPosition: IconPosition.right,
              ),
            ),
            AppSpacing.vertical(context, 0.03),
          ],
        ),
      ),
    );
  }
}

class _Page {
  const _Page({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}
