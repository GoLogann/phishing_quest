import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/answer.model.dart';
import 'package:phishing_quest/app/data/models/answer_result.model.dart';
import 'package:phishing_quest/app/data/models/phishing_email.model.dart';
import 'package:phishing_quest/app/data/models/question.model.dart';
import 'package:phishing_quest/app/data/repositories/game/game_repository.dart';
import 'package:phishing_quest/app/data/repositories/question/question_repository.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';

class GameFlowController extends GetxController {
  // Arguments
  late final String categoryId;
  late final String categoryName;
  late final Difficulty difficulty;

  // State
  final RxList<QuestionModel> questions = <QuestionModel>[].obs;
  final RxMap<String, List<AnswerModel>> answersMap = <String, List<AnswerModel>>{}.obs;
  final RxMap<String, PhishingEmailModel?> emailsMap = <String, PhishingEmailModel?>{}.obs;

  final RxInt currentIndex = 0.obs;
  final Rx<AnswerModel?> selectedAnswer = Rx<AnswerModel?>(null);
  final RxString justification = ''.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isLoading = true.obs;

  // Results
  final RxList<AnswerResultModel> results = <AnswerResultModel>[].obs;
  final RxInt totalScore = 0.obs;

  final justificationController = TextEditingController();

  QuestionModel get currentQuestion => questions[currentIndex.value];
  List<AnswerModel> get currentAnswers => answersMap[currentQuestion.id] ?? [];
  PhishingEmailModel? get currentEmail => emailsMap[currentQuestion.id];
  bool get isLastQuestion => currentIndex.value >= questions.length - 1;
  double get progress => questions.isEmpty ? 0.0 : (currentIndex.value + 1) / questions.length;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    categoryId = args['categoryId'] as String;
    categoryName = args['categoryName'] as String;
    difficulty = args['difficulty'] as Difficulty;
    loadQuestions();
  }

  @override
  void onClose() {
    justificationController.dispose();
    super.onClose();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    try {
      final questionRepo = QuestionRepository();
      questions.value = await questionRepo.getQuestionsByCategory(categoryId);

      // Filter by difficulty
      questions.value = questions.where((q) => q.difficulty == difficulty).toList();
      if (questions.isEmpty) {
        // Fallback: use all from category
        questions.value = await questionRepo.getQuestionsByCategory(categoryId);
      }

      // Limit to 5 questions per game round
      if (questions.length > 5) {
        questions.value = (questions.toList()..shuffle()).take(5).toList();
      }

      // Load answers and emails for each question
      for (final q in questions) {
        final answers = await questionRepo.getAnswersByQuestion(q.id);
        answersMap[q.id] = answers;

        if (q.phishingEmailId != null) {
          try {
            final email = await questionRepo.getPhishingEmail(q.phishingEmailId!);
            emailsMap[q.id] = email;
          } catch (_) {}
        }
      }
    } catch (e) {
      // Fallback to mock
      questions.value = MockData.questions
          .where((q) => q.categoryId == categoryId)
          .toList();
      if (questions.isEmpty) {
        questions.value = MockData.questions.take(5).toList();
      }
      for (final q in questions) {
        answersMap[q.id] = MockData.answersByQuestion[q.id] ?? [];
        final emailIdx = MockData.phishingEmails
            .indexWhere((e) => e.questionId == q.id);
        if (emailIdx >= 0) {
          emailsMap[q.id] = MockData.phishingEmails[emailIdx];
        }
      }
    }
    isLoading.value = false;
  }

  void selectAnswer(AnswerModel answer) {
    selectedAnswer.value = answer;
  }

  Future<void> submitAnswer() async {
    if (selectedAnswer.value == null) {
      Get.snackbar('Atenção', 'Selecione uma resposta',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;
    try {
      final auth = Get.find<AuthService>();
      final userId = auth.currentUser.value?.id ?? '';
      final gameRepo = GameRepository();
      final result = await gameRepo.submitAnswer(
        userId: userId,
        questionId: currentQuestion.id,
        answerId: selectedAnswer.value!.id,
        userJustification: justification.value.isNotEmpty ? justification.value : null,
      );
      results.add(result);
      totalScore.value += result.points;
    } catch (e) {
      // Mock result
      final isCorrect = selectedAnswer.value!.isCorrect;
      results.add(AnswerResultModel(
        isCorrect: isCorrect,
        message: isCorrect ? 'Correto!' : 'Errado!',
        aiRating: isCorrect ? 4 : 2,
        feedback: isCorrect
            ? 'Boa análise! Você identificou corretamente.'
            : 'Tente prestar mais atenção nos detalhes.',
        strengths: isCorrect ? ['Boa percepção', 'Análise correta'] : [],
        improvements: isCorrect ? [] : ['Analisar links', 'Verificar remetente'],
        points: isCorrect ? 15 : 5,
      ));
      totalScore.value += (isCorrect ? 15 : 5);
    }
    isSubmitting.value = false;

    if (isLastQuestion) {
      Get.toNamed('/game/result', arguments: {
        'results': results.toList(),
        'questions': questions.toList(),
        'totalScore': totalScore.value,
        'categoryName': categoryName,
        'difficulty': difficulty,
      });
    } else {
      nextQuestion();
    }
  }

  void nextQuestion() {
    selectedAnswer.value = null;
    justification.value = '';
    justificationController.clear();
    currentIndex.value++;
  }
}
