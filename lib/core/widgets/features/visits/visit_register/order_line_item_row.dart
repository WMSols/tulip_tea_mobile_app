import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:tulip_tea_mobile_app/core/network/connectivity_service.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_lotties/app_lotties.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_colors/app_colors.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_formatter/app_formatter.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_responsive/app_responsive.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_styles/app_text_styles.dart';
import 'package:tulip_tea_mobile_app/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_mobile_app/core/widgets/buttons/app_icon_button.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_empty_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_loading_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/feedback/app_dropdown_field_no_connection_placeholder.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_mobile_app/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_mobile_app/domain/entities/product.dart';
import 'package:tulip_tea_mobile_app/presentation/controllers/visits/visit_register_controller.dart';

/// Single order line: product dropdown, quantity, unit price, total, remove button.
class OrderLineItemRow extends StatelessWidget {
  const OrderLineItemRow({
    super.key,
    required this.index,
    required this.line,
    required this.products,
    required this.isLoadingProducts,
    required this.controller,
  });

  final int index;
  final VisitOrderLineInput line;
  final List<Product> products;
  final bool isLoadingProducts;
  final VisitRegisterController controller;

  /// Resolves dropdown value by matching product id from [products] list.
  /// Prevents Flutter DropdownButton assertion when line.product is a different
  /// instance than any in items (e.g. after products list refresh).
  static Product? _resolveDropdownValue(Product? selected, List<Product> products) {
    if (selected == null) return null;
    try {
      return products.firstWhere((p) => p.id == selected.id);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineTotal = line.quantity * line.unitPrice;
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.verticalValue(context, 0.02)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final connectivity = Get.isRegistered<ConnectivityService>()
                      ? Get.find<ConnectivityService>()
                      : null;
                  final isOffline =
                      connectivity != null && !connectivity.isOnline.value;
                  final showNoConnection =
                      isOffline && (isLoadingProducts || products.isEmpty);
                  if (showNoConnection) {
                    return AppDropdownFieldNoConnectionPlaceholder(
                      label: '${AppTexts.selectProduct} *',
                      required: true,
                      prefixIcon: Iconsax.box_1,
                    );
                  }
                  if (isLoadingProducts) {
                    return AppDropdownFieldLoadingPlaceholder(
                      label: '${AppTexts.selectProduct} *',
                      hint: AppTexts.loadingProducts,
                      required: true,
                      prefixIcon: Iconsax.box_1,
                    );
                  }
                  if (products.isEmpty) {
                    return AppDropdownFieldEmptyPlaceholder(
                      label: '${AppTexts.selectProduct} *',
                      message: AppTexts.noProductsYet,
                      required: true,
                      prefixIcon: Iconsax.box_1,
                    );
                  }
                  return AppDropdownField<Product?>(
                    hint: '${AppTexts.selectProduct} *',
                    value: _resolveDropdownValue(line.product, products),
                    items: [null, ...products],
                    getLabel: (p) {
                      if (p == null) return '-';
                      final code = p.code?.trim() ?? '';
                      final price = p.unitPrice != null
                          ? ' (${AppFormatter.formatCurrency(p.unitPrice!)})'
                          : '';
                      return code.isEmpty
                          ? '${p.name}$price'
                          : '${p.code} • ${p.name}$price';
                    },
                    onChanged: (p) => controller.setLineProduct(index, p),
                  );
                }),
              ),
              AppSpacing.horizontal(context, 0.02),
              AppIconButton(
                onPressed: () => controller.removeOrderLine(index),
                icon: Iconsax.trash,
                color: AppColors.white,
                backgroundColor: AppColors.error,
                size: AppResponsive.scaleSize(context, 24),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            hint: AppTexts.quantity,
            keyboardType: TextInputType.number,
            onChanged: (v) =>
                controller.setLineQuantity(index, int.tryParse(v) ?? 0),
          ),
          AppSpacing.vertical(context, 0.01),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${AppTexts.unitPrice}: ',
                style: AppTextStyles.labelText(context),
              ),
              if (isLoadingProducts)
                SizedBox(
                  width: AppResponsive.scaleSize(context, 18),
                  height: AppResponsive.scaleSize(context, 18),
                  child: Lottie.asset(AppLotties.loadingPrimary),
                )
              else
                Text(
                  AppFormatter.formatCurrency(line.unitPrice),
                  style: AppTextStyles.bodyText(context),
                ),
            ],
          ),
          AppSpacing.vertical(context, 0.008),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${AppTexts.total}: ',
                style: AppTextStyles.labelText(context),
              ),
              Text(
                isLoadingProducts
                    ? '—'
                    : AppFormatter.formatCurrency(lineTotal),
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
