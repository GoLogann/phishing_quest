import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/admin/admin_controller.dart';
import 'package:phishing_quest/app/modules/admin/admin_view.dart';
import 'package:phishing_quest/app/modules/game/game_binding.dart';
import 'package:phishing_quest/app/modules/game/game_flow_view.dart';
import 'package:phishing_quest/app/modules/game/game_result_view.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_module.dart';
import 'package:phishing_quest/app/modules/initial/flow_initial/flow_initial_module.dart';
import 'package:phishing_quest/app/modules/initial/login/login_module.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_module.dart';
import 'package:phishing_quest/app/modules/main_shell/main_shell_module.dart';
import 'package:phishing_quest/app/routes/middlewares/admin_middleware.dart';
import 'package:phishing_quest/app/routes/middlewares/auth_middleware.dart';

class AppPages {
  AppPages._();

  static final routes = [
    // Auth
    FlowInitialModule.page,
    LoginModule.page,
    UserRegisterModule.page,

    // Main (shell com BottomNav) — requer autenticação
    MainShellModule.page,

    // Game Flow — tela fullscreen fora do shell
    GetPage(
      name: '/game',
      page: () => const GameFlowView(),
      binding: GameBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/game/result',
      page: () => const GameResultView(),
      middlewares: [AuthMiddleware()],
    ),

    // Admin — requer role admin
    GetPage(
      name: '/admin',
      page: () => const AdminView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AdminController>(() => AdminController());
      }),
      middlewares: [AuthMiddleware(), AdminMiddleware()],
    ),

    // Legacy (mantido para compatibilidade)
    HomePageModule.page,
  ];
}
