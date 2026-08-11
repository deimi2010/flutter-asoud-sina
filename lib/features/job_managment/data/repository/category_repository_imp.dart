import 'package:asood/features/job_managment/data/data_source/category_api_service.dart';

import 'package:asood/features/job_managment/domain/repository/category_repository.dart';

class CategoryRepositoryImp implements CategoryRepository {
  final CategoryApiService categoryApiService;
  CategoryRepositoryImp(this.categoryApiService);

  @override
  Future getCategoryList() async {
    return await categoryApiService.getCategoryList();
  }

  @override
  Future getMainSubCategoryList(String categoryId) async {
    return await categoryApiService.getMainSubCategoryList(categoryId);
  }

  @override
  Future getSubCategoryList(String subCategoryId) async {
    return await categoryApiService.getSubCategoryList(subCategoryId);
  }
}
