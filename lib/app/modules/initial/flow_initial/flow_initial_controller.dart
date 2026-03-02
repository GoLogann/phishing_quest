import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/controllers/base_controller.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';
import 'package:phishing_quest/app/modules/initial/login/login_module.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_module.dart';

class FlowInitialController extends BaseController {

  Future<void> onLogin() async {
    // Bypass auth — login direto com dados mock para visualização
    final authService = Get.find<AuthService>();
    await authService.login(
      token: 'mock-token-${DateTime.now().millisecondsSinceEpoch}',
      userData: {
        'id': 'u-current',
        'username': 'Jogador',
        'email': 'jogador@phishingquest.com',
        'role': 'player',
        'score': 0,
      },
    );
    Get.offAllNamed('/main');
  }

  void onRegister() {
    Get.toNamed(UserRegisterModule.path);
  }
}
