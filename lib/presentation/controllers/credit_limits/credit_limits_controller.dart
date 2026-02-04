import 'package:get/get.dart';

class CreditLimitsController extends GetxController {
  final selectedTabIndex = 0.obs;

  void setTab(int index) => selectedTabIndex.value = index;
}
