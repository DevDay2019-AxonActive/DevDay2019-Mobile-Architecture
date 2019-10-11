import 'package:books/model/book.dart';
import 'package:books/model/comment.dart';
import 'package:books/model/rating.dart';
import 'package:books/model/tag.dart';

enum SourceEnum {
  AAHCM,
  AACT,
  AADN, 
  AAYG, 
  PANMAC, 
  OPEN_LIBRARY,
  BOOK_MOOCH,
  IT_BOOK_STORE,UNKNOWN  
}

class BookDetail {
  Book book;
  List<Comment> comments;
  String coverUrl;
  String description;
  int id;
  List<Rating> ratings;
  SourceEnum source;
  List<Tag> tags;

  BookDetail (this.book, this.comments, this.coverUrl, this.description, this.id, this.ratings, this.source, this.tags);
}
