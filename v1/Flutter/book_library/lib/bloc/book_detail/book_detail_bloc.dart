import 'package:bloc/bloc.dart';
import 'package:book_library/bloc/book_detail/book_detail_event.dart';
import 'package:book_library/bloc/book_detail/book_detail_state.dart';
import 'package:book_library/repository/repository.dart';
import 'package:book_library/repository/state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final _repo = Repository();

  @override
  BookDetailState get initialState => BookDetailUninitial();

  @override
  Stream<BookDetailState> mapEventToState(BookDetailEvent event) async* {
    final currentState = state;
    if (event is LoadBookDetailEvent) {
      if (currentState is BookDetailUninitial) {
        yield BookDetailLoading();
        final returnedStatus = await _repo.getBookDetail(event.bookId);
        if (returnedStatus is SuccessState) {
          yield BookDetailLoadedSuccess(bookDetail: returnedStatus.value);
        }
      }
      if (currentState is BookDetailLoadedFailed) {}
      if (currentState is BookDetailLoadedSuccess) {}
      if (currentState is BookDetailLoading) {}
    }
  }
}
