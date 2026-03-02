import 'package:get/get.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/ranking_entry.model.dart';
import 'package:phishing_quest/app/data/repositories/ranking/ranking_repository.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';

class RankingController extends GetxController {
  final RxList<RankingEntryModel> ranking = <RankingEntryModel>[].obs;
  final Rx<RankingEntryModel?> myRank = Rx<RankingEntryModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRanking();
  }

  Future<void> loadRanking() async {
    isLoading.value = true;
    try {
      final repo = RankingRepository();
      ranking.value = await repo.getGlobalRanking();

      final auth = Get.find<AuthService>();
      final userId = auth.currentUser.value?.id ?? '';
      myRank.value = ranking.firstWhereOrNull((e) => e.userId == userId);
    } catch (_) {
      ranking.value = MockData.ranking;
    }
    isLoading.value = false;
  }
}
