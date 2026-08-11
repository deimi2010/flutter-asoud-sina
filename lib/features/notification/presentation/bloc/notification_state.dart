part of 'notification_bloc.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}
