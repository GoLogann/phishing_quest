import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_binding.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_view.dart';

abstract class HomePageModule {
  static const path = '/home';

  static GetPage page = GetPage(
    name: path,
    page: () => const HomePageView(),
    binding: HomePageBinding(),
  );
}
