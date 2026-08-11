abstract class CategoryRepository {
  Future<dynamic> getCategoryList() async {}

  Future<dynamic> getMainSubCategoryList(String categoryId) async {}

  Future<dynamic> getSubCategoryList(String subCategoryId) async {}
}
