import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/border_input.dart';
import 'package:phishing_quest/app/modules/initial/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              // Back
              FadeInLeft(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppTheme.colors.backgroundCard,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.arrow_back, color: AppTheme.colors.textPrimary, size: 22.sp),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              // Header
              FadeInDown(
                child: Icon(
                  Icons.lock_outline,
                  color: AppTheme.colors.primary,
                  size: 48.sp,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Acessar Conta',
                  style: AppTheme.textStyles.display,
                ),
              ),
              SizedBox(height: 6.h),
              FadeInDown(
                delay: const Duration(milliseconds: 150),
                child: Text(
                  'Entre com suas credenciais para continuar',
                  style: AppTheme.textStyles.posLabel.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              // Form
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      Obx(() => BorderInput(
                        hint: 'Seu e-mail',
                        type: TextInputType.emailAddress,
                        isDisabled: controller.isLoading.value,
                        validation: controller.validateEmail,
                        controller: controller.emailController,
                      )),
                      SizedBox(height: 16.h),
                      Obx(() => BorderInput(
                        hint: 'Sua senha',
                        isPassword: true,
                        isDisabled: controller.isLoading.value,
                        validation: controller.validatePassword,
                        controller: controller.passController,
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36.h),
              // Login Button
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Obx(() => GestureDetector(
                  onTap: controller.isLoading.value ? null : controller.onLogin,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.colors.primary,
                          AppTheme.colors.primary.withOpacity(0.8),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.colors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 22.h,
                              width: 22.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Entrar',
                              style: AppTheme.textStyles.subTitle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                )),
              ),
              SizedBox(height: 28.h),
              // Register link
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Center(
                  child: GestureDetector(
                    onTap: controller.onRegister,
                    child: RichText(
                      text: TextSpan(
                        text: 'Não possui uma conta? ',
                        style: AppTheme.textStyles.label.copyWith(
                          color: AppTheme.colors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Cadastre-se',
                            style: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
