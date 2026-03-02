import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/inbox_email_tile.dart';
import 'package:phishing_quest/app/modules/email_sim/email_sim_controller.dart';

class EmailInboxView extends GetView<EmailSimController> {
  const EmailInboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.backgroundCard,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => _showExitDialog(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mail_rounded, color: AppTheme.colors.primary, size: 22.sp),
            SizedBox(width: 8.w),
            Text('Caixa de Entrada', style: AppTheme.textStyles.subTitle),
          ],
        ),
        centerTitle: true,
        actions: [
          Obx(() => Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppTheme.colors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${controller.evaluatedCount}/${controller.inboxEmails.length}',
                  style: AppTheme.textStyles.label.copyWith(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Search bar (cosmetic)
            FadeInDown(
              child: Container(
                margin: EdgeInsets.all(12.r),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppTheme.colors.backgroundCard,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppTheme.colors.surfaceBorder.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppTheme.colors.textMuted, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      'Pesquisar emails...',
                      style: AppTheme.textStyles.label.copyWith(color: AppTheme.colors.textMuted),
                    ),
                  ],
                ),
              ),
            ),
            // Progress
            Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '${controller.inboxEmails.length} emails',
                    style: AppTheme.textStyles.prepreLabel.copyWith(
                      color: AppTheme.colors.textMuted,
                    ),
                  ),
                  const Spacer(),
                  if (controller.evaluatedCount > 0)
                    Text(
                      '${controller.evaluatedCount} avaliados',
                      style: AppTheme.textStyles.prepreLabel.copyWith(
                        color: AppTheme.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            )),
            SizedBox(height: 4.h),
            // Email list
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.inboxEmails.length,
                itemBuilder: (context, index) {
                  final email = controller.inboxEmails[index];
                  final isEvaluated = controller.isEmailEvaluated(email.id);
                  final wasCorrect = controller.wasCorrect(email.id);

                  return FadeInLeft(
                    delay: Duration(milliseconds: index * 60),
                    child: InboxEmailTile(
                      avatarInitial: email.avatarInitial,
                      senderName: email.remetenteNome,
                      subject: email.assunto,
                      preview: email.preview,
                      time: _formatTime(email.receivedAt),
                      hasAttachment: email.hasAttachment,
                      isEvaluated: isEvaluated,
                      wasCorrect: wasCorrect,
                      onTap: () => Get.toNamed('/email-sim/detail', arguments: {'emailIndex': index}),
                    ),
                  );
                },
              )),
            ),
            // Finish button
            Obx(() {
              if (controller.evaluatedCount == 0) return const SizedBox.shrink();

              return FadeInUp(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.backgroundCard,
                    border: Border(
                      top: BorderSide(color: AppTheme.colors.surfaceBorder.withOpacity(0.3)),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: GestureDetector(
                      onTap: controller.allEvaluated ? controller.finishSimulation : null,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: controller.allEvaluated
                              ? LinearGradient(colors: [
                                  AppTheme.colors.accent,
                                  AppTheme.colors.accent.withOpacity(0.8),
                                ])
                              : null,
                          color: controller.allEvaluated ? null : AppTheme.colors.surfaceBorder,
                        ),
                        child: Center(
                          child: Text(
                            controller.allEvaluated
                                ? 'Finalizar Simulacao'
                                : 'Avalie todos os emails para finalizar',
                            style: AppTheme.textStyles.posLabel.copyWith(
                              color: controller.allEvaluated
                                  ? Colors.white
                                  : AppTheme.colors.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      }),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 60) return '${diff.inMinutes}min';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Ontem';
    return '${dt.day}/${dt.month}';
  }

  void _showExitDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.colors.backgroundCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Sair da simulacao?', style: AppTheme.textStyles.subTitle),
        content: Text(
          'Seu progresso sera perdido.',
          style: AppTheme.textStyles.posLabel.copyWith(color: AppTheme.colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancelar', style: TextStyle(color: AppTheme.colors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text('Sair', style: TextStyle(color: AppTheme.colors.error)),
          ),
        ],
      ),
    );
  }
}
