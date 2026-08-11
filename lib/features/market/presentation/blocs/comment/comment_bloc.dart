import 'package:asood/core/models/comment_model.dart';
import 'package:bloc/bloc.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentState.initial()) {
    on<CommentEvent>((event, emit) {});

    // on<AddTemplateEvent>(_addTemplate);
    // on<RemoveTemplateEvent>(_removeTemplate);
    // on<ShowTemplatesEvent>(_showTemplates);
  }

  // _getComments(LoadComments event, Emitter<CommentBloc> emit) async {
  //   emit(state.copyWith(status: CommentsStatus.loading));
  //   try {
  //     final res = await marketRepository.getMarketSliders(event.marketId);
  //     if (res is Success) {
  //       final json = jsonDecode(res.response.toString());
  //       final initList = json['data'] as List;
  //       final sliderList =
  //       initList.map((e) => SliderModel.fromJson(e)).toList();
  //       emit(state.copyWith(status: VendorStatus.success, sliderList: sliderList));
  //     } else {
  //       emit(state.copyWith(status: VendorStatus.failure));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(status: VendorStatus.failure));
  //   }
  //   emit(state.copyWith(status: VendorStatus.initial));
  // }
}
