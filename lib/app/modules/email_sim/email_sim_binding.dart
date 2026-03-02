import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/email_sim/email_sim_controller.dart';

class EmailSimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailSimController>(() => EmailSimController());
  }
}
