import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class RatingStars extends StatelessWidget {
  final int rating; // 0 to 5
  final double? starSize;
  final bool showLabel;

  const RatingStars({
    required this.rating,
    this.starSize,
    this.showLabel = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = starSize ?? 24.sp;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          final isFilled = index < rating;
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              color: isFilled ? AppTheme.colors.accentLight : AppTheme.colors.textMuted,
              size: size,
            ),
          );
        }),
        if (showLabel) ...[
          SizedBox(width: 8.w),
          Text(
            '$rating/5',
            style: AppTheme.textStyles.label.copyWith(
              color: AppTheme.colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
