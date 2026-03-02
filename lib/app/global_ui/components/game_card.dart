import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class GameCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final bool hasGlow;
  final Color? glowColor;
  final double? borderRadius;

  const GameCard({
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.hasGlow = false,
    this.glowColor,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 20.r;
    final glow = glowColor ?? AppTheme.colors.primary;

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: AppTheme.colors.backgroundCard,
        border: Border.all(
          color: hasGlow ? glow.withOpacity(0.3) : AppTheme.colors.surfaceBorder.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: glow.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: glow.withOpacity(0.1),
          highlightColor: glow.withOpacity(0.05),
          child: Padding(
            padding: padding ?? EdgeInsets.all(16.r),
            child: child,
          ),
        ),
      ),
    );
  }
}
