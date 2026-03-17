import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';

class AppHelper {
  AppHelper._();

  /// Start of tomorrow (midnight). Use for date picker min/default.
  static DateTime get tomorrow {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1);
  }

  /// Parses [value] as DateTime. Handles ISO string (e.g. 2025-06-21T22:00:00) or date-only (yyyy-mm-dd).
  static DateTime? parseDateTimeOrNull(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final s = value.trim();
    final dt = DateTime.tryParse(s);
    if (dt != null) return dt;
    final parts = s.split('-');
    if (parts.length >= 3) {
      final y = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      final d = int.tryParse(parts[2].split('T').first.split(' ').first);
      if (y != null && m != null && d != null) {
        return DateTime(y, m, d);
      }
    }
    return null;
  }

  /// Returns true if [value] is null or empty/whitespace-only.
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Returns true if [value] is not null and has non-whitespace content.
  static bool isNotNullOrEmpty(String? value) {
    return !isNullOrEmpty(value);
  }

  /// Converts snake_case to Title Case (e.g. order_booking → Order Booking).
  static String snakeToTitle(String part) {
    if (part.isEmpty) return '';
    return part
        .split('_')
        .map(
          (e) => e.isEmpty
              ? ''
              : '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  /// Normalize status strings for comparisons: trim, lowercase, and convert spaces to underscores.
  static String normalizeStatus(String? status) {
    final v = (status ?? '').trim().toLowerCase();
    return v.replaceAll(' ', '_');
  }

  /// Delivery-man delivery status label (Not Started / In Transit / etc).
  static String dmDeliveryStatusLabel(String status) {
    final s = normalizeStatus(status);
    switch (s) {
      case 'not_started':
        return AppTexts.dmStatusNotStarted;
      case 'pending_pickup':
        return AppTexts.dmStatusPendingPickup;
      case 'picked_up':
        return AppTexts.dmStatusPickedUp;
      case 'in_transit':
        return AppTexts.dmStatusInTransit;
      case 'delivered':
        return AppTexts.dmStatusDelivered;
      case 'partially_delivered':
        return AppTexts.dmStatusPartiallyDelivered;
      case 'returned':
        return AppTexts.dmStatusReturned;
      case 'failed':
        return AppTexts.dmStatusFailed;
      default:
        return snakeToTitle(s);
    }
  }

  /// Delivery-man delivery status chip color (matches existing UI usage).
  static Color dmDeliveryStatusChipColor(String status) {
    final s = normalizeStatus(status);
    if (s == 'not_started') return AppColors.error;
    if (s == 'pending_pickup') return AppColors.warning;
    if (s == 'picked_up') return AppColors.success;
    if (s == 'in_transit') return AppColors.warning;
    if (s == 'delivered') return AppColors.success;
    if (s == 'partially_delivered') return AppColors.information;
    if (s == 'returned') return AppColors.error;
    if (s == 'failed') return AppColors.error;
    return AppColors.grey;
  }

  /// Delivery-man delivery status chip icon (matches existing UI usage).
  static IconData dmDeliveryStatusChipIcon(String status) {
    final s = normalizeStatus(status);
    if (s == 'not_started' || s == 'returned' || s == 'failed') {
      return Iconsax.close_circle;
    }
    if (s == 'delivered' || s == 'picked_up') {
      return Iconsax.tick_circle;
    }
    if (s == 'pending_pickup' || s == 'in_transit') return Iconsax.clock;
    if (s == 'partially_delivered') return Iconsax.info_circle;
    return Iconsax.info_circle;
  }

  /// Generic status color for chips/details (used by [AppStatusChip]).
  /// Check reject/disapprove before approve so "disapproved" gets error (red), not success (green).
  static Color statusColor(String status) {
    final s = (status).toLowerCase().trim();
    if (s.contains('reject') ||
        s.contains('disapprov') ||
        s.contains('denied') ||
        s == 'inactive' ||
        s == 'cancelled' ||
        s == 'canceled' ||
        s == 'failed') {
      return AppColors.error;
    }
    if (s.contains('approv') ||
        s == 'verified' ||
        s == 'active' ||
        s == 'available' ||
        s == 'delivered' ||
        s == 'returned' ||
        s == 'complete' ||
        s == 'completed') {
      return AppColors.success;
    }
    if (s.contains('pending') ||
        s.contains('waiting') ||
        s.contains('review') ||
        s == 'confirmed' ||
        s == 'picked' ||
        s == 'picked up' ||
        s == 'picked_up') {
      return AppColors.warning;
    }
    return AppColors.grey;
  }

  /// Generic status icon for chips (used by [AppStatusChip]).
  /// Check reject/disapprove before approve so "disapproved" gets close_circle (red), not tick_circle (green).
  static IconData statusIcon(String status) {
    final s = status.toLowerCase().trim();
    if (s.contains('reject') ||
        s.contains('disapprov') ||
        s.contains('denied') ||
        s == 'inactive' ||
        s == 'cancelled' ||
        s == 'canceled' ||
        s == 'failed') {
      return Iconsax.close_circle;
    }
    if (s.contains('approv') ||
        s == 'verified' ||
        s == 'active' ||
        s == 'available' ||
        s == 'delivered' ||
        s == 'returned' ||
        s == 'complete' ||
        s == 'completed') {
      return Iconsax.tick_circle;
    }
    if (s.contains('pending') ||
        s.contains('waiting') ||
        s.contains('review') ||
        s == 'confirmed' ||
        s == 'picked' ||
        s == 'picked up' ||
        s == 'picked_up') {
      return Iconsax.clock;
    }
    return Iconsax.info_circle;
  }

  /// Parses a comma-separated string into a list of trimmed non-empty strings.
  static List<String> parseCommaSeparatedList(String? value) {
    if (value == null || value.trim().isEmpty) return const [];
    return value
        .trim()
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}

/// Extension on [String?] for null/empty checks. Use for readability at call sites.
extension StringHelperExtension on String? {
  /// True if this string is null or empty/whitespace-only.
  bool get isNullOrEmpty => AppHelper.isNullOrEmpty(this);

  /// True if this string is not null and has non-whitespace content.
  bool get isNotNullOrEmpty => AppHelper.isNotNullOrEmpty(this);
}
