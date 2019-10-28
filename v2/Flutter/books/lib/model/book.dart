import 'package:books/model/book_detail.dart';
import 'package:books/model/user.dart';

class Book {
  String author;
  List<BookDetail> details;
  int id;
  String name;
  String serialNumber;
  List<User> subscribers;

  Book(this.author, this.details, this.id, this.name, this.serialNumber,
      this.subscribers);

  Book.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        details = json['details'],
        id = json['id'],
        name = json['name'],
        serialNumber = json['serialNumber'],
        subscribers = json['subscribers'];

  Map<String, dynamic> toJson() => {
        'author': author,
        'details': details,
        'id': id,
        'name': name,
        'serialNumber': serialNumber,
        'subscribers': subscribers,
      };
}
