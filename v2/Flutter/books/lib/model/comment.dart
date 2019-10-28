import 'package:books/model/book_detail.dart';
import 'package:books/model/user.dart';

class Comment {
  BookDetail bookDetail;
  String content;
  int id;
  Comment parent;
  int parentId;
  User user;

  Comment(this.bookDetail, this.content, this.id, this.parent, this.parentId,
      this.user);

  Comment.fromJson(Map<String, dynamic> json)
      : bookDetail = json['bookDetail'],
        content = json['content'],
        id = json['id'],
        parent = json['parent'],
        parentId = json['parentId'],
        user = json['user'];

  Map<String, dynamic> toJson() => {
        'bookDetail': bookDetail,
        'content': content,
        'id': id,
        'parent': parent,
        'parentId': parentId,
        'user': user,
      };
}
