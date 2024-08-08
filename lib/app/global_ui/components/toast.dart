import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class Toast {
  static void success(String title, String body, {bool delayed = false}) {
    _defaultSnackbar(
      title: title,
      body: body,
      icon: Icons.check_circle,
      color: AppTheme.colors.sucess,
      delayed: delayed,
    );
  }

  static void alert(String title, String body, {bool delayed = false}) {
    _defaultSnackbar(
      title: title,
      body: body,
      icon: Icons.warning_rounded,
      color: AppTheme.colors.alert,
      delayed: delayed,
    );
  }

  static void error(String title, String body, {bool delayed = false}) {
    _defaultSnackbar(
      title: title,
      body: body,
      icon: Icons.error_rounded,
      color: AppTheme.colors.error,
      delayed: delayed,
    );
  }

  static void _defaultSnackbar({
    required String title,
    required String body,
    required IconData icon,
    required Color color,
    bool delayed = false,
  }) {
    Future.delayed(
      Duration(milliseconds: delayed ? 150 : 0),
      () {
        SnackbarController.cancelAllSnackbars();

        return Get.snackbar(
          '',
          '',
          titleText: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(
              title,
              style: AppTheme.textStyles.posLabel.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.colors.primary,
              ),
            ),
          ),
          messageText: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(
              body,
              style: AppTheme.textStyles.label.copyWith(
                color: AppTheme.colors.primary,
              ),
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Icon(
              icon,
              color: color,
              size: 30.sp,
            ),
          ),
          shouldIconPulse: false,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          borderRadius: 24.r,
          margin: Helpers().paddingAll(14),
          duration: const Duration(seconds: 4),
          forwardAnimationCurve: Curves.easeOutBack,
          snackPosition: Get.isBottomSheetOpen ?? false ? SnackPosition.TOP : SnackPosition.BOTTOM,
          backgroundColor: AppTheme.colors.white,
          overlayBlur: 1,
          overlayColor: AppTheme.colors.backOpacity,
          snackbarStatus: (status) => status == SnackbarStatus.CLOSING ? SnackbarController.cancelAllSnackbars() : null,
        );
      },
    );
  }
}
