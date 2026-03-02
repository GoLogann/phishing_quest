import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/main_shell/main_shell_binding.dart';
import 'package:phishing_quest/app/modules/main_shell/main_shell_view.dart';

class MainShellModule {
  static const String path = '/main';

  static GetPage get page => GetPage(
    name: path,
    page: () => const MainShellView(),
    binding: MainShellBinding(),
  );
}
