import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/visit_register_form.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

class VisitRegisterScreen extends StatefulWidget {
  const VisitRegisterScreen({super.key});

  @override
  State<VisitRegisterScreen> createState() => _VisitRegisterScreenState();
}

class _VisitRegisterScreenState extends State<VisitRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VisitRegisterController>();
    return RefreshIndicator(
      backgroundColor: AppColors.primary,
      color: AppColors.white,
      onRefresh: () => c.refreshData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
        child: Form(
          key: _formKey,
          child: VisitRegisterForm(controller: c, formKey: _formKey),
        ),
      ),
    );
  }
}
