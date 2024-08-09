import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/button.dart';
import 'package:phishing_quest/app/global_ui/components/safe_page.dart';

import 'flow_initial_controller.dart';

class FlowInitialView extends GetView<FlowInitialController> {
  const FlowInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafePage(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: 0.7.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppTheme.colors.primary,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/initial/background-image.jpeg',
                  ),
                  opacity: 0.08,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 99.h, bottom: 30.h),
                  child: Center(
                    child: Container(
                      width: .52.sw,
                      child: Image.asset("assets/images/logo.png",
                    width: 200.0, height: 275.0),
                    ),
                  ),
                ),
                Text(
                  'Aprende de forma gamificada sobre \n Golpes Virtuais',
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyles.header.copyWith(
                    color: AppTheme.colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 90.h),
                  child: Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.r),
                        topRight: Radius.circular(80.r),
                      ),
                      color: AppTheme.colors.whiteDark,
                    ),
                    child: Column(
                      
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40.h, bottom: 8.h),
                          child: Text(
                            'Seja bem-vindo ao Phishing Quest!',
                            textAlign: TextAlign.center,
                            style: AppTheme.textStyles.header.copyWith(
                              color: AppTheme.colors.primaryDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          'Laboratorio de Segurança e Criptografia Aplicada - LabSC',
                          textAlign: TextAlign.center,
                          style: AppTheme.textStyles.prePosLabel.copyWith(
                            color: AppTheme.colors.primaryLight,
                          ),
                        ),
                        Button(
                          textValue: 'Entrar',
                          textColor: AppTheme.colors.white,
                          margin: EdgeInsets.only(bottom: 17.h, top: 45.h),
                          onTouchCallback: controller.onLogin,
                        ),
                        Button(
                          textValue: 'Cadastre-se',
                          textColor: AppTheme.colors.primaryLight,
                          color: AppTheme.colors.whiteDark,
                          border: true,
                          onTouchCallback: controller.onRegister,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
