import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class GameProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String? label;
  final double? height;
  final Color? color;

  const GameProgressBar({
    required this.progress,
    this.label,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final barHeight = height ?? 8.h;
    final barColor = color ?? AppTheme.colors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: AppTheme.textStyles.label.copyWith(
                  color: AppTheme.colors.textSecondary,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTheme.textStyles.label.copyWith(
                  color: barColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
        ],
        Container(
          height: barHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(barHeight),
            color: AppTheme.colors.surfaceBorder.withOpacity(0.3),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                    height: barHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(barHeight),
                      gradient: LinearGradient(
                        colors: [
                          barColor,
                          barColor.withOpacity(0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: barColor.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
