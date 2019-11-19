import 'package:bloc/bloc.dart';
import 'package:book_library/bloc/book_list/book_event.dart';
import 'package:book_library/bloc/book_list/book_state.dart';
import 'package:book_library/repository/repository.dart';
import '../../repository/state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  Repository _repository = Repository();

  @override
  BookState get initialState => Uninitialized();

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    final currentState = state;
    if (event is FetchBook) {
      if (currentState is Uninitialized) {
        final State returnedValue = await _repository.fetchBook();
        if (returnedValue is SuccessState) {
          yield BooksLoaded(books: returnedValue.value);
        } else if (returnedValue is ErrorState) {
          yield BooksLoadedFailed(errorDescription: returnedValue.msg);
        } else {
          yield BooksLoadedFailed(errorDescription: "Load books failed!!!");
        }
      }
    }

    if (event is SearchBook) {
      if (currentState is BooksLoaded) {
        yield BooksLoading();
        final State returnedValue = await _repository.fetchBookByKeyword(event.keyword);
        if (returnedValue is SuccessState) {
          yield BooksLoaded(books: returnedValue.value);
        } else if (returnedValue is ErrorState) {
          yield BooksLoadedFailed(errorDescription: returnedValue.msg);
        } else {
          yield BooksLoadedFailed(errorDescription: "Load books failed!!!");
        }
      }
    }
  }
}
