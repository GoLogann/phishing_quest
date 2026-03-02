class UserStatsModel {
  final int totalAnswered;
  final int totalCorrect;
  final Map<String, DifficultyStats> byDifficulty;
  final double averageAiRating;
  final List<ScoreHistoryEntry> scoreHistory;
  final Map<String, CategoryStats> byCategory;

  UserStatsModel({
    required this.totalAnswered,
    required this.totalCorrect,
    required this.byDifficulty,
    required this.averageAiRating,
    required this.scoreHistory,
    required this.byCategory,
  });

  double get accuracy => totalAnswered > 0 ? (totalCorrect / totalAnswered) * 100 : 0;
}

class DifficultyStats {
  final int answered;
  final int correct;

  DifficultyStats({required this.answered, required this.correct});

  int get total => answered;
  double get accuracy => answered > 0 ? (correct / answered) * 100 : 0;
}

class CategoryStats {
  final String categoryName;
  final int answered;
  final int correct;

  CategoryStats({required this.categoryName, required this.answered, required this.correct});

  int get total => answered;
  double get accuracy => answered > 0 ? (correct / answered) * 100 : 0;
}

class ScoreHistoryEntry {
  final DateTime date;
  final int score;

  ScoreHistoryEntry({required this.date, required this.score});
}
