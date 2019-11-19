import 'package:book_library/model/book_detail.dart';

class Tag {
  Detail bookDetail;
  int id;
  String name;

  Tag(this.bookDetail, this.id, this.name);

  Tag.fromJson(Map<String, dynamic> json)
      : bookDetail = json['bookDetail'],
        id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'bookDetail': bookDetail,
        'id': id,
        'name': name,
      };
}
