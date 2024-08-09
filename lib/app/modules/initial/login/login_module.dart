import 'package:get/get.dart';
import 'login_binding.dart';
import 'login_view.dart';

abstract class LoginModule {
  static const path = '/login';

  static GetPage page = GetPage(
    name: path,
    page: () => const LoginView(),
    binding: LoginBinding(),
  );
}
