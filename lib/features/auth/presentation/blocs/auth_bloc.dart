import 'package:asood/core/helper/secure_storage.dart';
import 'package:bloc/bloc.dart';

import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/auth/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<SendOtp>((event, emit) async {
      await _sendOtp(event, emit);
    });
    on<ToggleTermsCheckboxEvent>((event, emit) {
      emit(state.copyWith(termStatus: event.isClicked ? true : false));
    });
    on<Logout>((event, emit) {});
    on<VerifyOtp>((event, emit) async {
      await _verifyOtp(event, emit);
    });
  }

  //send otp
  _sendOtp(event, emit) async {
    emit(state.copyWith(phoneNumber: event.phone, status: AuthStatus.loading));
    try {
      var res = await authRepository.sendCode(event.phone);
      if (res is Success) {
        emit(state.copyWith(status: AuthStatus.success));
      } else if (res is Failure) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            error: res.errorResponse.toString(),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  //verify otp
  _verifyOtp(event, emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      var res = await authRepository.verifyCode(event.phone, event.otp);
      if (res is Success) {
        var json = res.response as Map<String, dynamic>;

        SecureStorage.writeSecureStorage('token', json["token"]);

        emit(state.copyWith(status: AuthStatus.success));
      } else if (res is Failure) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            error: res.errorResponse.toString(),
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}
