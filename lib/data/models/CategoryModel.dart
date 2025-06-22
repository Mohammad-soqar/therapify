class CategoryModel {
  final String categoryId;
  final String categoryName;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'categoryName': categoryName,
  };
}
