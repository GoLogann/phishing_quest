class RankingEntryModel {
  final String userId;
  final String username;
  final int score;
  final int position;
  final String? avatarUrl;
  final int totalAnswered;
  final int totalCorrect;

  RankingEntryModel({
    required this.userId,
    required this.username,
    required this.score,
    required this.position,
    this.avatarUrl,
    this.totalAnswered = 0,
    this.totalCorrect = 0,
  });

  double get accuracy => totalAnswered > 0 ? (totalCorrect / totalAnswered) * 100 : 0;

  factory RankingEntryModel.fromJson(Map<String, dynamic> json) {
    return RankingEntryModel(
      userId: json['user_id'] ?? json['userId'] ?? '',
      username: json['username'] ?? '',
      score: json['score'] ?? 0,
      position: json['position'] ?? 0,
      avatarUrl: json['avatar_url'],
      totalAnswered: json['total_answered'] ?? 0,
      totalCorrect: json['total_correct'] ?? 0,
    );
  }
}
