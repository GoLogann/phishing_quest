import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/email_preview_card.dart';
import 'package:phishing_quest/app/global_ui/components/progress_bar.dart';
import 'package:phishing_quest/app/modules/game/game_flow_controller.dart';

class GameFlowView extends GetView<GameFlowController> {
  const GameFlowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => _showExitDialog(context),
        ),
        title: Obx(() => Text(
          'Pergunta ${controller.currentIndex.value + 1}/${controller.questions.length}',
          style: AppTheme.textStyles.posLabel.copyWith(color: AppTheme.colors.textSecondary),
        )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text(
                  'Carregando questões...',
                  style: AppTheme.textStyles.posLabel.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.questions.isEmpty) {
          return Center(
            child: Text(
              'Nenhuma questão encontrada.',
              style: AppTheme.textStyles.posLabel,
            ),
          );
        }

        return Column(
          children: [
            // Progress Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() => GameProgressBar(
                progress: controller.progress,
                label: '${controller.categoryName} • ${controller.difficulty.label}',
              )),
            ),
            SizedBox(height: 8.h),
            // Question Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Preview if available
                    Obx(() {
                      final email = controller.currentEmail;
                      if (email != null) {
                        return FadeIn(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: EmailPreviewCard(
                              remetente: email.remetente,
                              receptor: email.receptor,
                              assunto: email.assunto,
                              conteudo: email.conteudo,
                              links: email.links,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    // Question Text
                    FadeInUp(
                      child: Obx(() => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppTheme.colors.backgroundCard,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppTheme.colors.surfaceBorder,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          controller.currentQuestion.questionText,
                          style: AppTheme.textStyles.subTitle.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      )),
                    ),
                    SizedBox(height: 16.h),
                    // Answer Options
                    Obx(() => Column(
                      children: controller.currentAnswers.asMap().entries.map((entry) {
                        final answer = entry.value;
                        final index = entry.key;
                        final letters = ['A', 'B', 'C', 'D'];
                        final letter = index < letters.length ? letters[index] : '${index + 1}';

                        return Obx(() {
                          final isSelected = controller.selectedAnswer.value?.id == answer.id;
                          return FadeInRight(
                            delay: Duration(milliseconds: index * 80),
                            child: GestureDetector(
                              onTap: () => controller.selectAnswer(answer),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.all(14.r),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.colors.primary.withOpacity(0.15)
                                      : AppTheme.colors.backgroundCard,
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.colors.primary
                                        : AppTheme.colors.surfaceBorder,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36.r,
                                      height: 36.r,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppTheme.colors.primary
                                            : AppTheme.colors.surfaceBorder,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        letter,
                                        style: AppTheme.textStyles.posLabel.copyWith(
                                          color: isSelected ? Colors.white : AppTheme.colors.textSecondary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        answer.answerText,
                                        style: AppTheme.textStyles.posLabel.copyWith(
                                          color: isSelected ? AppTheme.colors.textPrimary : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    )),
                    SizedBox(height: 12.h),
                    // Justification Field
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.colors.backgroundCard,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: AppTheme.colors.surfaceBorder),
                        ),
                        child: TextField(
                          controller: controller.justificationController,
                          onChanged: (v) => controller.justification.value = v,
                          maxLines: 3,
                          style: AppTheme.textStyles.posLabel,
                          decoration: InputDecoration(
                            hintText: 'Justifique sua resposta (opcional)...',
                            hintStyle: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.textMuted,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(14.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            // Submit Button
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppTheme.colors.backgroundCard,
                border: Border(top: BorderSide(color: AppTheme.colors.surfaceBorder)),
              ),
              child: SafeArea(
                top: false,
                child: Obx(() {
                  final hasSelection = controller.selectedAnswer.value != null;
                  final isSubmitting = controller.isSubmitting.value;

                  return GestureDetector(
                    onTap: (hasSelection && !isSubmitting) ? controller.submitAnswer : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: hasSelection
                            ? LinearGradient(colors: [
                                AppTheme.colors.primary,
                                AppTheme.colors.primary.withOpacity(0.8),
                              ])
                            : null,
                        color: hasSelection ? null : AppTheme.colors.surfaceBorder,
                      ),
                      child: Center(
                        child: isSubmitting
                            ? SizedBox(
                                height: 22.h,
                                width: 22.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                controller.isLastQuestion ? 'Finalizar' : 'Confirmar',
                                style: AppTheme.textStyles.subTitle.copyWith(
                                  color: hasSelection ? Colors.white : AppTheme.colors.textMuted,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.colors.backgroundCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Sair da partida?', style: AppTheme.textStyles.subTitle),
        content: Text(
          'Seu progresso será perdido.',
          style: AppTheme.textStyles.posLabel.copyWith(
            color: AppTheme.colors.textSecondary,
          ),
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
