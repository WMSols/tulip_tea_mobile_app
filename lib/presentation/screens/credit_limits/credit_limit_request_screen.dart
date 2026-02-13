import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/credit_limits/credit_limit_request/credit_limit_request_form.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/credit_limit_request_controller.dart';

class CreditLimitRequestScreen extends StatefulWidget {
  const CreditLimitRequestScreen({super.key});

  @override
  State<CreditLimitRequestScreen> createState() =>
      _CreditLimitRequestScreenState();
}

class _CreditLimitRequestScreenState extends State<CreditLimitRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreditLimitRequestController>();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Form(
        key: _formKey,
        child: Obx(
          () => CreditLimitRequestForm(
            key: ValueKey(c.formResetKey.value),
            controller: c,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }
}
