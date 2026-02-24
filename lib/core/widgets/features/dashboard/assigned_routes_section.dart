import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/route_entity.dart';

/// Reusable section listing assigned routes (name + zone).
/// Uses [DashboardSectionCardExpandedBottom] "Tap to expand" to expand and show all routes.
class AssignedRoutesSection extends StatefulWidget {
  const AssignedRoutesSection({super.key, required this.routes});

  final List<RouteEntity> routes;

  @override
  State<AssignedRoutesSection> createState() => _AssignedRoutesSectionState();
}

class _AssignedRoutesSectionState extends State<AssignedRoutesSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasData = widget.routes.isNotEmpty;
    final canExpand = hasData;

    return DashboardSectionCard(
      icon: Iconsax.routing,
      title: AppTexts.assignedRoutes,
      illustrationPath: AppImages.routes,
      expandedBottom: canExpand
          ? DashboardSectionCardExpandedBottom(
              label: _expanded ? AppTexts.tapToCollapse : AppTexts.tapToExpand,
              icon: _expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              onTap: () => setState(() => _expanded = !_expanded),
            )
          : null,
      child: widget.routes.isEmpty
          ? Text(
              AppTexts.noAssignedRoutesYet,
              style: AppTextStyles.hintText(context),
            )
          : AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!_expanded)
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.heading(
                          context,
                        ).copyWith(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: '${widget.routes.length}',
                            style: AppTextStyles.headline(context).copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const TextSpan(text: AppTexts.myAssignedRoutes),
                        ],
                      ),
                    ),
                  if (_expanded) _buildRoutesList(context),
                ],
              ),
            ),
    );
  }

  Widget _buildRoutesList(BuildContext context) {
    final routes = widget.routes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: routes
          .map(
            (r) => Padding(
              padding: EdgeInsets.only(
                bottom: routes.last == r
                    ? 0
                    : AppSpacing.verticalValue(context, 0.01),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.route_square,
                    size: AppResponsive.iconSize(context, factor: 0.9),
                    color: AppColors.primary,
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: Text(r.name, style: AppTextStyles.hintText(context)),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
