import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Data for a single onboarding page.
class OnboardingPage {
  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

/// Reusable widget that displays one onboarding page (title, image, subtitle).
class OnboardingPageItem extends StatelessWidget {
  const OnboardingPageItem({
    super.key,
    required this.page,
    required this.pageIndex,
  });

  final OnboardingPage page;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        children: [
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headline(context),
          ),
          AppSpacing.vertical(context, 0.01),
          Expanded(
            flex: 2,
            child: Image.asset(page.image, fit: BoxFit.contain),
          ),
          AppSpacing.vertical(context, 0.01),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText(context),
          ),
        ],
      ),
    );
  }
}
