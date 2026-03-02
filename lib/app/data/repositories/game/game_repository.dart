import 'package:get/get.dart' hide Response;
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/answer.model.dart';
import 'package:phishing_quest/app/data/models/answer_result.model.dart';
import 'package:phishing_quest/app/data/providers/pq_api_client/pq_api_client.provider.dart';
import 'package:phishing_quest/app/data/repositories/game/game_repository.interface.dart';
import 'package:phishing_quest/app/data/util/api/api_helpers.dart';

class GameRepository implements IGameRepository {
  final ApiHelpers _apiHelpers = ApiHelpers();
  final PqApiClient _client = Get.find<PqApiClient>();

  @override
  Future<AnswerResultModel> submitAnswer({
    required String userId,
    required String questionId,
    required String answerId,
    String? userJustification,
  }) async {
    try {
      final url = _apiHelpers.buildUrl(url: '/game/answer');
      final body = {
        'user_id': userId,
        'question_id': questionId,
        'answer_id': answerId,
        if (userJustification != null && userJustification.isNotEmpty)
          'user_justification': userJustification,
      };

      final response = await _client.post(url, body);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return AnswerResultModel.fromJson(response.data);
      }
    } catch (_) {}

    // Fallback to mock — check if answer is correct
    final answers = MockData.answersByQuestion[questionId] ?? [];
    final selectedAnswer = answers.firstWhereOrNull((a) => a.id == answerId);
    final isCorrect = selectedAnswer?.isCorrect ?? false;

    if (isCorrect && userJustification != null && userJustification.isNotEmpty) {
      return MockData.mockCorrectWithAI();
    } else if (isCorrect) {
      return AnswerResultModel(
        isCorrect: true,
        message: 'Resposta correta! Bom trabalho.',
        points: 10,
      );
    } else {
      return MockData.mockIncorrect();
    }
  }
}
