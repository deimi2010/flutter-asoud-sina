part of 'chat_bloc.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}
