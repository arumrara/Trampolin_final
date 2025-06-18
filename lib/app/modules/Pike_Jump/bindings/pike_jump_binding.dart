import 'package:get/get.dart';

import '../controllers/pike_jump_controller.dart';

class PikeJumpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PikeJumpController>(
      () => PikeJumpController(),
    );
  }
}
