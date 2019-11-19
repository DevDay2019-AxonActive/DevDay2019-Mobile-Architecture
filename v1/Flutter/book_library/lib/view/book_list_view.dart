import 'package:book_library/bloc/book_list/book_state.dart';
import 'package:book_library/bloc/navigation/navigator_bloc.dart';
import 'package:book_library/bloc/navigation/navigator_event.dart';
import 'package:book_library/model/book.dart';
import 'package:book_library/view/book_detail_view.dart';
import 'package:book_library/view/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_list/book_bloc.dart';
import '../bloc/book_list/book_event.dart';

class BookListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListViewState();
  }
}

class BookListViewState extends State<BookListView> {
  final _bloc = BookBloc();
  // List<Book> _listBook;
  @override
  void initState() {
    super.initState();
    // _listBook = List<Book>();
    _bloc.add(FetchBook());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: Text("Book Library"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Logout"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _bloc.add(SearchBook(keyword: value));
                },
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
            child: buildListBook(context),
          ),
        ],
      ),
    );
  }

  Widget buildListBook(context) {
    return BlocBuilder<BookBloc, BookState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is Uninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BooksLoadedFailed) {
          return Center(
            child: Text('${state.errorDescription.toString()}'),
          );
        }
        if (state is BooksLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BooksLoaded) {
          // _listBook.clear();
          // _listBook = state.books;
          if (state.books.length > 0) {
            return ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      navigateToBookDetail(context, state.books[index]);
                    },
                    child: BookTile(book: state.books[index]),
                  );
                });
          } else {
            return Center(
              child: Text('no books loaded'),
            );
          }
        }
        return null;
      },
    );
  }

  void navigateToBookDetail(BuildContext context, Book book) {
    BlocProvider.of<NavigatorBloc>(context)
        .add(NavigateToBookDetailEvent(aBook: book));
  }
}
