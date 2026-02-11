import 'package:flutter/material.dart';

import 'package:tulip_tea_mobile_app/app.dart';
import 'package:tulip_tea_mobile_app/core/init/app_initializer.dart';
import 'package:tulip_tea_mobile_app/core/init/app_system_ui.dart';

void main() async {
  final initialRoute = await AppInitializer.init();
  AppSystemUi.setOverlayStyle();
  runApp(TulipTeaOrderBookerApp(initialRoute: initialRoute));
}
