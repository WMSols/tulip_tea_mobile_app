import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/order_booker/visits/visit_register/shop_credit_info_card.dart';
import 'package:tulip_tea_mobile_app/domain/entities/order_for_delivery_man.dart';
import 'package:tulip_tea_mobile_app/domain/entities/shop_credit_info.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/auth_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/daily_collection_use_case.dart';
import 'package:tulip_tea_mobile_app/domain/use_cases/shop_use_case.dart';

/// Daily Collection dialog for delivery man:
/// Shop Credit Information + Collection Amount + Remarks.
class DailyCollectionDialog extends StatefulWidget {
  const DailyCollectionDialog({super.key, required this.order});

  final OrderForDeliveryMan order;

  static Future<bool?> show(BuildContext context, OrderForDeliveryMan order) {
    return showDialog<bool>(
      context: context,
      builder: (_) => DailyCollectionDialog(order: order),
    );
  }

  @override
  State<DailyCollectionDialog> createState() => _DailyCollectionDialogState();
}

class _DailyCollectionDialogState extends State<DailyCollectionDialog> {
  final _amountController = TextEditingController(text: '0.00');
  final _remarksController = TextEditingController();
  bool _isLoading = true;
  bool _isSubmitting = false;
  ShopCreditInfo? _creditInfo;

  ShopUseCase get _shopUseCase => Get.find<ShopUseCase>();
  DailyCollectionUseCase get _dailyCollectionUseCase =>
      Get.find<DailyCollectionUseCase>();
  AuthUseCase get _authUseCase => Get.find<AuthUseCase>();

  @override
  void initState() {
    super.initState();
    _loadCreditInfo();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _loadCreditInfo() async {
    final shopId = widget.order.shopId;
    if (shopId == null) {
      setState(() {
        _isLoading = false;
        _creditInfo = null;
      });
      return;
    }
    try {
      final info = await _shopUseCase.getShopCreditInfo(shopId);
      if (!mounted) return;
      setState(() {
        _creditInfo = info;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submit() async {
    final shopId = widget.order.shopId;
    if (shopId == null) return;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final remarks = _remarksController.text.trim();
    setState(() => _isSubmitting = true);
    try {
      final user = await _authUseCase.getCurrentUser();
      if (user == null) throw Exception('User not found');
      await _dailyCollectionUseCase.submitCollectionByDeliveryMan(
        deliveryManId: user.id,
        shopId: shopId,
        amount: amount,
        collectedAt: DateTime.now().toIso8601String(),
        remarks: remarks.isEmpty ? null : remarks,
        orderId: widget.order.id,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (mounted) {
        AppToast.showError(AppTexts.error, AppTexts.requestFailedTryAgain);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopId = widget.order.shopId;
    return AlertDialog(
      title: Text(
        '${AppTexts.dailyCollectionLabel} - ${AppTexts.orderId} #${widget.order.id}',
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (shopId == null)
                const Text(AppTexts.notAvailable)
              else if (_creditInfo != null)
                ShopCreditInfoCard(info: _creditInfo!)
              else
                const Text(AppTexts.notAvailable),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                label: AppTexts.collectionAmountRs,
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              AppSpacing.vertical(context, 0.015),
              AppTextField(
                label: AppTexts.remarks,
                hint: AppTexts.addNotesAboutCollection,
                controller: _remarksController,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        AppTextButton(
          label: AppTexts.cancel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppSpacing.horizontal(context, 0.02),
        AppButton(
          icon: Iconsax.tick_circle,
          label: AppTexts.submitCollection,
          isLoading: _isSubmitting,
          onPressed: _isSubmitting ? null : _submit,
        ),
      ],
    );
  }
}
