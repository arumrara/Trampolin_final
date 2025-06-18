import 'package:get/get.dart';

import '../controllers/seat_drop_controller.dart';

class SeatDropBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatDropController>(
      () => SeatDropController(),
    );
  }
}
