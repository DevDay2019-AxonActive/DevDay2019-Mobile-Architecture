import 'dart:convert';

import 'package:book_library/model/book.dart';
import 'package:book_library/model/book_detail.dart';
import 'package:book_library/repository/book/book_api_provider.dart';
import 'package:book_library/repository/state.dart';
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

    final actualBooks = await bookApi.fetchBook();

    if (actualBooks is SuccessState) {
      // print("--book: ${books.length}");
      // print("--actual book: ${actualBooks.value.length}");
      expect(actualBooks.value.length, books.length);
    } else {}
  });

  test('test search book function', () async {
    final bookApi = BookApiProvider();
    final returnedSearchedBooks = List<Book>();

    bookApi.client = MockClient((request) async {
      return Response(json.encode(returnedSearchedBooks), 200);
    });

    final actualReturnedSearchedBooks =
        await bookApi.fetchBookByKeyword('keyword');

    if (actualReturnedSearchedBooks is SuccessState) {
      expect(actualReturnedSearchedBooks.value, returnedSearchedBooks);
    } else {}
  });

  test("test get book's detail", () async {
    final bookApi = BookApiProvider();
    final returnedBookDetail = Detail(id: 123);

    bookApi.client = MockClient((request) async {
      return Response(json.encode(returnedBookDetail), 200);
    });

    final actualReturnedBookDetai = await bookApi.getBookDetail(123);

    if (actualReturnedBookDetai is SuccessState) {
      expect(
          (actualReturnedBookDetai.value as Detail).id, returnedBookDetail.id);
    }
  });
}
