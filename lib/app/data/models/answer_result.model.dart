class AnswerResultModel {
  final bool isCorrect;
  final String message;
  final int? aiRating;
  final String? feedback;
  final List<String>? strengths;
  final List<String>? improvements;
  final int points;

  AnswerResultModel({
    required this.isCorrect,
    required this.message,
    this.aiRating,
    this.feedback,
    this.strengths,
    this.improvements,
    this.points = 10,
  });

  factory AnswerResultModel.fromJson(Map<String, dynamic> json) {
    return AnswerResultModel(
      isCorrect: json['is_correct'] ?? false,
      message: json['message'] ?? '',
      aiRating: json['ai_rating'],
      feedback: json['feedback'],
      strengths: json['strengths'] != null ? List<String>.from(json['strengths']) : null,
      improvements: json['improvements'] != null ? List<String>.from(json['improvements']) : null,
      points: _calculatePoints(json['ai_rating']),
    );
  }

  static int _calculatePoints(int? aiRating) {
    if (aiRating == null) return 10;
    switch (aiRating) {
      case 5: return 20;
      case 4: return 15;
      case 3: return 12;
      default: return 10;
    }
  }
}
