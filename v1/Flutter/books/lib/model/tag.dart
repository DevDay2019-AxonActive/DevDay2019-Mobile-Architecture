import 'package:books/model/book_detail.dart';

class Tag {
  BookDetail bookDetail;
  int id;
  String name;

  Tag(this.bookDetail, this.id, this.name);

  Tag.fromJson(Map<String, dynamic> json)
      : bookDetail = json['bookDetail'],
        id = json['id'],
        name = json['name'];
}