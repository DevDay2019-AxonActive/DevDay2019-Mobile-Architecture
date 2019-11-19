import 'package:book_library/model/book.dart';

abstract class NavigatorEvent {  
  
}

class NavigatorEventPop extends NavigatorEvent {}
class NavigateToBookListEvent extends NavigatorEvent {}
class NavigateToBookDetailEvent extends NavigatorEvent {
  Book aBook;
  NavigateToBookDetailEvent({this.aBook});
}