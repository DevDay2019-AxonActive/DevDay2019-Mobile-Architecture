import 'package:flutter/material.dart';
import 'search_book_bloc.dart';

class SearchBookBlocProvider extends InheritedWidget {
  final SearchBookBloc searchBloc;

  SearchBookBlocProvider({Key key, Widget child})
      : searchBloc = SearchBookBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static SearchBookBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SearchBookBlocProvider)
            as SearchBookBlocProvider)
        .searchBloc;
  }
}
