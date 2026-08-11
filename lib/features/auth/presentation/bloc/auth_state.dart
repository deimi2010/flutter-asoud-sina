part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final String phoneNumber;
  final AuthStatus status;
  final bool termStatus;
  final String error;

  const AuthState({
    this.phoneNumber = '',
    required this.status,
    required this.termStatus,
    this.error = '',
  });

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
      termStatus: false,
      error: '',
      phoneNumber: '',
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    bool? termStatus,
    String? error,
    String? phoneNumber,
  }) {
    return AuthState(
      status: status ?? this.status,
      termStatus: termStatus ?? this.termStatus,
      error: error ?? this.error,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
