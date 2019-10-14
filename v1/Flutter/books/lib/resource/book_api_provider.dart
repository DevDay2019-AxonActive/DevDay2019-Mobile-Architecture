import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:books/model/book.dart';
import 'package:books/resource/repository.dart';

// root domain
final _root = "";

class BookApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<Book>> searchBook(String keywork) async {
    final response = await client.get('$_root/');
    final booksSearched = json.decode(response.body);

    return booksSearched;
  }
}
