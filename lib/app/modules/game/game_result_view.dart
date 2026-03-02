import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/data/models/answer_result.model.dart';
import 'package:phishing_quest/app/data/models/question.model.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/feedback_panel.dart';
import 'package:phishing_quest/app/global_ui/components/rating_stars.dart';
import 'package:phishing_quest/app/global_ui/components/score_badge.dart';

class GameResultView extends StatelessWidget {
  const GameResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final results = args['results'] as List<AnswerResultModel>;
    final questions = args['questions'] as List<QuestionModel>;
    final totalScore = args['totalScore'] as int;
    final categoryName = args['categoryName'] as String;
    final difficulty = args['difficulty'] as Difficulty;

    final correctCount = results.where((r) => r.isCorrect).length;
    final accuracy = results.isEmpty ? 0.0 : correctCount / results.length;
    final avgRating = results.isEmpty
        ? 0.0
        : results.map((r) => r.aiRating ?? 0).reduce((a, b) => a + b) / results.length;

    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              // Header
              FadeInDown(
                child: Text(
                  'Resultado',
                  style: AppTheme.textStyles.display,
                ),
              ),
              SizedBox(height: 4.h),
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  '$categoryName • ${difficulty.label}',
                  style: AppTheme.textStyles.posLabel.copyWith(
                    color: AppTheme.colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // Score Badge
              ZoomIn(
                delay: const Duration(milliseconds: 200),
                child: ScoreBadge(score: totalScore, size: 130.r),
              ),
              SizedBox(height: 24.h),
              // Stats Row
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _StatItem(
                        icon: Icons.check_circle_outline,
                        color: AppTheme.colors.success,
                        value: '$correctCount/${results.length}',
                        label: 'Acertos',
                      ),
                    ),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.percent,
                        color: AppTheme.colors.primary,
                        value: '${(accuracy * 100).toInt()}%',
                        label: 'Precisão',
                      ),
                    ),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.star_border,
                        color: AppTheme.colors.accent,
                        value: avgRating.toStringAsFixed(1),
                        label: 'Nota IA',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              // Donut Chart
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.backgroundCard,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      Text('Desempenho', style: AppTheme.textStyles.subTitle),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 150.h,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 40.r,
                            sections: [
                              PieChartSectionData(
                                value: correctCount.toDouble(),
                                color: AppTheme.colors.success,
                                title: '$correctCount',
                                titleStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                radius: 35.r,
                              ),
                              PieChartSectionData(
                                value: (results.length - correctCount).toDouble(),
                                color: AppTheme.colors.error,
                                title: '${results.length - correctCount}',
                                titleStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                radius: 35.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LegendDot(color: AppTheme.colors.success, label: 'Corretas'),
                          SizedBox(width: 24.w),
                          _LegendDot(color: AppTheme.colors.error, label: 'Erradas'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Per-question breakdown
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalhes por Questão',
                      style: AppTheme.textStyles.subTitle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ...List.generate(results.length, (i) {
                      final result = results[i];
                      final question = i < questions.length ? questions[i] : null;

                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: AppTheme.colors.backgroundCard,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: result.isCorrect
                                ? AppTheme.colors.success.withOpacity(0.3)
                                : AppTheme.colors.error.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  result.isCorrect ? Icons.check_circle : Icons.cancel,
                                  color: result.isCorrect ? AppTheme.colors.success : AppTheme.colors.error,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    'Questão ${i + 1}',
                                    style: AppTheme.textStyles.posLabel.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  '+${result.points} pts',
                                  style: AppTheme.textStyles.label.copyWith(
                                    color: AppTheme.colors.accent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            if (question != null) ...[
                              SizedBox(height: 6.h),
                              Text(
                                question.questionText,
                                style: AppTheme.textStyles.label.copyWith(
                                  color: AppTheme.colors.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            SizedBox(height: 8.h),
                            RatingStars(rating: result.aiRating ?? 0, starSize: 16.sp),
                            SizedBox(height: 8.h),
                            FeedbackPanel(
                              aiRating: result.aiRating,
                              feedback: result.feedback,
                              strengths: result.strengths,
                              improvements: result.improvements,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Action Buttons
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed('/main'),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppTheme.colors.backgroundCard,
                            border: Border.all(color: AppTheme.colors.surfaceBorder),
                          ),
                          child: Center(
                            child: Text(
                              'Início',
                              style: AppTheme.textStyles.posLabel.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.colors.primary,
                                AppTheme.colors.primary.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Jogar Novamente',
                              style: AppTheme.textStyles.posLabel.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widgets
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: AppTheme.textStyles.title.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTheme.textStyles.label.copyWith(
            color: AppTheme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(label, style: AppTheme.textStyles.label.copyWith(color: AppTheme.colors.textSecondary)),
      ],
    );
  }
}
