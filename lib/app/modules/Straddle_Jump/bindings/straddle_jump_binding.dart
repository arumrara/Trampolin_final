import 'package:get/get.dart';

import '../controllers/straddle_jump_controller.dart';

class StraddleJumpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StraddleJumpController>(
      () => StraddleJumpController(),
    );
  }
}
