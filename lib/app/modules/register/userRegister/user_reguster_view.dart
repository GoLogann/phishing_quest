import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:phishing_quest/app/global_ui/components/safe_page.dart';
import 'package:phishing_quest/app/modules/register/userRegister/user_register_controller.dart';

class UserRegisterView extends GetView<UserRegisterController> {
  const UserRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
            color: Color(0xFFF69302),
          ),
          child: Column(
            children: [
              const SizedBox(
                width: 500,
                height: 300,
              ),
              Container(
                width: 500,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.r),
                  ),
                  color: Color(0xFFBA400A),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}