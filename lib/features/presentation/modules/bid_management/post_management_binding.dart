import 'package:get/get.dart';
import 'post_management_controller.dart';

class BidManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BidManagementController>(() => BidManagementController());
  }
}
