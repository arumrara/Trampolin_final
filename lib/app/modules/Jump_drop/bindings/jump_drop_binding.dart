import 'package:get/get.dart';

import '../controllers/jump_drop_controller.dart';

class JumpDropBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JumpDropController>(
      () => JumpDropController(),
    );
  }
}
