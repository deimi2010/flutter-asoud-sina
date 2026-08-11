part of 'splash_bloc.dart';

sealed class SplashEvent {
  const SplashEvent();
}

class SplashInitialEvent extends SplashEvent {}
