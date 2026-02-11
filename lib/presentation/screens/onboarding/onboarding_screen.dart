import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_dots_indicator.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_bubble_background.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/onboarding/onboarding_page_item.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: AppImages.onboarding1,
      title: AppTexts.onBoardingTitle1,
      subtitle: AppTexts.onBoardingSubtitle1,
    ),
    OnboardingPage(
      image: AppImages.onboarding2,
      title: AppTexts.onBoardingTitle2,
      subtitle: AppTexts.onBoardingSubtitle2,
    ),
    OnboardingPage(
      image: AppImages.onboarding3,
      title: AppTexts.onBoardingTitle3,
      subtitle: AppTexts.onBoardingSubtitle3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OnboardingController>();
    return Scaffold(
      body: AppBubbleBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: AppTextButton(label: AppTexts.skip, onPressed: c.skip),
              ),
              Expanded(
                child: PageView.builder(
                  controller: c.pageController,
                  onPageChanged: (i) => c.currentPage.value = i,
                  itemCount: _pages.length,
                  itemBuilder: (_, i) =>
                      OnboardingPageItem(page: _pages[i], pageIndex: i),
                ),
              ),
              Obx(
                () => AppDotsIndicator(
                  count: _pages.length,
                  currentIndex: c.currentPage.value,
                ),
              ),
              AppSpacing.vertical(context, 0.03),
              Obx(
                () => AppButton(
                  label: c.currentPage.value < 2
                      ? AppTexts.next
                      : AppTexts.getStarted,
                  onPressed: c.nextPage,
                  icon: Iconsax.arrow_right_3,
                  iconPosition: IconPosition.right,
                ),
              ),
              AppSpacing.vertical(context, 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
