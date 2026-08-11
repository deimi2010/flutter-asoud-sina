part of 'service_bloc.dart';

sealed class ServiceEvent {
  const ServiceEvent();
}

final class CreateService extends ServiceEvent {}

final class UpdateService extends ServiceEvent {}

final class DeleteService extends ServiceEvent {}
