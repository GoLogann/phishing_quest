import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

import 'flow_initial_controller.dart';

class FlowInitialView extends GetView<FlowInitialController> {
  const FlowInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              children: [
                // Top section — logo + tagline
                Expanded(
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.colors.primary.withOpacity(0.15),
                          AppTheme.colors.backgroundDark,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInDown(
                          child: Container(
                            width: 140.r,
                            height: 140.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.colors.primary.withOpacity(0.3),
                                  AppTheme.colors.accent.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shield_outlined,
                                size: 72.sp,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            'Phishing Quest',
                            style: AppTheme.textStyles.display.copyWith(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          delay: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Text(
                              'Aprenda de forma gamificada sobre\nGolpes Virtuais',
                              textAlign: TextAlign.center,
                              style: AppTheme.textStyles.posLabel.copyWith(
                                color: AppTheme.colors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom section — welcome + buttons
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    decoration: BoxDecoration(
                      color: AppTheme.colors.backgroundCard,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: Text(
                            'Seja bem-vindo!',
                            style: AppTheme.textStyles.title.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 450),
                          child: Text(
                            'LabSC — Segurança e Criptografia Aplicada',
                            style: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        // Entrar
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: GestureDetector(
                            onTap: controller.onLogin,
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
                                child: Text(
                                  'Entrar',
                                  style: AppTheme.textStyles.subTitle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Cadastre-se
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: GestureDetector(
                            onTap: controller.onRegister,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.transparent,
                                border: Border.all(
                                  color: AppTheme.colors.surfaceBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Cadastre-se',
                                  style: AppTheme.textStyles.subTitle.copyWith(
                                    color: AppTheme.colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
