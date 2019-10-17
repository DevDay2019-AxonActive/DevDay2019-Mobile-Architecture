import 'dart:async';
import 'dart:convert';

import 'package:books/model/book.dart';
import 'package:books/resource/repository.dart';
import 'package:books/resource/state.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';

class BookApiProvider implements Source {
  Client client = Client();

  // base url
  final _baseUrl = "http://192.168.70.59:8080/";
  final _listBookEndpoint = "library-core/api/books/";
  final _searchBookEndpoint = "library-core/api/books/search/";

  /// This will return a list of books
  Future<State> getBooks() async {
    try {
      var response =
          await client.get("http://192.168.70.59:8080/library-core/api/books/");
      if (response.statusCode == 200) {
        var list = json.decode(response.body) as List;
        List<Book> books = list.map((i) => Book.fromJson(i)).toList();

        return State<List<Book>>.success(books);
      } else
        return State<String>.error(response.statusCode.toString());
    } finally {
      client.close();
    }
  }

  /// This will return a list of books based on the query provided.
  /// It will either return a success or error state.

  Future<State> searchBooksByKeyword(String keyword) async {
    try {
      var response = await client
          .post('$_baseUrl$_searchBookEndpoint', body: {'keyword': keyword});
      if (response.statusCode == 200) {
        var list = json.decode(response.body) as List;
        List<Book> books = list.map((i) => Book.fromJson(i)).toList();
        return State<List<Book>>.success(books);
      } else
        return State<String>.error(response.statusCode.toString());
    } finally {
      client.close();
    }
  }
}
