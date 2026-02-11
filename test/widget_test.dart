// Basic Flutter widget smoke test for Tulip Tea Order Booker.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/app.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';

void main() {
  testWidgets('App loads with login route', (WidgetTester tester) async {
    Get.testMode = true;
    await tester.pumpWidget(
      TulipTeaOrderBookerApp(initialRoute: AppRoutes.login),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
