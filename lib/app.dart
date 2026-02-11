import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_order_booker/core/utils/app_fonts/app_fonts.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_no_connection_banner.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_pages.dart';

class TulipTeaOrderBookerApp extends StatelessWidget {
  const TulipTeaOrderBookerApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appFullName,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      builder: (context, child) {
        return AppOfflineBanner(child: child ?? const SizedBox.shrink());
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        fontFamily: AppFonts.primaryFont,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
      ),
    );
  }
}
