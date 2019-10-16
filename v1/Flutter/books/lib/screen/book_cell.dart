import 'package:books/model/book.dart';
import 'package:flutter/material.dart';

class BookCell extends StatelessWidget {
  final Book aBook;

  BookCell(this.aBook);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(aBook.author),
        ),
        Divider(),
      ],
    );
  }
}
