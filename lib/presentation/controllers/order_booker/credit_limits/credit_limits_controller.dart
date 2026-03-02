import 'package:get/get.dart';

class CreditLimitsController extends GetxController {
  final selectedTabIndex = 0.obs;

  void setTab(int index) => selectedTabIndex.value = index;

  /// Callback set by [CreditLimitsScreen] to switch to My Requests tab (e.g. after request success).
  void Function()? switchToMyRequestsTab;

  /// Switches to My Requests tab and refreshes list. Call after successful credit limit request.
  void goToMyRequestsTab() => switchToMyRequestsTab?.call();
}
