import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_field_label/app_form_field_label.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_image_popup.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_image_picker/image_picker_source_sheet.dart';

/// Reusable image picker with optional preview and remove.
/// [currentPath] is the file path of the selected image; [onPicked] and [onRemove] update parent state.
/// If [heroTag] is set, tapping the image opens [AppImagePopup] for fullscreen view.
class AppImagePicker extends StatelessWidget {
  const AppImagePicker({
    super.key,
    required this.label,
    this.required = false,
    this.currentPath,
    required this.onPicked,
    required this.onRemove,
    this.validator,
    this.heroTag,
  });

  final String label;
  final bool required;
  final String? currentPath;
  final void Function(String path) onPicked;
  final VoidCallback onRemove;
  final String? Function(String? path)? validator;

  /// If set, image preview is tappable and opens fullscreen via [AppImagePopup].
  final String? heroTag;

  static final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? file = await _picker.pickImage(
      source: source,
      maxWidth: AppResponsive.scaleSize(context, 1200),
      imageQuality: 85,
    );
    if (file != null && context.mounted) {
      onPicked(file.path);
    }
  }

  void _showSourceDialog(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: AppColors.black,
      context: context,
      builder: (ctx) => ImagePickerSourceSheet(
        onCamera: () => _pickImage(context, ImageSource.camera),
        onGallery: () => _pickImage(context, ImageSource.gallery),
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
        AppFormFieldLabel(
          label: label,
          required: required,
          spacingAfter: 0.008,
        ),
        if (hasImage) ...[
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
                child: heroTag != null
                    ? AppImagePopup(
                        heroTag: heroTag!,
                        imageFilePath: currentPath,
                        child: Image.file(
                          File(currentPath!),
                          height: AppResponsive.screenHeight(context) * 0.25,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.file(
                        File(currentPath!),
                        height: AppResponsive.screenHeight(context) * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: AppSpacing.verticalValue(context, 0.01),
                right: AppSpacing.horizontalValue(context, 0.01),
                child: AppIconButton(
                  onPressed: onRemove,
                  icon: Iconsax.trash,
                  color: AppColors.white,
                  backgroundColor: AppColors.error,
                ),
              ),
            ],
          ),
        ] else
          AppButton(
            label: AppTexts.addPhoto,
            primary: false,
            onPressed: () => _showSourceDialog(context),
            icon: Iconsax.gallery_add,
            iconPosition: IconPosition.left,
          ),
        if (validationError != null && validationError.isNotEmpty) ...[
          AppSpacing.vertical(context, 0.006),
          Text(validationError, style: AppTextStyles.errorText(context)),
        ],
      ],
    );
  }
}
