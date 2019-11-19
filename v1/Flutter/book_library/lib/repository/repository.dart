import 'package:book_library/repository/book/book_api_provider.dart';
import 'package:book_library/repository/login/login_api_provider.dart';
import 'package:book_library/repository/state.dart';

class Repository {
  LoginApiProvider loginProvider = LoginApiProvider();
  BookApiProvider bookApiProvider = BookApiProvider();

  Future<State> login(String username, String password) =>
      loginProvider.login(username, password);

  Future<State> fetchBook() => bookApiProvider.fetchBook();

  Future<State> fetchBookByKeyword(keyword) =>
      bookApiProvider.fetchBookByKeyword(keyword);
      
  Future<State> getBookDetail(bookId) => bookApiProvider.getBookDetail(bookId);
}
