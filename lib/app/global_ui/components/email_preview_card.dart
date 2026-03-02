import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';

class EmailPreviewCard extends StatelessWidget {
  final String remetente;
  final String receptor;
  final String assunto;
  final String conteudo;
  final List<String> links;
  final bool expanded;
  final EdgeInsets? margin;

  const EmailPreviewCard({
    required this.remetente,
    required this.receptor,
    required this.assunto,
    required this.conteudo,
    this.links = const [],
    this.expanded = true,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Header
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              border: Border(
                bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderRow('De:', remetente, isSuspicious: true),
                SizedBox(height: 6.h),
                _buildHeaderRow('Para:', receptor),
                SizedBox(height: 6.h),
                _buildHeaderRow('Assunto:', assunto, isBold: true),
              ],
            ),
          ),
          // Email Body
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              conteudo,
              style: TextStyle(
                color: const Color(0xFF1E293B),
                fontSize: 13.sp,
                height: 1.6,
                fontFamily: 'serif',
              ),
            ),
          ),
          // Links section
          if (links.isNotEmpty) ...[
            Divider(color: const Color(0xFFE2E8F0), height: 1),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.link, size: 14.sp, color: const Color(0xFF64748B)),
                      SizedBox(width: 6.w),
                      Text(
                        'Links no email:',
                        style: TextStyle(
                          color: const Color(0xFF64748B),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  ...links.map((link) => Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppTheme.colors.error.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppTheme.colors.error.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, size: 14.sp, color: AppTheme.colors.error),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              link,
                              style: TextStyle(
                                color: AppTheme.colors.error,
                                fontSize: 11.sp,
                                fontFamily: 'monospace',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderRow(String label, String value, {bool isBold = false, bool isSuspicious = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF64748B),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: isSuspicious ? const Color(0xFFDC2626) : const Color(0xFF1E293B),
              fontSize: 12.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
