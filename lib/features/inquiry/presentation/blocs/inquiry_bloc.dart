import 'dart:io';

import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/inquiry/data/model/inquiry_card_model.dart';
import 'package:asood/features/inquiry/domain/inquiry_repository.dart';
import 'package:bloc/bloc.dart';

part 'inquiry_event.dart';
part 'inquiry_state.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {
  final InquiryRepo inquiryRepo;
  InquiryBloc(this.inquiryRepo) : super(InquiryState.initial()) {
    on<InquirySubmit>(_inquirySubmit);
    on<InquiryTypeSwitch>(_inquiryTypeSwitch);
    on<InquiryAddImage>(_inquiryAddImage);
    on<InquiryRemoveImage>(_inquiryRemoveImage);
  }

  _inquirySubmit(InquirySubmit event, Emitter<InquiryState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      var res = await inquiryRepo.submitInquiry(
        event.inquiryType,
        event.inquiryTitle,
        event.inquiryDescription,
        event.inquiryDetails,
        event.inquiryCategory,
        event.inquiryAmount,
        event.inquiryUnit,
        event.inquiryName,
        event.inquiryImages,
      );
      if (res is Success) {
        emit(state.copyWith(status: CWSStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _inquiryTypeSwitch(
    InquiryTypeSwitch event,
    Emitter<InquiryState> emit,
  ) async {
    emit(state.copyWith(inquiryType: event.inquiryType));
    print('inquiry type switch: ${state.inquiryType}');
  }

  _inquiryAddImage(InquiryAddImage event, Emitter<InquiryState> emit) async {
    final inquiryImages = List<File>.from(state.inquiryImages)
      ..add(event.image);

    emit(state.copyWith(inquiryImages: inquiryImages));
  }

  _inquiryRemoveImage(
    InquiryRemoveImage event,
    Emitter<InquiryState> emit,
  ) async {
    final inquiryImages = List<File>.from(state.inquiryImages)
      ..removeAt(event.index);

    emit(state.copyWith(inquiryImages: inquiryImages));
  }
}
