import 'package:flutter/material.dart';

class BookListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Books"),
      ),
      body: Center(
        child: Text("This is the book list view"),
      ),
    );
  }
}
