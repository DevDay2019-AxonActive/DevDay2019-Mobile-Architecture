import 'package:books/bloc/base_bloc.dart';
import 'package:books/bloc/book_bloc.dart';
import 'package:books/model/book.dart';
import 'package:books/screen/book_cell.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  BookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BookBloc();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book List'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                      bloc.changeKeyword(value);
                    },
                  controller: editingController,
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
            ),
            buildListBook(bloc)
          ],
        ),
      ),
    );
  }

  Widget buildListBook(BookBloc bloc) {
    return StreamBuilder(
      stream: bloc.allBooks,
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return new BookCell(snapshot.data[index]);
          },
        );
      },
    );
  }
}
