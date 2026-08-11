part of 'comment_bloc.dart';

sealed class CommentEvent {
  const CommentEvent();
}

class LoadComments extends CommentEvent {
  final int marketId;
  const LoadComments({required this.marketId});
}
