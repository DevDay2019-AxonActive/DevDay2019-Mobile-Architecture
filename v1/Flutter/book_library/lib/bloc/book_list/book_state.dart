import 'package:book_library/model/book.dart';

abstract class BookState {}

class Uninitialized extends BookState {}

class BooksLoading extends BookState {}

class BooksLoaded extends BookState {
  final List<Book> books;

  BooksLoaded({this.books});
}

class BooksLoadedFailed extends BookState {
  final String errorDescription;
  BooksLoadedFailed({this.errorDescription});

  @override
  String toString() {
    return errorDescription;
  }
}
