import 'package:flutter/widgets.dart';

abstract class BookDetailEvent {}

class LoadBookDetailEvent extends BookDetailEvent {
  int bookId;

  LoadBookDetailEvent({@required this.bookId});
}
