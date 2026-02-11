import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// Reusable footer with copyright icon and "Managed by WMSols" text.
/// Tapping opens [url] (default: https://wmsols.com/) in external browser.
class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
    this.url = _defaultUrl,
    this.text = 'Managed by WMSols',
  });

  static const String _defaultUrl = 'https://wmsols.com/';

  final String url;
  final String text;

  Future<void> _onTap(BuildContext context) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.01),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTap(context),
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.copyright,
                size: AppResponsive.iconSize(context, factor: 0.8),
                color: AppColors.error.withValues(alpha: 0.5),
              ),
              AppSpacing.horizontal(context, 0.01),
              Text(
                text,
                style: AppTextStyles.hintText(context).copyWith(
                  color: AppColors.grey,
                  fontSize: AppResponsive.scaleSize(context, 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
