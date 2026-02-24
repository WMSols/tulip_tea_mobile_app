import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_fonts/app_fonts.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_helper/app_helper.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_custom_app_bar.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/domain/entities/credit_limit_request.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/routes/app_routes.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/credit_limit_request_use_case.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/credit_limits/my_requests_controller.dart';

/// Full-screen form to resubmit a disapproved credit limit request.
/// Shows distributor's remarks (from my-requests) then form. PUT /credit-limit-requests/{request_id}/resubmit.
class RequestAgainScreen extends StatefulWidget {
  const RequestAgainScreen({super.key});

  @override
  State<RequestAgainScreen> createState() => _RequestAgainScreenState();
}

class _RequestAgainScreenState extends State<RequestAgainScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _limitController;
  late final TextEditingController _remarksController;
  bool _isSubmitting = false;
  CreditLimitRequest? _request;

  @override
  void initState() {
    super.initState();
    _request = Get.arguments as CreditLimitRequest?;
    _limitController = TextEditingController(
      text: _request?.requestedCreditLimit.toStringAsFixed(0) ?? '',
    );
    // Leave remarks empty: distributor's remarks are shown above; this field is for the order booker's new remarks.
    _remarksController = TextEditingController();
  }

  @override
  void dispose() {
    _limitController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_request == null) {
      AppToast.showError(AppTexts.error, AppTexts.notAvailable);
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    final amount = double.tryParse(_limitController.text.trim());
    if (amount == null || amount < 0) {
      AppToast.showError(
        AppTexts.error,
        AppTexts.enterValidRequestedCreditLimit,
      );
      return;
    }
    final user = await Get.find<AuthUseCase>().getCurrentUser();
    if (user == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseLogInAgain);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await Get.find<CreditLimitRequestUseCase>().updateRequest(
        _request!.id,
        requestedCreditLimit: amount,
        remarks: AppHelper.isNullOrEmpty(_remarksController.text.trim())
            ? null
            : _remarksController.text.trim(),
      );
      await Get.find<MyRequestsController>().loadRequests();
      // Navigate first so toast uses a valid context (avoids "disposed snackbar" when Get.back closes overlay).
      Get.back();
      if (Get.currentRoute == AppRoutes.myRequestDetails) Get.back();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppToast.showSuccess(
          AppTexts.success,
          AppTexts.creditLimitRequestSubmitted,
        );
      });
    } catch (e) {
      AppToast.showError(
        AppTexts.error,
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_request == null) {
      return Scaffold(
        appBar: const AppCustomAppBar(title: AppTexts.requestAgain),
        body: const Center(child: Text(AppTexts.notAvailable)),
      );
    }

    final distributorRemarksText = _request!.remarks?.trim();
    final hasDistributorRemarks =
        distributorRemarksText != null && distributorRemarksText.isNotEmpty;

    return Scaffold(
      appBar: const AppCustomAppBar(title: AppTexts.requestAgain),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalValue(context, 0.05),
          vertical: 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppTexts.requestAgainDescription,
                style: AppTextStyles.hintText(context),
              ),
              AppSpacing.vertical(context, 0.03),
              Text(
                AppTexts.distributorRemarks,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.primaryFont,
                  color: AppColors.black,
                ),
              ),
              Text(
                hasDistributorRemarks
                    ? distributorRemarksText
                    : AppTexts.noRemarksFromDistributor,
                style: AppTextStyles.hintText(context).copyWith(
                  color: hasDistributorRemarks
                      ? AppColors.error
                      : AppColors.grey,
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                label: AppTexts.requestedCreditLimit,
                hint: AppTexts.requestedCreditLimit,
                required: true,
                prefixIcon: Iconsax.wallet_3,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _limitController,
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                label: AppTexts.remarks,
                hint: AppTexts.remarks,
                prefixIcon: Iconsax.note,
                maxLines: 2,
                controller: _remarksController,
              ),
              AppSpacing.vertical(context, 0.04),
              AppButton(
                label: AppTexts.submit,
                onPressed: _isSubmitting ? null : _submit,
                isLoading: _isSubmitting,
                icon: Iconsax.tick_circle,
                iconPosition: IconPosition.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
