import 'package:books/bloc/login_bloc/provider.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: Column(
        children: <Widget>[buildSearchBar(context)],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
