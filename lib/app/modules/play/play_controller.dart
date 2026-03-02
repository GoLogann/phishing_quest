import 'package:get/get.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/category.model.dart';
import 'package:phishing_quest/app/data/repositories/category/category_repository.dart';

enum GameMode { quiz, emailSim }

class PlayController extends GetxController {
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  final Rx<Difficulty> selectedDifficulty = Difficulty.medium.obs;
  final Rx<GameMode?> selectedMode = Rx<GameMode?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    try {
      final repo = CategoryRepository();
      categories.value = await repo.getCategories();
    } catch (_) {
      categories.value = MockData.categories;
    }
    isLoading.value = false;
  }

  void selectMode(GameMode mode) {
    selectedMode.value = mode;
    // Reset category selection when changing modes
    selectedCategory.value = null;
  }

  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  void selectDifficulty(Difficulty difficulty) {
    selectedDifficulty.value = difficulty;
  }

  void startGame() {
    if (selectedMode.value == GameMode.emailSim) {
      startEmailSim();
    } else if (selectedCategory.value != null) {
      Get.toNamed(
        '/game',
        arguments: {
          'categoryId': selectedCategory.value!.id,
          'categoryName': selectedCategory.value!.categoryName,
          'difficulty': selectedDifficulty.value,
        },
      );
    }
  }

  void startEmailSim() {
    Get.toNamed('/email-sim');
  }
}
