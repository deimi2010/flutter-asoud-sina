part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServiceLoadSuccess extends ServiceState {}

final class ServiceLoadFailure extends ServiceState {}
