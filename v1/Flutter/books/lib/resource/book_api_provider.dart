import 'dart:async';
import 'dart:convert';

import 'package:books/model/book.dart';
import 'package:books/resource/repository.dart';
import 'package:books/resource/state.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';

class BookApiProvider implements Source {
  Client _client = Client();

  // base url
  final _baseUrl = "https://192.168.70.59:8080/";
  final _listBookEndpoint = "library-core/api/books/";
  final _searchBookEndpoint = "library-core/api/books/search/";

/**
 * This will return a list of books
 */
  Future<State> getBooks() async {
    Response response;

    try {
      var response = await _client.get('$_baseUrl$_listBookEndpoint');
      if (response.statusCode == 200)
        return State<Book>.success(Book.fromJson(json.decode(response.body)));
      else
        return State<String>.error(response.statusCode.toString());
    } finally {
      _client.close();
    }
  }

  /**
   * This will return a list of books based on the query provided. 
   * It will either return a success or error state.
   */

  Future<State> searchBooksByKeyword(String keyword) async {
    Response response;

    try {
      var response = await _client
          .post('$_baseUrl$_searchBookEndpoint', body: {'keyword': keyword});
      if (response.statusCode == 200)
        return State<Book>.success(Book.fromJson(json.decode(response.body)));
      else
        return State<String>.error(response.statusCode.toString());
    } finally {
      _client.close();
    }
  }
}
