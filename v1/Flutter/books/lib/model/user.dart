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

  User(this.bookInWishList, this.comments, this.createAt, this.devices, this.email, this.fullName, this.id, this.ratings);

}
