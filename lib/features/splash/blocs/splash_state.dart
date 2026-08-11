part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, exist, notExist, error }

class SplashState {
  final SplashStatus status;
  const SplashState({required this.status});

  factory SplashState.initial() {
    return const SplashState(status: SplashStatus.initial);
  }
  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}
