import 'package:book_library/model/book_detail.dart';

abstract class BookDetailState {}

class BookDetailUninitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoadedSuccess extends BookDetailState {
  Detail bookDetail;
  BookDetailLoadedSuccess({this.bookDetail});
}

class BookDetailLoadedFailed extends BookDetailState {}
