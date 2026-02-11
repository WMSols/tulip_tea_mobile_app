import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/utils/app_texts/app_texts.dart';
import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';

extension ContextExtensions on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    if (isError) {
      AppToast.showError(AppTexts.error, message);
    } else {
      AppToast.showInformation(AppTexts.information, message);
    }
  }
}
