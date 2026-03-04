import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/constants/app_constants.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_images/app_images.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_bubble_background.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_footer.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/common/login/login_form.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/common/login/login_logo_section.dart';
import 'package:tulip_tea_mobile_app/data/data_sources/local/secure_storage_source.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/common/auth/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginController _loginController;
  String _userRole = AppConstants.roleOrderBooker;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    _loginController = Get.find<LoginController>();
    final storage = Get.find<SecureStorageSource>();

    try {
      // First check if role was passed as argument (from role switch)
      final args = Get.arguments;
      if (args != null && args['role'] != null) {
        setState(() {
          _userRole = args['role'];
          _isLoading = false;
        });
        _loginController.setRole(args['role']);
        return;
      }

      // Get saved role from storage
      final savedRole = await storage.getUserRole();

      if (savedRole != null && savedRole.isNotEmpty) {
        setState(() {
          _userRole = savedRole;
        });
        _loginController.setRole(savedRole);
      } else {
        // Default to Order Booker if no role saved
        _loginController.setRole(AppConstants.roleOrderBooker);
      }
    } catch (e) {
      // Default to Order Booker on error
      _loginController.setRole(AppConstants.roleOrderBooker);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: AppResponsive.scaleSize(context, 50),
            height: AppResponsive.scaleSize(context, 50),
            child: Lottie.asset(AppLotties.loadingPrimary),
          ),
        ),
      );
    }

    final isOrderBooker = _userRole == AppConstants.roleOrderBooker;

    return Scaffold(
      body: AppBubbleBackground(
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Section - changes based on selected role
                LoginLogoSection(
                  title: isOrderBooker
                      ? AppTexts.orderBookerRoleName
                      : AppTexts.deliveryManRoleName,
                  imagePath: isOrderBooker
                      ? AppImages.obLogin
                      : AppImages.dmLogin,
                ),
                AppSpacing.vertical(context, 0.02),
                // Login Form
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: LoginForm(
                        controller: _loginController,
                        formKey: _formKey,
                        role: _userRole,
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
