import 'dart:ui';

import 'package:bloc/bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    // on<ThemeEvent>((event, emit) {});
    on<SelectTopColor>(_selectTopColor);
    on<SelectSecondColor>(_selectSecondColor);
    on<SelectBackColor>(_selectBackColor);

    on<SelectFontColor>(_selectFontColor);
    on<SelectSecondFontColor>(_selectSecondFontColor);
    on<SelectFontFamily>(_selectFontFamily);
  }

  //-------------- color -----------------
  _selectTopColor(SelectTopColor event, Emitter<ThemeState> emit) {
    emit(state.copyWith(topColor: event.topColor));
  }

  _selectSecondColor(SelectSecondColor event, Emitter<ThemeState> emit) {
    emit(state.copyWith(secondColor: event.secondColor));
  }

  _selectBackColor(SelectBackColor event, Emitter<ThemeState> emit) {
    emit(state.copyWith(backColor: event.backColor));
  }

  //--------------- font -----------------
  _selectFontColor(SelectFontColor event, Emitter<ThemeState> emit) {
    emit(state.copyWith(fontColor: event.fontColor));
  }

  _selectSecondFontColor(
    SelectSecondFontColor event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(secondFontColor: event.secondFontColor));
  }

  _selectFontFamily(SelectFontFamily event, Emitter<ThemeState> emit) {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }
}
