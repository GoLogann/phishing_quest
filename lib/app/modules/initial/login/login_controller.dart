import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/data/repositories/login/login_repository.dart';
import 'package:phishing_quest/app/global_ui/components/toast.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_module.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_module.dart';

class LoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void onInit() {
    super.onInit();

    if (kDebugMode) {
      emailController.text = 'teste2@teste.com.br';
      passController.text = '123123123';
    }

    // CachedRequest(key: StorageKeys.PROFILE_INFO).invalidateCache();
    // CachedRequest(key: StorageKeys.ACTIVE_NOTICES).invalidateCache();
    // MemoryStore(StorageKeys.USER_TOKEN).remove();
    setLoading(false);
  }

  String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) {
      return 'Campo obrigatório';
    }

    if (!email!.isEmail) {
      return 'Formato de email inválido';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Campo obrigatório';
    }

    // TODO: Adicionar a regra de negócio para a senha
    if (password!.length <= 4) {
      return 'Senha não pode ser menor que 4 dígitos';
    }

    return null;
  }

  Future<void> onLogin() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      setLoading(true);

      final loginRepo = await LoginRepository().login(
        email: emailController.text,
        password: passController.text,
      );

      print(loginRepo);

      Get.offAllNamed(HomePageModule.path);
      setLoading(false);
    }
  }

  void onRegister() {
    Get.toNamed(UserRegisterModule.path);
  }
}
