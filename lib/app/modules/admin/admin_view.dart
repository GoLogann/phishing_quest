import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/difficulty_chip.dart';
import 'package:phishing_quest/app/global_ui/components/game_card.dart';
import 'package:phishing_quest/app/modules/admin/admin_controller.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());

    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Admin', style: AppTheme.textStyles.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Generate Questions
              FadeInDown(
                child: Text(
                  'Gerar Questões com IA',
                  style: AppTheme.textStyles.display.copyWith(fontSize: 22.sp),
                ),
              ),
              SizedBox(height: 4.h),
              FadeInDown(
                delay: const Duration(milliseconds: 50),
                child: Text(
                  'Use o PhishForge para gerar questões automaticamente',
                  style: AppTheme.textStyles.label.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Category Selection
              GameCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categoria',
                      style: AppTheme.textStyles.posLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: controller.categories.map((cat) {
                        return Obx(() {
                          final isSelected = controller.selectedCategory.value?.id == cat.id;
                          return GestureDetector(
                            onTap: () => controller.selectCategory(cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.colors.primary.withOpacity(0.2)
                                    : AppTheme.colors.surfaceBorder,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.colors.primary
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                cat.categoryName,
                                style: AppTheme.textStyles.label.copyWith(
                                  color: isSelected
                                      ? AppTheme.colors.primary
                                      : AppTheme.colors.textSecondary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // Difficulty
              GameCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dificuldade',
                      style: AppTheme.textStyles.posLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: Difficulty.values.map((d) {
                        return Obx(() => DifficultyChip(
                          difficulty: d,
                          isSelected: controller.selectedDifficulty.value == d,
                          onTap: () => controller.selectDifficulty(d),
                        ));
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // Quantity Slider
              GameCard(
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantidade',
                          style: AppTheme.textStyles.posLabel.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppTheme.colors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${controller.questionCount.value}',
                            style: AppTheme.textStyles.posLabel.copyWith(
                              color: AppTheme.colors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppTheme.colors.primary,
                        inactiveTrackColor: AppTheme.colors.surfaceBorder,
                        thumbColor: AppTheme.colors.primary,
                        overlayColor: AppTheme.colors.primary.withOpacity(0.2),
                      ),
                      child: Slider(
                        value: controller.questionCount.value.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (v) => controller.questionCount.value = v.toInt(),
                      ),
                    ),
                  ],
                )),
              ),
              SizedBox(height: 12.h),
              // Context / Extra Prompt
              GameCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contexto Adicional (opcional)',
                      style: AppTheme.textStyles.posLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: controller.contextController,
                      maxLines: 4,
                      style: AppTheme.textStyles.posLabel,
                      decoration: InputDecoration(
                        hintText: 'Ex: foco em ataques de CEO fraud...',
                        hintStyle: AppTheme.textStyles.label.copyWith(
                          color: AppTheme.colors.textMuted,
                        ),
                        filled: true,
                        fillColor: AppTheme.colors.backgroundDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Generate Button
              FadeInUp(
                child: Obx(() {
                  final canGenerate = controller.selectedCategory.value != null && !controller.isGenerating.value;
                  return GestureDetector(
                    onTap: canGenerate ? controller.generateQuestions : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: canGenerate
                            ? LinearGradient(colors: [
                                AppTheme.colors.accent,
                                AppTheme.colors.accent.withOpacity(0.8),
                              ])
                            : null,
                        color: canGenerate ? null : AppTheme.colors.surfaceBorder,
                        boxShadow: canGenerate
                            ? [
                                BoxShadow(
                                  color: AppTheme.colors.accent.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: controller.isGenerating.value
                            ? SizedBox(
                                height: 22.h,
                                width: 22.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.auto_awesome,
                                      color: canGenerate ? Colors.white : AppTheme.colors.textMuted,
                                      size: 22.sp),
                                  SizedBox(width: 8.w),
                                  Flexible(
                                    child: Text(
                                      'Gerar com PhishForge',
                                      style: AppTheme.textStyles.subTitle.copyWith(
                                        color: canGenerate ? Colors.white : AppTheme.colors.textMuted,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }
}
