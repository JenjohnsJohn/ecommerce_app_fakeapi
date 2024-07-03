class CategoryModel {
  final String title;

  CategoryModel({required this.title});

  factory CategoryModel.fromJson(String title) {
    return CategoryModel(title: title);
  }
}
