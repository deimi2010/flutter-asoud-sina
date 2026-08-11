import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/job_managment/data/model/category_model.dart';
import 'package:asood/features/job_managment/domain/repository/category_repository.dart';
import 'package:bloc/bloc.dart';

part 'jobmanagment_event.dart';
part 'jobmanagment_state.dart';

class JobmanagmentBloc extends Bloc<JobmanagmentEvent, JobmanagmentState> {
  CategoryRepository categoryRepository;
  JobmanagmentBloc(this.categoryRepository)
    : super(JobmanagmentState.initial()) {
    on<ResetJobManagmentBloc>((event, emit) {
      emit(JobmanagmentState.initial());
    });
    on<ChangeTabView>((event, emit) {
      emit(state.copyWith(activeTabIndex: event.activeTabIndex));
    });
    //category
    on<ChangeCategoryIndex>((event, emit) {
      emit(state.copyWith(activeCategoryId: event.activeCategoryId));
    });
    on<ChangeSelectedCategoryName>((event, emit) {
      emit(state.copyWith(selectedCategoryName: event.selectedCat));
    });
    on<LoadCategory>(_getCategory);
    on<LoadMainSubCategory>(_getMainSubCategory);
    on<ChangeSubCategoryIndex>((event, emit) {
      emit(
        state.copyWith(activeSubCategoryIndex: event.activeSubCategoryIndex),
      );
    });
    on<LoadSubCategory>(_getSubCategory);
  }
  //list of category
  _getCategory(LoadCategory event, Emitter<JobmanagmentState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading, activeTabIndex: 0));
    try {
      final res = await categoryRepository.getCategoryList();

      if (res is Success) {
        final initList = res.response as List;
        final categoryList =
            initList.map((e) => CategoryModel.fromJson(e)).toList();
        emit(
          state.copyWith(status: CWSStatus.success, categoryList: categoryList),
        );
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  //list of main sub category
  _getMainSubCategory(
    LoadMainSubCategory event,
    Emitter<JobmanagmentState> emit,
  ) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await categoryRepository.getMainSubCategoryList(
        event.categoryId,
      );
      if (res is Success) {
        final dataList = res.response as List<dynamic>;

        final mainSubCategory =
            dataList
                .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
                .toList();
        emit(
          state.copyWith(
            status: CWSStatus.success,
            mainSubCategoryList: mainSubCategory,
          ),
        );
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  //list of sub category
  _getSubCategory(
    LoadSubCategory event,
    Emitter<JobmanagmentState> emit,
  ) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await categoryRepository.getSubCategoryList(
        event.subCategoryId,
      );
      if (res is Success) {
        final dataList = res.response as List<dynamic>;

        final subCategory =
            dataList
                .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
                .toList();

        emit(
          state.copyWith(
            status: CWSStatus.success,
            subCategoryList: subCategory,
          ),
        );
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }
}
