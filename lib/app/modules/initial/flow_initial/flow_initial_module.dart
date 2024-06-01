import 'package:get/get.dart';
import 'package:phishing_quest/app/modules/initial/flow_initial/flow_initial_binding.dart';

import 'flow_initial_view.dart';


abstract class FlowInitialModule {
  static const path = '/flow-initial';

  static GetPage page = GetPage(
    name: path,
    page: () => const FlowInitialView(),
    binding: FlowInitialBinding(),
  );
}
