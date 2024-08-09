import 'package:phishing_quest/app/modules/home_page/home_page_module.dart';
import 'package:phishing_quest/app/modules/initial/flow_initial/flow_initial_module.dart';
import 'package:phishing_quest/app/modules/initial/login/login_module.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_module.dart';

class AppPages {
  AppPages._();

  static final routes = [
    FlowInitialModule.page,
    HomePageModule.page,
    LoginModule.page,
    UserRegisterModule.page,
  ];
}
