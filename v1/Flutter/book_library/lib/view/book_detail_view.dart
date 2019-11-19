import 'package:book_library/model/book.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatefulWidget {

  final Book book;
  BookDetailView({this.book});

  @override
  State<StatefulWidget> createState() {
    return BookDetailViewState();
  }

}

class BookDetailViewState extends State<BookDetailView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book detail"),
      ),
      body: Center(child: Text('${widget.book.name}'),),
    );
  }
}