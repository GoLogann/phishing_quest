import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';

import 'app/data/enumerators/storage_keys.enum.dart';
import 'app/data/providers/pq_api_client/pq_api_client.provider.dart';
import 'app/data/storage/memory_storage.dart';
import 'app/main_getx_app.dart';
import 'app/modules/initial/flow_initial/flow_initial_module.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initProviders();

  final initialPage = getInitPage();
  FlutterNativeSplash.remove();

  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      splitScreenMode: false,
      builder: (_, __) => MainGetXApp(initialPage),
    ),
  );

}

String getInitPage() {
  final authToken = MemoryStore(StorageKeys.USER_TOKEN).read<String>() ?? '';
  if (authToken.isEmpty) {
    return FlowInitialModule.path;
  }
  return '';
}

Future<void> initProviders() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  await Helpers().setLocalMode(false);
  await Get.put<PqApiClient>(PqApiClient());

  await ScreenUtil.ensureScreenSize();
}

