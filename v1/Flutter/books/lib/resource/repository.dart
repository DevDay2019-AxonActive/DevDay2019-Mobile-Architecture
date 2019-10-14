import 'package:books/model/book.dart';

abstract class Source {
  Future<List<Book>> searchBook(String keywork);
}

class Repository {
  
}