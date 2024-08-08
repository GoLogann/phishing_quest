import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/border_input.dart';
import 'package:phishing_quest/app/global_ui/components/button.dart';
import 'package:phishing_quest/app/modules/register/userRegister/user_register_controller.dart';

class UserRegisterView extends GetView<UserRegisterController> {
  const UserRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF69302),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset("assets/images/logo.png",
                    width: 160.0, height: 160.0),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h, left: 25.w),
                child: Text(
                  'Cadastrar dados pessoais',
                  style: AppTheme.textStyles.title.copyWith(
                    color: AppTheme.colors.primaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: 500,
                height: 600,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBA400A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.r),
                  ),
                  child: Form(
                    key: controller.registerFormKey,
                    child: Container(
                      color: const Color(0xFFFBA400A),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: BorderInput(
                              hint: 'Nome',
                              type: TextInputType.text,
                              validation: controller.validateName,
                              controller: controller.usernameController,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: BorderInput(
                              hint: 'Email',
                              type: TextInputType.text,
                              validation: controller.validateName,
                              controller: controller.emailController,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: BorderInput(
                              hint: 'Senha',
                              type: TextInputType.text,
                              validation: controller.validateName,
                              controller: controller.passwordController,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Button(
                              textValue: "Cadastrar",
                              onTouchCallback: controller.onRegister,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 26.h),
                              child: TextButton(
                                onPressed: controller.onLogin,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Já possui uma conta? Realize o seu ',
                                    style:
                                        AppTheme.textStyles.prePosLabel.copyWith(
                                      color: AppTheme.colors.primary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'login aqui!',
                                        style: AppTheme.textStyles.prePosLabel
                                            .copyWith(
                                          color: AppTheme.colors.secondary,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
