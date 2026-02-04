import 'package:flutter/material.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_responsive/app_responsive.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.08,
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.06,
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.04,
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle hintText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.04,
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).hintColor,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.045,
    fontFamily: AppFonts.secondaryFont,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle labelText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.035,
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle errorText(BuildContext context) => TextStyle(
    fontSize: AppResponsive.screenWidth(context) * 0.035,
    fontFamily: AppFonts.secondaryFont,
    color: Colors.red,
  );
}
