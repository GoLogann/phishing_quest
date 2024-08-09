import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/border_input.dart';
import 'package:phishing_quest/app/global_ui/components/button.dart';
import 'package:phishing_quest/app/modules/initial/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                  'Acessar Conta',
                  style: AppTheme.textStyles.header.copyWith(
                    color: const Color(0xFFFBA400A),
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
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40.h, bottom: 16.h),
                          child: Obx(
                            () => BorderInput(
                              hint: 'Seu e-mail',
                              // icon: AssetImage('assets/icons/email.png'),
                              type: TextInputType.emailAddress,
                              isDisabled: controller.isLoading.value,
                              validation: controller.validateEmail,
                              controller: controller.emailController,
                            ),
                          ),
                        ),
                        BorderInput(
                          hint: 'Sua senha',
                          isPassword: true,
                          isDisabled: controller.isLoading.value,
                          validation: controller.validatePassword,
                          controller: controller.passController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                         Button(
                          textValue: 'Entrar',
                          textColor: AppTheme.colors.white,
                          isDisabled: controller.isLoading.value,
                          onTouchCallback: controller.onLogin,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
                          child: TextButton(
                            onPressed: controller.onRegister,
                            child: RichText(
                              text: TextSpan(
                                text: 'Não possui uma conta? Realize o seu ',
                                style: AppTheme.textStyles.prePosLabel.copyWith(
                                  color: AppTheme.colors.primary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'cadastro aqui!',
                                    style: AppTheme.textStyles.prePosLabel.copyWith(
                                      color: AppTheme.colors.secondary,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
