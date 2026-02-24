import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/dashboard/dashboard_section_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/weekly_route_schedule.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/dashboard/dashboard_controller.dart';

/// Day names for API day_of_week 0=Monday..6=Sunday. AppFormatter uses 1=Mon..7=Sun.
String _dayName(int dayOfWeek) => AppFormatter.dayNameFull(dayOfWeek + 1);

/// Reusable calendar-style weekly schedule: 7 days (Mon–Sun) with routes per day.
/// Uses [DashboardSectionCardExpandedBottom] "Tap to expand" to expand and show all days.
class ScheduleCalendarView extends StatefulWidget {
  const ScheduleCalendarView({
    super.key,
    required this.schedulesByDay,
    this.isLoading = false,
  });

  /// Map day_of_week (0=Mon..6=Sun) -> list of schedules for that day.
  final Map<int, List<WeeklyRouteSchedule>> schedulesByDay;
  final bool isLoading;

  @override
  State<ScheduleCalendarView> createState() => _ScheduleCalendarViewState();
}

class _ScheduleCalendarViewState extends State<ScheduleCalendarView> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasData = widget.schedulesByDay.isNotEmpty;
    final canExpand = hasData && !widget.isLoading;

    return DashboardSectionCard(
      icon: Iconsax.calendar_1,
      title: AppTexts.mySchedule,
      illustrationPath: AppImages.schedule,
      expandedBottom: canExpand
          ? DashboardSectionCardExpandedBottom(
              label: _expanded ? AppTexts.tapToCollapse : AppTexts.tapToExpand,
              icon: _expanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              onTap: () => setState(() => _expanded = !_expanded),
            )
          : null,
      child: widget.isLoading && widget.schedulesByDay.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : widget.schedulesByDay.isEmpty
          ? Text(AppTexts.noScheduleYet, style: AppTextStyles.hintText(context))
          : AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_expanded)
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.heading(
                          context,
                        ).copyWith(color: AppColors.black),
                        children: [
                          TextSpan(
                            text: '${widget.schedulesByDay.length}',
                            style: AppTextStyles.headline(context).copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                          const TextSpan(text: AppTexts.daysScheduled),
                        ],
                      ),
                    ),
                  if (_expanded) _buildAllDaysSchedule(context),
                ],
              ),
            ),
    );
  }

  Widget _buildAllDaysSchedule(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(7, (i) {
        final list = widget.schedulesByDay[i];
        if (list == null || list.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: AppSpacing.verticalValue(context, 0.01),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _dayName(i),
                style: AppTextStyles.hintText(
                  context,
                ).copyWith(fontWeight: FontWeight.w500, color: AppColors.black),
              ),
              ...list.map(
                (s) => Row(
                  children: [
                    Icon(
                      s.isActive ? Iconsax.route_square : Iconsax.route_square5,
                      size: AppResponsive.iconSize(context, factor: 0.85),
                      color: s.isActive ? AppColors.primary : AppColors.grey,
                    ),
                    AppSpacing.horizontal(context, 0.01),
                    Expanded(
                      child: Text(
                        s.routeName ?? 'Route #${s.routeId}',
                        style: AppTextStyles.hintText(
                          context,
                        ).copyWith(color: s.isActive ? null : AppColors.grey),
                      ),
                    ),
                    if (!s.isActive)
                      Text(
                        '(Inactive)',
                        style: AppTextStyles.hintText(context).copyWith(
                          color: AppColors.error,
                          fontSize: AppResponsive.screenWidth(context) * 0.028,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Convenience widget that reads from [DashboardController].
class DashboardScheduleCalendarView extends StatelessWidget {
  const DashboardScheduleCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DashboardController>();
    return Obx(
      () => ScheduleCalendarView(
        schedulesByDay: c.schedulesByDay,
        isLoading: c.isLoadingSchedules.value,
      ),
    );
  }
}
