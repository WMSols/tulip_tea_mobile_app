import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/shops/shop_register/shop_register_form.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/shops/shop_edit_controller.dart';

/// Edit and resubmit a rejected shop. Same layout as [ShopRegisterScreen] with pre-filled details.
/// Uses StatefulWidget so [GlobalKey] is stable across rebuilds; recreating the key was causing
/// the form (and text fields) to be recreated and the keyboard to dismiss.
class ShopEditScreen extends StatefulWidget {
  const ShopEditScreen({super.key});

  @override
  State<ShopEditScreen> createState() => _ShopEditScreenState();
}

class _ShopEditScreenState extends State<ShopEditScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final shop = Get.arguments as Shop?;
    if (shop == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.editShop),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }
    final c = Get.find<ShopEditController>();
    return Scaffold(
      appBar: AppCustomAppBar(title: AppTexts.editShop),
      body: SingleChildScrollView(
        padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
        child: Form(
          key: _formKey,
          child: ShopRegisterForm(
            editController: c,
            formKey: _formKey,
            isEditMode: true,
          ),
        ),
      ),
    );
  }
}
