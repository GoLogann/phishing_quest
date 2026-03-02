import 'package:get/get.dart' hide Response;
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/answer.model.dart';
import 'package:phishing_quest/app/data/models/phishing_email.model.dart';
import 'package:phishing_quest/app/data/models/question.model.dart';
import 'package:phishing_quest/app/data/providers/pq_api_client/pq_api_client.provider.dart';
import 'package:phishing_quest/app/data/repositories/question/question_repository.interface.dart';
import 'package:phishing_quest/app/data/util/api/api_helpers.dart';

class QuestionRepository implements IQuestionRepository {
  final ApiHelpers _apiHelpers = ApiHelpers();
  final PqApiClient _client = Get.find<PqApiClient>();

  @override
  Future<List<QuestionModel>> getQuestionsByCategory(String categoryId) async {
    try {
      final url = _apiHelpers.buildUrl(url: '/categories/$categoryId/questions');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final List data = response.data is List ? response.data : [];
        return data.map((e) => QuestionModel.fromJson(e)).toList();
      }
    } catch (_) {}

    // Fallback to mock
    return MockData.questions.where((q) => q.categoryId == categoryId).toList();
  }

  @override
  Future<List<AnswerModel>> getAnswersByQuestion(String questionId) async {
    try {
      final url = _apiHelpers.buildUrl(url: '/questions/$questionId/answers');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final List data = response.data is List ? response.data : [];
        return data.map((e) => AnswerModel.fromJson(e)).toList();
      }
    } catch (_) {}

    // Fallback to mock
    return MockData.answersByQuestion[questionId] ?? [];
  }

  @override
  Future<PhishingEmailModel?> getPhishingEmail(String questionId) async {
    // Try to find from mock
    return MockData.phishingEmails.firstWhereOrNull((pe) => pe.questionId == questionId);
  }
}
