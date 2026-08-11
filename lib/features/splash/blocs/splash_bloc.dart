import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:bloc/bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashInitialEvent>((event, emit) async {
      emit(const SplashState(status: SplashStatus.loading));

      String? token = await SecureStorage.readSecureStorage(Keys.token);
      if (token != 'ND') {
        emit(const SplashState(status: SplashStatus.exist));
      } else {
        emit(const SplashState(status: SplashStatus.notExist));
      }
    });
  }
}
