import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';

/// Bottom sheet to choose image source (camera or gallery).
/// Pops the sheet then invokes the corresponding callback.
class ImagePickerSourceSheet extends StatelessWidget {
  const ImagePickerSourceSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
  });

  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            splashColor: AppColors.primary,
            leading: const Icon(Iconsax.camera, color: AppColors.white),
            title: Text(
              AppTexts.camera,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onCamera();
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.gallery, color: AppColors.white),
            title: Text(
              AppTexts.gallery,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onGallery();
            },
          ),
        ],
      ),
    );
  }
}
