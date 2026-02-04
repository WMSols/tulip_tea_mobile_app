import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';

/// Reusable image picker with optional preview and remove.
/// [currentPath] is the file path of the selected image; [onPicked] and [onRemove] update parent state.
class AppImagePicker extends StatelessWidget {
  const AppImagePicker({
    super.key,
    required this.label,
    this.currentPath,
    required this.onPicked,
    required this.onRemove,
    this.validator,
  });

  final String label;
  final String? currentPath;
  final void Function(String path) onPicked;
  final VoidCallback onRemove;
  final String? Function(String? path)? validator;

  static final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (file != null && context.mounted) {
      onPicked(file.path);
    }
  }

  void _showSourceDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: Text('Camera', style: AppTextStyles.bodyText(context)),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: Text(
                AppTexts.gallery,
                style: AppTextStyles.bodyText(context),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = currentPath != null && currentPath!.isNotEmpty;
    final validationError = validator?.call(currentPath);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyles.labelText(context)),
        AppSpacing.vertical(context, 0.008),
        if (hasImage) ...[
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
                child: Image.file(
                  File(currentPath!),
                  height: AppResponsive.scaleSize(context, 140),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: AppSpacing.verticalValue(context, 0.01),
                right: AppSpacing.horizontalValue(context, 0.01),
                child: Material(
                  color: AppColors.error.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(
                    AppResponsive.radius(context),
                  ),
                  child: InkWell(
                    onTap: onRemove,
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                    child: Padding(
                      padding: AppSpacing.all(context),
                      child: Icon(
                        Iconsax.trash,
                        color: AppColors.white,
                        size: AppResponsive.iconSize(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ] else
          OutlinedButton.icon(
            onPressed: () => _showSourceDialog(context),
            icon: const Icon(Iconsax.gallery_add),
            label: Text(AppTexts.addPhoto),
            style: OutlinedButton.styleFrom(
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
              foregroundColor: AppColors.primary,
            ),
          ),
        if (validationError != null && validationError.isNotEmpty) ...[
          AppSpacing.vertical(context, 0.006),
          Text(validationError, style: AppTextStyles.errorText(context)),
        ],
      ],
    );
  }
}
