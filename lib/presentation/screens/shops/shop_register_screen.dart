import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/widgets/features/shop_register/shop_register_form.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/shops/shop_register_controller.dart';

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
      padding: AppSpacing.symmetric(context, h: 0.05, v: 0.02),
      child: Form(
        key: _formKey,
        child: ShopRegisterForm(controller: c, formKey: _formKey),
      ),
    );
  }
}
