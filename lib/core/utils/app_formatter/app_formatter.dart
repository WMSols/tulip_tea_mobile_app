import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';

/// Formatters: display formatting only (dates, visit types, etc.).
/// For null/empty/parsing helpers use [AppHelper]; for validation use [AppValidators].
class AppFormatter {
  AppFormatter._();

  /// Full date-time string: "EEE MMM dd yyyy - h:mm a" (e.g. Tue Jun 21 2005 - 10:00 PM).
  static String dateTime(DateTime timestamp) {
    final datePart = DateFormat('EEE MMM dd yyyy').format(timestamp);
    final timePart = DateFormat('h:mm a').format(timestamp);
    return '$datePart - $timePart';
  }

  /// Short date string for pickers: "Jan 15, 2025".
  static String shortDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  /// Full day name by weekday (1=Mon..7=Sun): Monday, Tuesday, ...
  static String dayNameFull(int weekday) {
    const names = [
      AppTexts.dayMonday,
      AppTexts.dayTuesday,
      AppTexts.dayWednesday,
      AppTexts.dayThursday,
      AppTexts.dayFriday,
      AppTexts.daySaturday,
      AppTexts.daySunday,
    ];
    return names[weekday - 1];
  }

  /// Short day name by weekday (1=Mon..7=Sun): Mon, Tue, ...
  static String dayNameShort(int weekday) {
    const names = [
      AppTexts.dayMon,
      AppTexts.dayTue,
      AppTexts.dayWed,
      AppTexts.dayThu,
      AppTexts.dayFri,
      AppTexts.daySat,
      AppTexts.daySun,
    ];
    return names[weekday - 1];
  }

  /// Formatted hint: "Today (Mon): 5 shop(s) from 2 scheduled route(s) available."
  static String todayShopsHint(String dayShort, int shopCount, int routeCount) {
    return AppTexts.todayShopsHint
        .replaceFirst('%s', dayShort)
        .replaceFirst('%s', '$shopCount')
        .replaceFirst('%s', '$routeCount');
  }

  /// Parses [value] as DateTime and formats it; returns [fallback] if null/empty/invalid.
  static String dateTimeFromString(String? value, {String fallback = '–'}) {
    if (AppHelper.isNullOrEmpty(value)) return fallback;
    final dt = DateTime.tryParse(value!.trim());
    if (dt == null) return value;
    return dateTime(dt);
  }

  /// Converts visit type(s) to display: single or comma-separated (e.g. order_booking → Order Booking).
  static String visitTypeDisplay(String? raw) {
    if (AppHelper.isNullOrEmpty(raw)) return '–';
    final parts = AppHelper.parseCommaSeparatedList(raw);
    if (parts.isEmpty) return '–';
    return parts.map(AppHelper.snakeToTitle).join(', ');
  }

  /// Color and icon for visit type chips (order = box, collection = wallet, etc.).
  static (Color color, IconData icon) visitTypeChipStyle(String typeValue) {
    final t = typeValue.toLowerCase().trim();
    if (t == 'order_booking') {
      return (AppColors.information, Iconsax.box_1);
    }
    if (t == 'daily_collections') {
      return (AppColors.success, Iconsax.wallet_money);
    }
    if (t == 'inspection') {
      return (AppColors.grey, Iconsax.document_text);
    }
    return (AppColors.grey, Iconsax.info_circle);
  }
}
