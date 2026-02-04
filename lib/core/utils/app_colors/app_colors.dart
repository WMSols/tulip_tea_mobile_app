import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFB923C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF0F0F0);
  static const Color success = Color(0xFF4CAF50);
  static const Color information = Color(0xFF2196F3);
  static const Color warning = Color(0xFFFFEB3B);
  static const Color error = Color(0xFFF44336);

  /// Light backgrounds for toast by status (no blur).
  static const Color toastSuccessBackground = Color(0xFFE8F5E9);
  static const Color toastInformationBackground = Color(0xFFE3F2FD);
  static const Color toastWarningBackground = Color(0xFFFFFDE7);
  static const Color toastErrorBackground = Color(0xFFFFEBEE);
}
