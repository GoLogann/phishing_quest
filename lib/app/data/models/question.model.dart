import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';

class QuestionModel {
  final String id;
  final String questionText;
  final String categoryId;
  final Difficulty difficulty;
  final String? phishingEmailId;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.categoryId,
    required this.difficulty,
    this.phishingEmailId,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      questionText: json['questionText'] ?? json['question_text'] ?? '',
      categoryId: json['categoryId'] ?? json['category_id'] ?? '',
      difficulty: Difficulty.fromString(json['difficulty'] ?? 'medium'),
      phishingEmailId: json['phishing_email_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionText': questionText,
    'categoryId': categoryId,
    'difficulty': difficulty.name,
    'phishing_email_id': phishingEmailId,
  };
}
