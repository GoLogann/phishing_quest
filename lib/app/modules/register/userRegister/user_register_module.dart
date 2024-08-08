import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/register/userRegister/user_reguster_view.dart';
import 'user_register_binding.dart';

abstract class UserRegisterModule {
  static const path = '/user-register';

  static GetPage page = GetPage(
    name: path,
    page: () => const UserRegisterView(),
    binding: UserRegisterBinding(),
  );
}
