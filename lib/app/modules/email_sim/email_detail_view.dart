import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/data/models/inbox_email.model.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/phishing_link_popup.dart';
import 'package:phishing_quest/app/modules/email_sim/email_sim_controller.dart';

class EmailDetailView extends GetView<EmailSimController> {
  const EmailDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final emailIndex = args['emailIndex'] as int;
    final email = controller.inboxEmails[emailIndex];
    final isEvaluated = controller.isEmailEvaluated(email.id);

    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.backgroundCard,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Cosmetic icons for realism
          IconButton(
            icon: Icon(Icons.star_border, color: AppTheme.colors.textMuted),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: AppTheme.colors.textMuted),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppTheme.colors.textMuted),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject
                  FadeInDown(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                      color: AppTheme.colors.backgroundCard,
                      child: Text(
                        email.assunto,
                        style: AppTheme.textStyles.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // Sender info
                  FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                      decoration: BoxDecoration(
                        color: AppTheme.colors.backgroundCard,
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.colors.surfaceBorder.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: _avatarColor(email.remetenteNome).withOpacity(0.2),
                            child: Text(
                              email.avatarInitial,
                              style: TextStyle(
                                color: _avatarColor(email.remetenteNome),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        email.remetenteNome,
                                        style: AppTheme.textStyles.posLabel.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _formatDateTime(email.receivedAt),
                                      style: AppTheme.textStyles.prepreLabel.copyWith(
                                        color: AppTheme.colors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  email.remetente,
                                  style: AppTheme.textStyles.label.copyWith(
                                    color: AppTheme.colors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Para: ${email.receptor}',
                                  style: AppTheme.textStyles.prepreLabel.copyWith(
                                    color: AppTheme.colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Email body
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16.r),
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildEmailBody(email),
                    ),
                  ),
                  // Links section
                  if (email.links.isNotEmpty)
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: AppTheme.colors.backgroundCard,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppTheme.colors.surfaceBorder.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link, size: 16.sp, color: AppTheme.colors.textMuted),
                                SizedBox(width: 6.w),
                                Text(
                                  'Links encontrados neste email:',
                                  style: AppTheme.textStyles.label.copyWith(
                                    color: AppTheme.colors.textMuted,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ...email.links.map((link) => Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: GestureDetector(
                                onTap: () => _onLinkTap(email, link),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colors.primary.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.open_in_new, size: 14.sp, color: AppTheme.colors.primary),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          link,
                                          style: TextStyle(
                                            color: AppTheme.colors.primary,
                                            fontSize: 11.sp,
                                            fontFamily: 'monospace',
                                            decoration: TextDecoration.underline,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          // Bottom action
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppTheme.colors.backgroundCard,
              border: Border(
                top: BorderSide(color: AppTheme.colors.surfaceBorder.withOpacity(0.3)),
              ),
            ),
            child: SafeArea(
              top: false,
              child: GestureDetector(
                onTap: isEvaluated
                    ? null
                    : () => controller.showVerdictSheet(Get.context!, email),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: isEvaluated
                        ? null
                        : LinearGradient(colors: [
                            AppTheme.colors.accent,
                            AppTheme.colors.accent.withOpacity(0.8),
                          ]),
                    color: isEvaluated ? AppTheme.colors.surfaceBorder : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isEvaluated ? Icons.check_circle : Icons.shield_rounded,
                        color: isEvaluated ? AppTheme.colors.textMuted : Colors.white,
                        size: 22.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        isEvaluated ? 'Ja avaliado' : 'Avaliar este email',
                        style: AppTheme.textStyles.subTitle.copyWith(
                          color: isEvaluated ? AppTheme.colors.textMuted : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailBody(InboxEmailModel email) {
    if (email.links.isEmpty) {
      return Text(
        email.conteudo,
        style: TextStyle(
          color: const Color(0xFF1E293B),
          fontSize: 13.sp,
          height: 1.7,
          fontFamily: 'serif',
        ),
      );
    }

    // Parse content to make links clickable
    final spans = <InlineSpan>[];
    String remaining = email.conteudo;

    for (final link in email.links) {
      final idx = remaining.indexOf(link);
      if (idx >= 0) {
        if (idx > 0) {
          spans.add(TextSpan(
            text: remaining.substring(0, idx),
            style: TextStyle(
              color: const Color(0xFF1E293B),
              fontSize: 13.sp,
              height: 1.7,
              fontFamily: 'serif',
            ),
          ));
        }
        spans.add(TextSpan(
          text: link,
          style: TextStyle(
            color: const Color(0xFF2563EB),
            fontSize: 13.sp,
            height: 1.7,
            fontFamily: 'serif',
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF2563EB),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _onLinkTap(email, link),
        ));
        remaining = remaining.substring(idx + link.length);
      }
    }

    if (remaining.isNotEmpty) {
      spans.add(TextSpan(
        text: remaining,
        style: TextStyle(
          color: const Color(0xFF1E293B),
          fontSize: 13.sp,
          height: 1.7,
          fontFamily: 'serif',
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  void _onLinkTap(InboxEmailModel email, String url) {
    controller.onLinkTapped(email.id, url);

    if (email.isPhishing) {
      Get.dialog(
        PhishingLinkPopup(
          url: url,
          onDismiss: () => Get.back(),
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    } else {
      Get.snackbar(
        'Link seguro',
        'Este link parece ser legitimo.',
        backgroundColor: AppTheme.colors.success.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12.r),
        duration: const Duration(seconds: 2),
      );
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Color _avatarColor(String name) {
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
