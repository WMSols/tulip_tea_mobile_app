import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';

class AppShimmer extends StatefulWidget {
  const AppShimmer({super.key, this.width, this.height, this.borderRadius});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.borderRadius ??
        BorderRadius.circular(AppResponsive.radius(context));
    final height = widget.height ?? AppResponsive.shimmerDefaultHeight(context);
    final width = widget.width ?? double.infinity;

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: borderRadius,
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;
                    final sweep = 2.2 * (w + h);
                    final dx = -sweep + 2 * sweep * _animation.value;
                    final dy = dx * 0.7;
                    return Transform.translate(
                      offset: Offset(dx, dy),
                      child: SizedBox(
                        width: sweep * 2,
                        height: sweep * 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.transparent,
                                AppColors.white.withValues(alpha: 0.06),
                                AppColors.white.withValues(alpha: 0.28),
                                AppColors.white.withValues(alpha: 0.45),
                                AppColors.white.withValues(alpha: 0.28),
                                AppColors.white.withValues(alpha: 0.06),
                                Colors.transparent,
                              ],
                              stops: const [
                                0.0,
                                0.32,
                                0.42,
                                0.5,
                                0.58,
                                0.68,
                                1.0,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppShimmerList extends StatelessWidget {
  const AppShimmerList({super.key, this.itemCount = 5, this.itemHeight});

  final int itemCount;
  final double? itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => AppSpacing.vertical(context, 0.015),
      itemBuilder: (_, __) => AppShimmer(
        height: itemHeight ?? AppResponsive.shimmerItemHeight(context),
        width: double.infinity,
      ),
    );
  }
}
