import 'package:books/bloc/base_bloc.dart';
import 'package:books/bloc/search_book_bloc/search_book_bloc.dart';
import 'package:books/screen/book_cell.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  @override
  initState() {
    super.initState();
  }

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: editingController,
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: new Container(),
          ),
        ],
      ),
    );
  }

  StreamBuilder buildBookList(BuildContext context) {
    // SearchBookBloc bloc = SearchBookBlocProvider.of(context);
    SearchBookBloc bloc = BlocProvider.of<SearchBookBloc>(context);
    return StreamBuilder(
        stream: bloc.bookList,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return BookCell(snapshot.data[index]);
                });
          } else {
            return null;
          }
        });
  }
}
