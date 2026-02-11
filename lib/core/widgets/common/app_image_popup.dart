import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/widgets/common/app_custom_app_bar.dart';

/// Wraps an image in [Hero] and opens a fullscreen popup on tap so the user can view it fully.
/// Use for both network and file images (pass [imageUrl] and/or [imageFilePath] for the fullscreen view).
class AppImagePopup extends StatelessWidget {
  const AppImagePopup({
    super.key,
    required this.heroTag,
    required this.child,
    this.imageUrl,
    this.imageFilePath,
  });

  final String heroTag;
  final Widget child;

  /// Used to build the fullscreen network image (other end of Hero).
  final String? imageUrl;

  /// Used to build the fullscreen file image (other end of Hero).
  final String? imageFilePath;

  static void show(
    BuildContext context, {
    required String heroTag,
    String? imageUrl,
    String? imageFilePath,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => _FullScreenImagePage(
          heroTag: heroTag,
          imageUrl: imageUrl,
          imageFilePath: imageFilePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => show(
            context,
            heroTag: heroTag,
            imageUrl: imageUrl,
            imageFilePath: imageFilePath,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _FullScreenImagePage extends StatelessWidget {
  const _FullScreenImagePage({
    required this.heroTag,
    this.imageUrl,
    this.imageFilePath,
  });

  final String heroTag;
  final String? imageUrl;
  final String? imageFilePath;

  @override
  Widget build(BuildContext context) {
    final hasUrl = imageUrl != null && imageUrl!.isNotEmpty;
    final hasFile = imageFilePath != null && imageFilePath!.isNotEmpty;

    Widget imageWidget;
    if (hasUrl) {
      imageWidget = InteractiveViewer(
        child: Image.network(
          imageUrl!,
          fit: BoxFit.contain,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (_, __, ___) =>
              const Center(child: Icon(Icons.broken_image_outlined, size: 64)),
        ),
      );
    } else if (hasFile) {
      imageWidget = InteractiveViewer(
        child: Image.file(File(imageFilePath!), fit: BoxFit.contain),
      );
    } else {
      imageWidget = const Center(
        child: Icon(Icons.image_not_supported, size: 64),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppCustomAppBar(
        title: '',
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppResponsive.screenWidth(context),
              maxHeight: AppResponsive.screenHeight(context) * 0.8,
            ),
            child: imageWidget,
          ),
        ),
      ),
    );
  }
}
