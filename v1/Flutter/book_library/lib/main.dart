import 'package:book_library/bloc/login/login_bloc.dart';
import 'package:book_library/mixin/constant.dart';
import 'package:book_library/view/book_detail_view.dart';
import 'package:book_library/view/book_list_view.dart';
import 'package:book_library/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation/navigator_bloc.dart';
import 'model/book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>(
      builder: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: BlocProvider(
            builder: (context) => LoginBloc(),
            child: LoginView(),
          ),
        ),
        onGenerateRoute: generateRoute,
        initialRoute: loginRoute,
      ),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case bookListRoute:
        return MaterialPageRoute(builder: (_) => BookListView());
      case bookDetailRoute:
        final aBook = settings.arguments as Book;
        return MaterialPageRoute(
            builder: (_) => BookDetailView(
                  book: aBook,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
