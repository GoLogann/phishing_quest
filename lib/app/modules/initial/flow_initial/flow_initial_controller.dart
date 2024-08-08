import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/modules/register/userRegister/user_register_module.dart';

class FlowInitialController extends BaseController {

  void onRegister() {
    Get.toNamed(UserRegisterModule.path);
  }
}