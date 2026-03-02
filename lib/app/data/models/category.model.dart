class CategoryModel {
  final String id;
  final String categoryName;
  final String? description;
  final String? icon;
  final int questionCount;

  CategoryModel({
    required this.id,
    required this.categoryName,
    this.description,
    this.icon,
    this.questionCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      categoryName: json['categoryName'] ?? json['category_name'] ?? '',
      description: json['description'],
      icon: json['icon'],
      questionCount: json['question_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'description': description,
    'icon': icon,
    'question_count': questionCount,
  };
}
