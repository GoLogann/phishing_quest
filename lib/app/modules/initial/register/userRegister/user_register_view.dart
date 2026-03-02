import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/border_input.dart';
import 'package:phishing_quest/app/modules/initial/register/userRegister/user_register_controller.dart';

class UserRegisterView extends GetView<UserRegisterController> {
  const UserRegisterView({super.key});

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
                  Icons.person_add_outlined,
                  color: AppTheme.colors.accent,
                  size: 48.sp,
                ),
              ),
              SizedBox(height: 16.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Cadastre-se',
                  style: AppTheme.textStyles.display,
                ),
              ),
              SizedBox(height: 6.h),
              FadeInDown(
                delay: const Duration(milliseconds: 150),
                child: Text(
                  'Crie sua conta para começar a jogar',
                  style: AppTheme.textStyles.posLabel.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 36.h),
              // Form
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Form(
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      BorderInput(
                        hint: 'Nome de usuário',
                        type: TextInputType.text,
                        validation: controller.validateName,
                        controller: controller.usernameController,
                      ),
                      SizedBox(height: 16.h),
                      BorderInput(
                        hint: 'E-mail',
                        type: TextInputType.emailAddress,
                        validation: controller.validateEmail,
                        controller: controller.emailController,
                      ),
                      SizedBox(height: 16.h),
                      BorderInput(
                        hint: 'Senha',
                        isPassword: true,
                        validation: controller.validatePassword,
                        controller: controller.passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36.h),
              // Register Button
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: controller.onRegister,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.colors.accent,
                          AppTheme.colors.accent.withOpacity(0.8),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.colors.accent.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Cadastrar',
                        style: AppTheme.textStyles.subTitle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              // Login link
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Center(
                  child: GestureDetector(
                    onTap: controller.onLogin,
                    child: RichText(
                      text: TextSpan(
                        text: 'Já possui uma conta? ',
                        style: AppTheme.textStyles.label.copyWith(
                          color: AppTheme.colors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Faça login',
                            style: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.accent,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.colors.accent,
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
