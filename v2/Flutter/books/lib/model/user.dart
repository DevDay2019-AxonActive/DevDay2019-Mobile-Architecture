import 'package:books/model/book.dart';
import 'package:books/model/comment.dart';
import 'package:books/model/device.dart';
import 'package:books/model/rating.dart';

class User {
  List<Book> bookInWishList;
  List<Comment> comments;
  DateTime createAt;
  List<Device> devices;
  String email;
  String fullName;
  int id;
  List<Rating> ratings;

  User(this.bookInWishList, this.comments, this.createAt, this.devices,
      this.email, this.fullName, this.id, this.ratings);

  User.fromJson(Map<String, dynamic> json)
      : bookInWishList = json['bookInWishList'],
        comments = json['comments'],
        createAt = json['createAt'],
        devices = json['devices'],
        email = json['email'],
        fullName = json['fullName'],
        id = json['id'],
        ratings = json['ratings'];

  Map<String, dynamic> toJson() => {
        'bookInWishList': bookInWishList,
        'comments': comments,
        'createAt': createAt,
        'devices': devices,
        'email': email,
        'fullName': fullName,
        'id': id,
        'ratings': ratings,
      };
}
