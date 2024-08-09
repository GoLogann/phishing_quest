import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/home_page/home_page_controller.dart';


class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(
      () => HomePageController(),
    );
  }
}
