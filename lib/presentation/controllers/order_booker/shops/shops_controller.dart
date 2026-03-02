import 'package:get/get.dart';

class ShopsController extends GetxController {
  final selectedTabIndex = 0.obs;

  void setTab(int index) => selectedTabIndex.value = index;

  /// Callback set by [ShopsScreen] to switch to My Shops tab (e.g. after register success).
  void Function()? switchToMyShopsTab;

  /// Switches to My Shops tab and refreshes list. Call after successful shop registration.
  void goToMyShopsTab() => switchToMyShopsTab?.call();
}
