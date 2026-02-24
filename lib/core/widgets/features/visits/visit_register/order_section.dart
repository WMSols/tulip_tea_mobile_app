import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_text_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_message_banner.dart';
import 'package:tulip_tea_mobile_app/core/widgets/common/app_section_card.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_form_section_text/app_form_section_text.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/order_line_item_row.dart';
import 'package:tulip_tea_mobile_app/core/widgets/features/visits/visit_register/scheduled_date_field.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Order booking section: lines, scheduled date, final amount, resolution radios.
class OrderSection extends StatelessWidget {
  const OrderSection({super.key, required this.controller});

  final VisitRegisterController controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionCard(
          icon: Iconsax.box_1,
          title: AppTexts.orderDetails,
          titleColor: AppColors.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final isLoadingProducts = c.isLoadingProducts.value;
                return Column(
                  children: List.generate(
                    c.orderLines.length,
                    (i) => OrderLineItemRow(
                      index: i,
                      line: c.orderLines[i],
                      products: c.products,
                      isLoadingProducts: isLoadingProducts,
                      controller: c,
                    ),
                  ),
                );
              }),
              AppButton(
                label: AppTexts.addOrderItem,
                onPressed: c.addOrderLine,
                icon: Iconsax.add,
                iconPosition: IconPosition.left,
                primary: false,
              ),
              AppSpacing.vertical(context, 0.02),
              ScheduledDateField(controller: c),
              AppSpacing.vertical(context, 0.02),
              Obx(() {
                final calculatedTotal = c.calculatedOrderTotal;
                return Text(
                  '${AppTexts.calculatedTotal}: ${AppFormatter.formatCurrency(calculatedTotal)}',
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                );
              }),
              AppSpacing.vertical(context, 0.01),
              Text(
                AppTexts.finalOrderAmountOptional,
                style: AppTextStyles.labelText(context),
              ),
              AppSpacing.vertical(context, 0.004),
              AppFormSectionText(AppTexts.reduceAmountRequiresApproval),
              AppSpacing.vertical(context, 0.01),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: c.finalAmountController,
                      label: null,
                      hint: AppTexts.enterFinalAmount,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: c.setFinalTotalAmount,
                      validator: (v) {
                        final val = double.tryParse((v ?? '').trim());
                        if (val == null) return null;
                        final calc = c.calculatedOrderTotal;
                        if (val > calc) {
                          return AppTexts.finalAmountCannotExceedCalculated
                              .replaceAll(
                                '%s',
                                AppFormatter.formatCurrency(calc),
                              );
                        }
                        return null;
                      },
                    ),
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  AppTextButton(
                    label: AppTexts.reset,
                    onPressed: c.clearFinalAmount,
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.01),
              Obx(() {
                final finalStr = c.finalTotalAmount.value.trim();
                final finalVal = double.tryParse(finalStr);
                final calculated = c.calculatedOrderTotal;
                if (finalVal != null &&
                    finalVal < calculated &&
                    finalVal >= 0) {
                  final discount = calculated - finalVal;
                  final pct = calculated > 0
                      ? ((discount / calculated) * 100).toStringAsFixed(2)
                      : '0.00';
                  return AppMessageBanner(
                    message: AppTexts.subsidyRequestMessage
                        .replaceFirst(
                          '%s',
                          AppFormatter.formatCurrency(discount),
                        )
                        .replaceFirst('%s', '$pct%'),
                    type: AppMessageBannerType.warning,
                    showBorder: true,
                  );
                }
                return const SizedBox.shrink();
              }),
              AppSpacing.vertical(context, 0.02),
              AppMessageBanner(
                message: AppTexts.orderValidatedAgainstCreditLimit,
                type: AppMessageBannerType.warning,
                showBorder: false,
              ),
              AppSpacing.vertical(context, 0.02),
              Obx(() {
                final info = c.shopCreditInfo.value;
                final availableCredit = info?.availableCredit ?? 0;
                final finalStr = c.finalTotalAmount.value.trim();
                final finalVal = double.tryParse(finalStr);
                final calculated = c.calculatedOrderTotal;
                final effectiveTotal = (finalVal != null && finalVal > 0)
                    ? finalVal
                    : calculated;
                final showPaymentBeforeDeliveryOption =
                    effectiveTotal > availableCredit;
                if (!showPaymentBeforeDeliveryOption) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.conditionalOrderOptions,
                      style: AppTextStyles.labelText(context),
                    ),
                    AppSpacing.vertical(context, 0.008),
                    AppFormSectionText(AppTexts.conditionalOrderOptionsHelp),
                    AppSpacing.vertical(context, 0.01),
                    RadioGroup<String>(
                      groupValue: c.orderResolutionType.value,
                      onChanged: (v) =>
                          v != null ? c.setOrderResolutionType(v) : null,
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Text(AppTexts.normalOrderCreditSufficient),
                            value: orderResolutionNormal,
                            activeColor: AppColors.primary,
                          ),
                          RadioListTile<String>(
                            title: Text(AppTexts.paymentBeforeDelivery),
                            value: orderResolutionPaymentBeforeDelivery,
                            activeColor: AppColors.primary,
                          ),
                          AppFormSectionText(
                            AppTexts.paymentBeforeDeliveryHelp,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        AppSpacing.vertical(context, 0.02),
      ],
    );
  }
}
