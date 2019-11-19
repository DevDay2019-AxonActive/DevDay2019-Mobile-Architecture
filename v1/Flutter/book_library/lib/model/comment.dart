import 'dart:convert';

import 'package:book_library/model/user.dart';

class Comment {
  String content;
  int id;
  int parentId;
  Subscriber user;

  Comment({
    this.content,
    this.id,
    this.parentId,
    this.user,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        content: json["content"] == null ? null : json["content"],
        id: json["id"] == null ? null : json["id"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        user: json["user"] == null ? null : Subscriber.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "id": id == null ? null : id,
        "parentId": parentId == null ? null : parentId,
        "user": user == null ? null : user.toJson(),
      };
}
