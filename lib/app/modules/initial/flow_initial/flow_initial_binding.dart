import 'package:get/get.dart';

import 'flow_initial_controller.dart';

class FlowInitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlowInitialController>(() => FlowInitialController());
  }
}
