import 'package:get/get.dart';

import '../controllers/wraper_controller.dart';

class WraperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WraperController>(
      () => WraperController(),
    );
  }
}
