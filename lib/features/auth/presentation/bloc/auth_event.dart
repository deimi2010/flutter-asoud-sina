part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class SendOtp extends AuthEvent {
  final String phone;

  const SendOtp({required this.phone});
}

class VerifyOtp extends AuthEvent {
  final String phone;
  final String otp;
  const VerifyOtp({required this.phone, required this.otp});
}

class ToggleTermsCheckboxEvent extends AuthEvent {
  final bool isClicked;
  const ToggleTermsCheckboxEvent({required this.isClicked});
}

class Logout extends AuthEvent {}
