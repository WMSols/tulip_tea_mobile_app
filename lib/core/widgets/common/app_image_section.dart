import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tulip_tea_mobile_app/core/config/env_config.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_image_popup.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_placeholder_box.dart';

/// Section showing a label and image (network or file) or placeholder.
/// Resolves relative image URLs using [EnvConfig.baseUrl]. Supports Hero popup on tap.
class AppImageSection extends StatelessWidget {
  const AppImageSection({
    super.key,
    required this.label,
    this.imageUrl,
    this.imageFilePath,
    this.heroTag,
  });

  final String label;
  final String? imageUrl;
  final String? imageFilePath;

  /// Optional. If set, image is wrapped in [AppImagePopup] for fullscreen view.
  final String? heroTag;

  static String _resolveUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    final base = EnvConfig.baseUrl.endsWith('/')
        ? EnvConfig.baseUrl
        : '${EnvConfig.baseUrl}/';
    final path = url.startsWith('/') ? url.substring(1) : url;
    return base + path;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = imageUrl != null && imageUrl!.isNotEmpty
        ? _resolveUrl(imageUrl)
        : null;
    final hasNetworkImage = resolvedUrl != null && resolvedUrl.isNotEmpty;
    final hasFileImage = imageFilePath != null && imageFilePath!.isNotEmpty;

    Widget imageWidget;
    if (hasNetworkImage) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Image.network(
          resolvedUrl,
          height: AppResponsive.screenHeight(context) * 0.25,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => AppPlaceholderBox(
            label: AppTexts.notAvailable,
            heightFactor: 0.25,
          ),
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: AppResponsive.screenHeight(context) * 0.25,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
        ),
      );
    } else if (hasFileImage) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Image.file(
          File(imageFilePath!),
          height: AppResponsive.screenHeight(context) * 0.25,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyText(context).copyWith(
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.primaryFont,
              color: AppColors.primary,
            ),
          ),
          AppSpacing.vertical(context, 0.008),
          const AppPlaceholderBox(heightFactor: 0.25),
        ],
      );
    }

    if (heroTag != null && (hasNetworkImage || hasFileImage)) {
      imageWidget = AppImagePopup(
        heroTag: heroTag!,
        imageUrl: resolvedUrl,
        imageFilePath: imageFilePath,
        child: imageWidget,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyText(context).copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.primaryFont,
            color: AppColors.primary,
          ),
        ),
        AppSpacing.vertical(context, 0.008),
        imageWidget,
      ],
    );
  }
}
