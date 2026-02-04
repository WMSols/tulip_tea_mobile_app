import 'package:flutter/material.dart';

import 'package:tulip_tea_order_booker/core/widgets/feedback/app_toast.dart';

extension ContextExtensions on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    if (isError) {
      AppToast.showError('Error', message);
    } else {
      AppToast.showInformation('Info', message);
    }
  }
}
