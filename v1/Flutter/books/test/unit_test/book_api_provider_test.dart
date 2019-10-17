import 'package:books/model/book.dart';
import 'package:books/resource/book_api_provider.dart';
import 'package:books/resource/state.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('test getBooks function', () async {
    final bookApi = BookApiProvider();
    final books = List<Book>();

    bookApi.client = MockClient((request) async {
      return Response(json.encode(books), 200);
    });

    final actualBooks = await bookApi.getBooks();
    if (actualBooks is SuccessState) {
      expect(actualBooks.value, books);
    } else {}
  });

  test('test search book function', () async {
    final bookApi = BookApiProvider();
    final returnedSearchedBooks = List<Book>();

    bookApi.client = MockClient((request) async {
      return Response(json.encode(returnedSearchedBooks), 200);
    });

    final actualReturnedSearchedBooks =
        await bookApi.searchBooksByKeyword('keyword');

    if (actualReturnedSearchedBooks is SuccessState) {
      expect(actualReturnedSearchedBooks.value, returnedSearchedBooks);
    } else {}
  });
}
