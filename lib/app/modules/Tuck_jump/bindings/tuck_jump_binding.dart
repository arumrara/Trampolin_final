import 'package:get/get.dart';

import '../controllers/tuck_jump_controller.dart';

class TuckJumpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TuckJumpController>(
      () => TuckJumpController(),
    );
  }
}
