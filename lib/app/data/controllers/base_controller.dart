import 'package:get/get.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';

import '../request_repository.dart';

class BaseController extends GetxController {
  final Helpers helpers = Helpers();
  final isLoading = true.obs;

  void setLoading(bool status) => isLoading.value = status;

  void backPage() {
    Get.back();
  }

  // void openUser() {
  //   Get.toNamed(UserProfileModule.path);
  // }

  bool isValidResponse({required ValidResponse response, required String title, void Function()? action}) {
    if (response.valid && response.data != null) {
      return true;
    }

    if (action != null) {
      action();
    }

    // Toast.error(
    //   response.reason == '401' ? 'Sessão expirada!' : title,
    //   response.reason == '401' ? 'Sua sessão foi expirada, efetue seu login novamente' : response.reason!,
    //   delayed: true,
    // );

    setLoading(false);
    return false;
  }
}
