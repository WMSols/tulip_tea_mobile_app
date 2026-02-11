import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';

/// Reusable background for onboarding (or similar) screens with two
/// [AppColors.primary] curved containers: one at top-left, one at center-right.
class AppBubbleBackground extends StatelessWidget {
  const AppBubbleBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -_circleRadius(context) * 0.8,
          left: -_circleRadius(context) * 0.8,
          child: _PrimaryCircle(radius: _circleRadius(context)),
        ),
        Positioned(
          bottom: _circleRadius(context) * 2.6,
          left: -_circleRadius(context) * 1.6,
          child: _PrimaryCircle(radius: _circleRadius(context)),
        ),
        Positioned(
          top: _circleRadius(context) * 2.6,
          right: -_circleRadius(context) * 1.6,
          child: _PrimaryCircle(radius: _circleRadius(context)),
        ),
        Positioned(
          bottom: -_circleRadius(context) * 0.8,
          right: -_circleRadius(context) * 0.8,
          child: _PrimaryCircle(radius: _circleRadius(context)),
        ),
        child,
      ],
    );
  }

  static double _circleRadius(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width * 0.2;
  }
}

class _PrimaryCircle extends StatelessWidget {
  const _PrimaryCircle({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}
