import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class DifficultyChip extends StatelessWidget {
  final Difficulty difficulty;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool compact;

  const DifficultyChip({
    required this.difficulty,
    this.isSelected = false,
    this.onTap,
    this.compact = false,
    super.key,
  });

  Color get _color {
    switch (difficulty) {
      case Difficulty.easy:
        return AppTheme.colors.difficultyEasy;
      case Difficulty.medium:
        return AppTheme.colors.difficultyMedium;
      case Difficulty.hard:
        return AppTheme.colors.difficultyHard;
    }
  }

  IconData get _icon {
    switch (difficulty) {
      case Difficulty.easy:
        return Icons.sentiment_satisfied_alt;
      case Difficulty.medium:
        return Icons.sentiment_neutral;
      case Difficulty.hard:
        return Icons.local_fire_department;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12.w : 20.w,
          vertical: compact ? 6.h : 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? _color : _color.withOpacity(0.15),
          border: Border.all(
            color: _color,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: _color.withOpacity(0.3), blurRadius: 12)]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              color: isSelected ? Colors.white : _color,
              size: compact ? 14.sp : 18.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              difficulty.label,
              style: TextStyle(
                color: isSelected ? Colors.white : _color,
                fontSize: compact ? 11.sp : 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
