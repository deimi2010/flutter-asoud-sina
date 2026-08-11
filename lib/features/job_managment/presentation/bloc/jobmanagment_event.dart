part of 'jobmanagment_bloc.dart';

sealed class JobmanagmentEvent {}

//change tabview
class ChangeTabView extends JobmanagmentEvent {
  final int activeTabIndex;
  ChangeTabView({required this.activeTabIndex});
}

class LoadCategory extends JobmanagmentEvent {}

//category
class ChangeCategoryIndex extends JobmanagmentEvent {
  final String activeCategoryId;
  ChangeCategoryIndex({required this.activeCategoryId});
}

class ResetJobManagmentBloc extends JobmanagmentEvent {}

class LoadMainSubCategory extends JobmanagmentEvent {
  final String categoryId;
  LoadMainSubCategory({required this.categoryId});
}

class ChangeSubCategoryIndex extends JobmanagmentEvent {
  final String activeSubCategoryIndex;
  ChangeSubCategoryIndex({required this.activeSubCategoryIndex});
}

class LoadSubCategory extends JobmanagmentEvent {
  final String subCategoryId;
  LoadSubCategory({required this.subCategoryId});
}

class ChangeSelectedCategoryName extends JobmanagmentEvent {
  final String selectedCat;
  ChangeSelectedCategoryName({required this.selectedCat});
}
