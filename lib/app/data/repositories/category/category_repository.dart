import 'package:get/get.dart' hide Response;
import 'package:phishing_quest/app/data/mock/mock_data.dart';
import 'package:phishing_quest/app/data/models/category.model.dart';
import 'package:phishing_quest/app/data/providers/pq_api_client/pq_api_client.provider.dart';
import 'package:phishing_quest/app/data/repositories/category/category_repository.interface.dart';
import 'package:phishing_quest/app/data/util/api/api_helpers.dart';

class CategoryRepository implements ICategoryRepository {
  final ApiHelpers _apiHelpers = ApiHelpers();
  final PqApiClient _client = Get.find<PqApiClient>();

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final url = _apiHelpers.buildUrl(url: '/categories');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final List data = response.data is List ? response.data : [];
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      }
    } catch (_) {}

    // Fallback to mock
    return MockData.categories;
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    final categories = await getCategories();
    return categories.firstWhereOrNull((c) => c.id == id);
  }
}
