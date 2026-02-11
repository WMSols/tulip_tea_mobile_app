import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/shops/shop_register/shop_register_form.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_register_controller.dart';

class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({super.key});

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ShopRegisterController>();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Form(
        key: _formKey,
        child: Obx(
          () => ShopRegisterForm(
            key: ValueKey(c.formResetKey.value),
            controller: c,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }
}
