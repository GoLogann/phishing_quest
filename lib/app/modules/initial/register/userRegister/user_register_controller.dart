import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/data/repositories/register/register_repository.dart';
import 'package:phishing_quest/app/global_ui/components/toast.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_module.dart';

class UserRegisterController extends BaseController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  String? validateName(String? nome) {
    if (nome?.isEmpty ?? true) {
      return 'Campo obrigatório';
    }

    if (nome!.length <= 2) {
      return 'Por favor, adicione seu nome completo';
    }

    return null;
  }

    Future onRegister() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      final registerRepo = RegisterRepository();
      final register = await registerRepo.register(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
      );
    
      if (!register.valid) {
        setLoading(false);
        return Toast.error('Não foi possível realizar o cadastro', register.reason!, delayed: true);
      }
    
      Get.offAllNamed(HomePageModule.path);
      setLoading(false);
    }
  }

    void onLogin() {
    // Get.toNamed(LoginModule.path);
  }
}