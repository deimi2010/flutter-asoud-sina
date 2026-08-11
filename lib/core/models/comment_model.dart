class CommentModel{
  int? id;
  int? creator;
  String? content;
  List<Replies>? replies;

  CommentModel({this.id, this.creator, this.content, this.replies});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creator = json['creator'];
    content = json['content'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creator'] = creator;
    data['content'] = content;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  int? creator;
  String? content;

  Replies({this.id, this.creator, this.content});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creator = json['creator'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creator'] = creator;
    data['content'] = content;
    return data;
  }
}