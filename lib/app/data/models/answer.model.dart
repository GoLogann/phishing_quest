class AnswerModel {
  final String id;
  final String questionId;
  final String answerText;
  final bool isCorrect;

  AnswerModel({
    required this.id,
    required this.questionId,
    required this.answerText,
    required this.isCorrect,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] ?? '',
      questionId: json['questionId'] ?? json['question_id'] ?? '',
      answerText: json['answerText'] ?? json['answer_text'] ?? '',
      isCorrect: json['isCorrect'] ?? json['is_correct'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionId': questionId,
    'answerText': answerText,
    'isCorrect': isCorrect,
  };
}
