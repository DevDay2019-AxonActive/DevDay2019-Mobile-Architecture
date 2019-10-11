import 'package:books/screen/books_list_view.dart';
import 'package:flutter/material.dart';
import 'screen/login_view.dart';
import 'package:books/bloc/login_bloc/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(context) {
    return Provider(
      child: MaterialApp(
        title: 'Log Me In!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: LoginView(),
        ),
        initialRoute: "/",
        routes: {
          "": (context) => LoginView(),
          "listbooks": (context) => BookListView(),
        },
      ),
    );
  }
}
