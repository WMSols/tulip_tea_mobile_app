// Basic Flutter widget smoke test for Tulip Tea Order Booker.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/app.dart';
import 'package:tulip_tea_order_booker/presentation/routes/app_routes.dart';

void main() {
  testWidgets('App loads with login route', (WidgetTester tester) async {
    Get.testMode = true;
    await tester.pumpWidget(
      MyApp(initialRoute: AppRoutes.login),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
