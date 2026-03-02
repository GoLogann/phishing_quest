import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';
import 'package:phishing_quest/app/global_ui/app_theme.dart';
import 'package:phishing_quest/app/global_ui/components/game_card.dart';
import 'package:phishing_quest/app/global_ui/components/score_badge.dart';
import 'package:phishing_quest/app/modules/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundDark,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.auth.currentUser.value;
          final stats = controller.stats.value;

          return RefreshIndicator(
            color: AppTheme.colors.primary,
            backgroundColor: AppTheme.colors.backgroundCard,
            onRefresh: controller.loadStats,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  // Profile Header
                  FadeInDown(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppTheme.colors.backgroundCard,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppTheme.colors.primary.withOpacity(0.2),
                            child: Text(
                              (user?.username ?? 'U').substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 32.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            user?.username ?? 'Jogador',
                            style: AppTheme.textStyles.title.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user?.email ?? '',
                            style: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ScoreBadge(
                            score: user?.score ?? 0,
                            size: 80.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Quick Stats
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: Row(
                      children: [
                        _QuickStat(
                          icon: Icons.quiz_outlined,
                          value: '${stats?.totalAnswered ?? 0}',
                          label: 'Respondidas',
                          color: AppTheme.colors.primary,
                        ),
                        SizedBox(width: 10.w),
                        _QuickStat(
                          icon: Icons.check_circle_outline,
                          value: '${stats?.totalCorrect ?? 0}',
                          label: 'Acertos',
                          color: AppTheme.colors.success,
                        ),
                        SizedBox(width: 10.w),
                        _QuickStat(
                          icon: Icons.star_border,
                          value: (stats?.averageAiRating ?? 0).toStringAsFixed(1),
                          label: 'Nota IA',
                          color: AppTheme.colors.accent,
                        ),
                      ],
                    ),
                  ),
                  if (stats != null) ...[
                    SizedBox(height: 20.h),
                    // Bar Chart by Difficulty
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: _DifficultyChart(stats: stats),
                    ),
                    SizedBox(height: 16.h),
                    // Category Radar Chart
                    if (stats.byCategory.isNotEmpty)
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: _CategoryRadar(stats: stats),
                      ),
                    SizedBox(height: 16.h),
                    // Score History Line Chart
                    if (stats.scoreHistory.isNotEmpty)
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _ScoreHistoryChart(history: stats.scoreHistory),
                      ),
                  ],
                  SizedBox(height: 24.h),
                  // Logout
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: controller.logout,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppTheme.colors.error.withOpacity(0.1),
                          border: Border.all(color: AppTheme.colors.error.withOpacity(0.3)),
                        ),
                        child: Center(
                          child: Text(
                            'Sair da Conta',
                            style: AppTheme.textStyles.posLabel.copyWith(
                              color: AppTheme.colors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Quick Stat Card ──────────────────────────────────────────────────────────
class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _QuickStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GameCard(
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 8.h),
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
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Difficulty Bar Chart ─────────────────────────────────────────────────────
class _DifficultyChart extends StatelessWidget {
  final UserStatsModel stats;
  const _DifficultyChart({required this.stats});

  @override
  Widget build(BuildContext context) {
    final difficulties = stats.byDifficulty.entries.toList();

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Desempenho por Dificuldade',
            style: AppTheme.textStyles.subTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: difficulties.isEmpty
                    ? 10
                    : difficulties
                        .map((e) => e.value.total.toDouble())
                        .reduce((a, b) => a > b ? a : b) * 1.3,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final labels = ['Fácil', 'Médio', 'Difícil'];
                        if (value.toInt() < labels.length) {
                          return Text(
                            labels[value.toInt()],
                            style: AppTheme.textStyles.label.copyWith(
                              color: AppTheme.colors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                barGroups: difficulties.asMap().entries.map((entry) {
                  final d = entry.value.value;
                  final colors = [AppTheme.colors.success, AppTheme.colors.accent, AppTheme.colors.error];
                  final color = entry.key < colors.length ? colors[entry.key] : AppTheme.colors.primary;

                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: d.correct.toDouble(),
                        color: color,
                        width: 18.w,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
                      ),
                      BarChartRodData(
                        toY: (d.total - d.correct).toDouble(),
                        color: color.withOpacity(0.25),
                        width: 18.w,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category Radar ───────────────────────────────────────────────────────────
class _CategoryRadar extends StatelessWidget {
  final UserStatsModel stats;
  const _CategoryRadar({required this.stats});

  @override
  Widget build(BuildContext context) {
    final categories = stats.byCategory.entries.toList();

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Habilidades por Categoria',
            style: AppTheme.textStyles.subTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 220.h,
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: BorderSide(
                  color: AppTheme.colors.surfaceBorder,
                  width: 1,
                ),
                gridBorderData: BorderSide(
                  color: AppTheme.colors.surfaceBorder.withOpacity(0.5),
                  width: 0.5,
                ),
                tickCount: 4,
                tickBorderData: const BorderSide(color: Colors.transparent),
                ticksTextStyle: const TextStyle(color: Colors.transparent),
                getTitle: (index, angle) {
                  if (index < categories.length) {
                    return RadarChartTitle(
                      text: categories[index].key,
                      angle: 0,
                    );
                  }
                  return const RadarChartTitle(text: '');
                },
                dataSets: [
                  RadarDataSet(
                    dataEntries: categories
                        .map((e) => RadarEntry(
                              value: e.value.total > 0
                                  ? (e.value.correct / e.value.total * 100)
                                  : 0,
                            ))
                        .toList(),
                    fillColor: AppTheme.colors.primary.withOpacity(0.2),
                    borderColor: AppTheme.colors.primary,
                    borderWidth: 2,
                    entryRadius: 3,
                  ),
                ],
                titleTextStyle: AppTheme.textStyles.label.copyWith(
                  color: AppTheme.colors.textSecondary,
                  fontSize: 10.sp,
                ),
                titlePositionPercentageOffset: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Score History Line Chart ─────────────────────────────────────────────────
class _ScoreHistoryChart extends StatelessWidget {
  final List<ScoreHistoryEntry> history;
  const _ScoreHistoryChart({required this.history});

  @override
  Widget build(BuildContext context) {
    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evolução da Pontuação',
            style: AppTheme.textStyles.subTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppTheme.colors.surfaceBorder.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i >= 0 && i < history.length) {
                          return Text(
                            '${history[i].date.day}/${history[i].date.month}',
                            style: TextStyle(
                              color: AppTheme.colors.textMuted,
                              fontSize: 9.sp,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: history.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.score.toDouble());
                    }).toList(),
                    isCurved: true,
                    color: AppTheme.colors.primary,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: AppTheme.colors.primary,
                        strokeWidth: 1.5,
                        strokeColor: AppTheme.colors.backgroundCard,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.colors.primary.withOpacity(0.3),
                          AppTheme.colors.primary.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
