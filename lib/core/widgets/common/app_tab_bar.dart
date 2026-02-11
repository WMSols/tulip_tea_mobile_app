import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';

/// A single tab item for [AppTabBar].
class AppTabBarItem {
  const AppTabBarItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Reusable tab bar with consistent app styling (white indicator and labels on primary).
///
/// Use with [controller] when placed in [AppBar.bottom] (e.g. [ShopsScreen]).
/// Use with [selectedIndex] and [onTabChanged] when placed in body with [IndexedStack].
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  AppTabBar({
    super.key,
    this.controller,
    this.selectedIndex,
    this.onTabChanged,
    required this.tabs,
  }) : assert(
         (controller != null) !=
             (selectedIndex != null && onTabChanged != null),
         'Provide either controller (for app bar) or selectedIndex + onTabChanged (for body).',
       ),
       assert(tabs.isNotEmpty, 'At least one tab is required.');

  /// Use with [TabBarView]; tab bar is placed in [AppBar.bottom].
  final TabController? controller;

  /// Use with [IndexedStack]; tab bar is a row of buttons with same styling.
  final int? selectedIndex;
  final ValueChanged<int>? onTabChanged;

  final List<AppTabBarItem> tabs;

  static const double _kTabBarHeight = 46.0;

  @override
  Size get preferredSize => const Size.fromHeight(_kTabBarHeight);

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      return _buildTabBar(context);
    }
    return _buildSegmentBar(context);
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorColor: AppColors.white,
      indicatorWeight: AppResponsive.scaleSize(context, 3).clamp(2.0, 4.0),
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.white.withValues(alpha: 0.7),
      labelStyle: AppTextStyles.bodyText(context).copyWith(
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.primaryFont,
        color: AppColors.white,
      ),
      unselectedLabelStyle: AppTextStyles.bodyText(context).copyWith(
        color: AppColors.white.withValues(alpha: 0.7),
        fontFamily: AppFonts.primaryFont,
      ),
      tabs: tabs
          .map(
            (item) => Tab(
              icon: Icon(
                item.icon,
                size: AppResponsive.iconSize(context, factor: 1.2),
              ),
              text: item.label,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSegmentBar(BuildContext context) {
    final selected = selectedIndex!;
    final onTabChanged = this.onTabChanged!;
    return Container(
      color: AppColors.primary,
      height: _kTabBarHeight,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final item = tabs[index];
          final isSelected = selected == index;
          final color = isSelected
              ? AppColors.white
              : AppColors.white.withValues(alpha: 0.7);
          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(index),
              child: Padding(
                padding: AppSpacing.symmetric(context, v: 0.015),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: AppResponsive.iconSize(context, factor: 1.2),
                            color: color,
                          ),
                          AppSpacing.horizontal(context, 0.01),
                          Flexible(
                            child: Text(
                              item.label,
                              style: AppTextStyles.bodyText(context).copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                fontFamily: AppFonts.primaryFont,
                                color: color,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: AppResponsive.scaleSize(
                        context,
                        3,
                      ).clamp(2.0, 4.0),
                      color: isSelected ? AppColors.white : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
