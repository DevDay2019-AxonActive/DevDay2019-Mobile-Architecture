import 'package:book_library/bloc/navigation/navigator_event.dart';
import 'package:book_library/mixin/constant.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorEventPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToBookListEvent) {
      navigatorKey.currentState.pushNamed(bookListRoute);
    } else if (event is NavigateToBookDetailEvent) {
      navigatorKey.currentState.pushNamed(bookDetailRoute, arguments: event.aBook);
    }
  }
}
