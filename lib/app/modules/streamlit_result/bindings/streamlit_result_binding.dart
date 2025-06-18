import 'package:get/get.dart';

import '../controllers/streamlit_result_controller.dart';

class StreamlitResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamlitResultController>(
      () => StreamlitResultController(),
    );
  }
}
