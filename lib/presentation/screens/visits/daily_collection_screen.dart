import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tulip_tea_order_booker/core/utils/app_spacing/app_spacing.dart';
import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
// import 'package:tulip_tea_order_booker/core/utils/app_validators/app_validators.dart';
import 'package:tulip_tea_order_booker/core/widgets/buttons/app_button.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:tulip_tea_order_booker/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:tulip_tea_order_booker/domain/entities/order_entity.dart';
import 'package:tulip_tea_order_booker/domain/entities/shop.dart';
import 'package:tulip_tea_order_booker/presentation/controllers/visits/daily_collection_controller.dart';

class DailyCollectionScreen extends StatefulWidget {
  const DailyCollectionScreen({super.key});

  @override
  State<DailyCollectionScreen> createState() => _DailyCollectionScreenState();
}

class _DailyCollectionScreenState extends State<DailyCollectionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DailyCollectionController>();
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.vertical(context, 0.01),
            Obx(() {
              Shop? selectedShop;
              if (c.selectedShopId.value != null && c.shops.isNotEmpty) {
                try {
                  selectedShop = c.shops.firstWhere(
                    (s) => s.id == c.selectedShopId.value,
                  );
                } catch (_) {}
              }
              return AppDropdownField<Shop>(
                label: AppTexts.selectShop,
                hint: AppTexts.selectShop,
                required: true,
                value: selectedShop,
                items: c.shops,
                getLabel: (s) => s.name,
                onChanged: (s) => c.setSelectedShopId(s?.id),
                // validator: (v) => v == null
                //     ? AppValidators.validateRequired(null, AppTexts.selectShop)
                //     : null,
              );
            }),
            AppSpacing.vertical(context, 0.02),
            Obx(() {
              if (c.isLoadingOrders.value || c.orders.isEmpty) {
                return const SizedBox.shrink();
              }
              OrderEntity? selectedOrder;
              if (c.selectedOrderId.value != null && c.orders.isNotEmpty) {
                try {
                  selectedOrder = c.orders.firstWhere(
                    (o) => o.id == c.selectedOrderId.value,
                  );
                } catch (_) {}
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppDropdownField<OrderEntity?>(
                    label: AppTexts.linkToOrder,
                    hint: AppTexts.selectOrderOptional,
                    value: selectedOrder,
                    items: [null, ...c.orders],
                    getLabel: (o) {
                      if (o == null) return '-';
                      final sid = o.shopId;
                      return sid > 0
                          ? 'Order #${o.id} • Shop #$sid'
                          : 'Order #${o.id}';
                    },
                    onChanged: (o) => c.setSelectedOrderId(o?.id),
                  ),
                  AppSpacing.vertical(context, 0.02),
                ],
              );
            }),
            AppTextField(
              label: AppTexts.collectionAmount,
              hint: AppTexts.collectionAmount,
              required: true,
              prefixIcon: Iconsax.wallet_money,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: c.setAmount,
              // validator: (v) => AppValidators.validatePositiveNumber(
              //   v,
              //   AppTexts.collectionAmount,
              // ),
            ),
            AppSpacing.vertical(context, 0.02),
            AppTextField(
              label: AppTexts.collectionRemarks,
              hint: AppTexts.collectionRemarks,
              prefixIcon: Iconsax.note,
              maxLines: 2,
              onChanged: c.setRemarks,
            ),
            AppSpacing.vertical(context, 0.03),
            Obx(
              () => AppButton(
                label: AppTexts.submit,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    c.submit();
                  }
                },
                isLoading: c.isSubmitting.value,
                icon: Iconsax.tick_circle,
                iconPosition: IconPosition.right,
              ),
            ),
            AppSpacing.vertical(context, 0.03),
          ],
        ),
      ),
    );
  }
}
