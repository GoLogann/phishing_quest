import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/data/util/helpers/index.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class Button extends StatelessWidget {
  final String textValue;
  final bool border;
  final bool isDisabled;
  final Color? textColor;
  final void Function()? onTouchCallback;
  final EdgeInsets? margin;
  final Color? color;
  final double? minWidth;
  final EdgeInsets? padding;

  const Button({
    required this.textValue,
    this.textColor,
    this.isDisabled = false,
    this.border = false,
    this.onTouchCallback,
    this.margin,
    this.color,
    this.minWidth,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.3.sh, minWidth: minWidth ?? 0.91.sw),
      color: Colors.transparent,
      margin: margin,
      child: InkWell(
        onTap: isDisabled ? null : onTouchCallback,
        child: Container(
          padding: padding ?? Helpers().paddingAll(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(42.r),
            color: color ?? AppTheme.colors.secondary,
            border: border
                ? Border.fromBorderSide(
                    BorderSide(
                      width: 1.0.w,
                      color: AppTheme.colors.primaryLightBorder,
                    ),
                  )
                : null,
          ),
          child: Text(
            textValue,
            textAlign: TextAlign.center,
            style: AppTheme.textStyles.posLabel.copyWith(
              color: textColor ?? AppTheme.colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
