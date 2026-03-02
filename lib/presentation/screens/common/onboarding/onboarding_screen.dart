import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_dots_indicator.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_bubble_background.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/common/onboarding/onboarding_page_item.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/common/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, this.role});

  final String? role;

  // Get role from arguments if not provided directly
  String get _effectiveRole {
    if (role != null) return role!;
    // Try to get from route arguments
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('role')) {
      return args['role'] as String;
    }
    return AppConstants.roleOrderBooker;
  }

  List<OnboardingPage> get _pages {
    if (_effectiveRole == AppConstants.roleDeliveryMan) {
      return _dmPages;
    }
    return _obPages;
  }

  static final List<OnboardingPage> _obPages = [
    OnboardingPage(
      image: AppImages.obOnboarding1,
      title: AppTexts.onBoardingTitle1,
      subtitle: AppTexts.onBoardingSubtitle1,
    ),
    OnboardingPage(
      image: AppImages.obOnboarding2,
      title: AppTexts.onBoardingTitle2,
      subtitle: AppTexts.onBoardingSubtitle2,
    ),
    OnboardingPage(
      image: AppImages.obOnboarding3,
      title: AppTexts.onBoardingTitle3,
      subtitle: AppTexts.onBoardingSubtitle3,
    ),
  ];

  static final List<OnboardingPage> _dmPages = [
    OnboardingPage(
      image: AppImages.dmOnboarding1,
      title: AppTexts.dmOnBoardingTitle1,
      subtitle: AppTexts.dmOnBoardingSubtitle1,
    ),
    OnboardingPage(
      image: AppImages.dmOnboarding2,
      title: AppTexts.dmOnBoardingTitle2,
      subtitle: AppTexts.dmOnBoardingSubtitle2,
    ),
    OnboardingPage(
      image: AppImages.dmOnboarding3,
      title: AppTexts.dmOnBoardingTitle3,
      subtitle: AppTexts.dmOnBoardingSubtitle3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OnboardingController>();

    // Set role from effective role (parameter or arguments)
    c.setRole(_effectiveRole);

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
                  label: c.currentPage.value < _pages.length - 1
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
