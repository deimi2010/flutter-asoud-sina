part of 'comment_bloc.dart';

enum CommentStatus { initial, loading, success, failure }

class CommentState {
  final List<CommentModel> commentList;

  const CommentState({required this.commentList});

  factory CommentState.initial() {
    return const CommentState(commentList: []);
  }

  CommentState copyWith({final List<CommentModel>? commentList}) {
    return CommentState(commentList: commentList ?? this.commentList);
  }
}
