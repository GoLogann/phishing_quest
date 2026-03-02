import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class ScoreBadge extends StatelessWidget {
  final int score;
  final double? size;
  final Color? color;
  final bool showLabel;

  const ScoreBadge({
    required this.score,
    this.size,
    this.color,
    this.showLabel = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final badgeSize = size ?? 70.r;
    final badgeColor = color ?? AppTheme.colors.accent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: badgeSize,
          height: badgeSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                badgeColor,
                badgeColor.withOpacity(0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: badgeColor.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$score',
              style: AppTheme.textStyles.title.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: badgeSize * 0.28,
              ),
            ),
          ),
        ),
        if (showLabel) ...[
          SizedBox(height: 4.h),
          Text(
            'PONTOS',
            style: AppTheme.textStyles.prepreLabel.copyWith(
              color: AppTheme.colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}
