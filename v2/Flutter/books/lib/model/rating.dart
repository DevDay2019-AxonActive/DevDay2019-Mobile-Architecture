import 'package:books/model/book_detail.dart';
import 'package:books/model/user.dart';

class Rating {
  BookDetail bookDetail;
  int id;
  User user;
  int value;

  Rating(this.bookDetail, this.id, this.user, this.value);

  Rating.fromJson(Map<String, dynamic> json)
      : bookDetail = json['bookDetail'],
        id = json['id'],
        user = json['user'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'bookDetail': bookDetail,
        'id': id,
        'user': user,
        'value': value,
      };
}
