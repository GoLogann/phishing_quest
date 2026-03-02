import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phishing_quest/app/data/enumerators/difficulty.enum.dart';
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/category.model.dart';
import 'package:phishing_quest/app/data/repositories/category/category_repository.dart';

class AdminController extends GetxController {
  // Generate questions form
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  final Rx<Difficulty> selectedDifficulty = Difficulty.medium.obs;
  final RxInt questionCount = 3.obs;
  final TextEditingController contextController = TextEditingController();
  final RxBool isGenerating = false.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  @override
  void onClose() {
    contextController.dispose();
    super.onClose();
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

  void selectCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  void selectDifficulty(Difficulty d) {
    selectedDifficulty.value = d;
  }

  Future<void> generateQuestions() async {
    if (selectedCategory.value == null) return;
    isGenerating.value = true;

    // TODO: POST to /admin/generate endpoint
    await Future.delayed(const Duration(seconds: 2));

    isGenerating.value = false;
    Get.snackbar(
      'Sucesso',
      '${questionCount.value} questões geradas com IA (mock)',
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12.r),
    );
  }
}
