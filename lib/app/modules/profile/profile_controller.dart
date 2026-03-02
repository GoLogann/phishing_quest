import 'package:get/get.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';
import 'package:phishing_quest/app/data/repositories/ranking/ranking_repository.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';

class ProfileController extends GetxController {
  final Rx<UserStatsModel?> stats = Rx<UserStatsModel?>(null);
  final RxBool isLoading = true.obs;

  AuthService get auth => Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  Future<void> loadStats() async {
    isLoading.value = true;
    try {
      final repo = RankingRepository();
      final userId = auth.currentUser.value?.id ?? '';
      stats.value = await repo.getUserStats(userId);
    } catch (_) {
      stats.value = MockData.userStats;
    }
    isLoading.value = false;
  }

  void logout() {
    auth.logout();
    Get.offAllNamed('/flow-initial');
  }
}
