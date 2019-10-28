import 'dart:async';

import 'package:books/bloc/base_bloc.dart';
import 'package:books/model/book.dart';
import 'package:books/resource/repository.dart';
import 'package:books/resource/state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBookBloc extends BaseBloc {
  static Repository _repository = Repository();

  PublishSubject<String> _keywordSubject;

  SearchBookBloc() {
    _keywordSubject = PublishSubject<String>();
  }

  Function(String) get changeKeyword => _keywordSubject.sink.add;

  final streamTransformer = StreamTransformer<String, List<Book>>.fromHandlers(
      handleData: (keyword, sink) async {
    State state = await _repository.searchBook(keyword);
    if (state is SuccessState) {
      sink.add(state.value);
    } else {
      sink.addError((state as ErrorState).msg);
    }
  });

  Observable<List<Book>> get bookList => _keywordSubject.stream
      .debounceTime(Duration(milliseconds: 300))
      .where((String value) => value.isNotEmpty)
      .distinct()
      .transform(streamTransformer);

  @override
  void dispose() {
    _keywordSubject.close();
  }
}
