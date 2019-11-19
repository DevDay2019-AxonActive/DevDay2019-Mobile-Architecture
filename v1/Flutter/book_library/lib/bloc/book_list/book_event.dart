abstract class BookEvent {}

class FetchBook extends BookEvent {}

class SearchBook extends BookEvent {
  String keyword;
  SearchBook({this.keyword});
}
