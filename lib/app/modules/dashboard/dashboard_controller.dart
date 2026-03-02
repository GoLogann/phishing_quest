import 'package:get/get.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/category.model.dart';
import 'package:phishing_quest/app/data/models/user_stats.model.dart';
import 'package:phishing_quest/app/data/repositories/category/category_repository.dart';
import 'package:phishing_quest/app/data/repositories/ranking/ranking_repository.dart';
import 'package:phishing_quest/app/data/services/auth_service.dart';

class DashboardController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<UserStatsModel?> stats = Rx<UserStatsModel?>(null);
  final RxBool isLoading = true.obs;
  final RxInt userRank = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      final categoryRepo = CategoryRepository();
      final rankingRepo = RankingRepository();

      categories.value = await categoryRepo.getCategories();
      stats.value = await rankingRepo.getUserStats(
        authService.currentUser.value?.id ?? '',
      );
      userRank.value = await rankingRepo.getUserRank(
        authService.currentUser.value?.id ?? '',
      );
    } catch (_) {
      categories.value = MockData.categories;
      stats.value = MockData.userStats;
    }
    isLoading.value = false;
  }
}
