import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/modules/initial/login/login_module.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_module.dart';

class FlowInitialController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void onLogin() {
    Get.toNamed(LoginModule.path);
  }

  void onRegister() {
    Get.toNamed(UserRegisterModule.path);
  }
}
