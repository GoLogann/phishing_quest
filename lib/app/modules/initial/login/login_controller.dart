import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/data/repositories/login/login_repository.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';
import 'package:phishing_quest/app/global_ui/components/toast.dart';
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

    if (password!.length <= 4) {
      return 'Senha não pode ser menor que 4 dígitos';
    }

    return null;
  }

  Future<void> onLogin() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      setLoading(true);

      try {
        final loginRepo = LoginRepository();
        final result = await loginRepo.login(
          email: emailController.text,
          password: passController.text,
        );

        if (!result.valid) {
          setLoading(false);
          Toast.error('Erro no login', result.reason ?? 'Tente novamente');
          return;
        }

        // Save token and user data
        final authService = Get.find<AuthService>();
        await authService.login(
          token: 'mock-token-${DateTime.now().millisecondsSinceEpoch}',
          userData: {
            'id': 'u-current',
            'username': emailController.text.split('@').first,
            'email': emailController.text,
            'role': 'player',
            'score': 0,
          },
        );

        Get.offAllNamed('/main');
      } catch (_) {
        Toast.error('Erro', 'Não foi possível realizar o login');
      }

      setLoading(false);
    }
  }

  void onRegister() {
    Get.toNamed(UserRegisterModule.path);
  }
}
