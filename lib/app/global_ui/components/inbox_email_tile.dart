import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class InboxEmailTile extends StatelessWidget {
  final String avatarInitial;
  final String senderName;
  final String subject;
  final String preview;
  final String time;
  final bool hasAttachment;
  final bool isEvaluated;
  final bool? wasCorrect;
  final VoidCallback onTap;

  const InboxEmailTile({
    required this.avatarInitial,
    required this.senderName,
    required this.subject,
    required this.preview,
    required this.time,
    this.hasAttachment = false,
    this.isEvaluated = false,
    this.wasCorrect,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatarColor = _colorFromName(senderName);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppTheme.colors.surfaceBorder.withOpacity(0.2),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 22.r,
                backgroundColor: avatarColor.withOpacity(0.2),
                child: Text(
                  avatarInitial,
                  style: TextStyle(
                    color: avatarColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            senderName,
                            style: AppTheme.textStyles.posLabel.copyWith(
                              fontWeight: isEvaluated ? FontWeight.w400 : FontWeight.w700,
                              color: isEvaluated
                                  ? AppTheme.colors.textSecondary
                                  : AppTheme.colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          time,
                          style: AppTheme.textStyles.prepreLabel.copyWith(
                            color: AppTheme.colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            subject,
                            style: AppTheme.textStyles.label.copyWith(
                              fontWeight: isEvaluated ? FontWeight.w400 : FontWeight.w600,
                              color: isEvaluated
                                  ? AppTheme.colors.textSecondary
                                  : AppTheme.colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isEvaluated && wasCorrect != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: wasCorrect!
                                  ? AppTheme.colors.success
                                  : AppTheme.colors.error,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            preview,
                            style: AppTheme.textStyles.prepreLabel.copyWith(
                              color: AppTheme.colors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (hasAttachment)
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Icon(
                              Icons.attach_file,
                              size: 14.sp,
                              color: AppTheme.colors.textMuted,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _colorFromName(String name) {
    final colors = [
      const Color(0xFF3B82F6),
      const Color(0xFFEF4444),
      const Color(0xFF22C55E),
      const Color(0xFFF97316),
      const Color(0xFF8B5CF6),
      const Color(0xFF06B6D4),
      const Color(0xFFEC4899),
    ];
    final hash = name.codeUnits.fold<int>(0, (prev, c) => prev + c);
    return colors[hash % colors.length];
  }
}
