import 'package:books/resource/book_api_provider.dart';
import 'package:books/resource/state.dart';

abstract class Source {}

class Repository {
  static final Repository _repository = Repository._private();
  Repository._private();
  factory Repository() => _repository;

  BookApiProvider _imageProvider = BookApiProvider();

  Future<State> searchBook(keyword) =>
      _imageProvider.searchBooksByKeyword(keyword);
}
