import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/game/game_flow_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameFlowController>(() => GameFlowController());
  }
}
