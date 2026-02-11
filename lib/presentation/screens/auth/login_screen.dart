import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_bubble_background.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_footer.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/login/login_form.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/login/login_logo_section.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/auth/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LoginController>();
    return Scaffold(
      body: AppBubbleBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LoginLogoSection(
                            title: AppTexts.orderBookerName,
                            imagePath: AppImages.login,
                          ),
                          LoginForm(controller: c, formKey: _formKey),
                        ],
                      ),
                    ),
                  ),
                ),
                const AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
