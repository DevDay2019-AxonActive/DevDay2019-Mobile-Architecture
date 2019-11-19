import 'dart:async';
import 'dart:convert';

import 'package:book_library/model/book.dart';
import 'package:book_library/model/comment.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import '../../model/book_detail.dart';
import '../state.dart';

class BookApiProvider {
  Client client = Client();

  // base url
  // final _baseUrl = "http://127.0.0.1:8080";
  final _baseUrl = "http://85.214.44.228:8082";
  final _listBookEndpoint = "/library-core/api/books";
  final _searchBookEndpoint = "/library-core/api/books/search";

  /// This will return a list of books
  Future<State> fetchBook() async {
    try {
      var response =
          await client.get('$_baseUrl$_listBookEndpoint');
      if (response.statusCode == 200) {
        var list = json.decode(response.body) as List;
        List<Book> books = list.map((i) => Book.fromJson(i)).toList();
        // print("${books.length}");
        return State<List<Book>>.success(books);
      } else
        return State<String>.error(response.statusCode.toString());
    } finally {
      client.close();
    }
  }

  /// This will return a list of books based on the query provided.
  /// It will either return a success or error state.
  ///
  Future<State> fetchBookByKeyword(String keyword) async {
    try {
      final uri = '$_baseUrl/$_searchBookEndpoint';
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {'keyword': '$keyword'};
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      // make POST request
      Response response =
          await post(uri, headers: headers, body: jsonBody, encoding: encoding);

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

  /// get detail of a book
  Future<State> getBookDetail(int bookId) async {
    try {
      final url = '$_baseUrl$_listBookEndpoint/$bookId';

      Response response = await client.get(url);

      if (response.statusCode == 200) {
        return State<Detail>.success(
            Detail.fromJson(json.decode(response.body)));
      } else
        return State<String>.error(response.statusCode.toString());
    } finally {
      client.close();
    }
  }

  /// get comment by book id
  Future<State> getCommentsByBookId(int bookId) async {
    final url = '$_baseUrl$_listBookEndpoint/$bookId/comments';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      List<Comment> comments = list.map((i) => Comment.fromJson(i)).toList();
      return State<List<Comment>>.success(comments);
    } else {
      return State<String>.error(response.statusCode.toString());
    }
  }

  /// add comment 
}
