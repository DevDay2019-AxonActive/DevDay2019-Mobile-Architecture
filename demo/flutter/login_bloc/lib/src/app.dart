import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'screens/login_view.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(context) {
    return Provider(
      child: MaterialApp(
        title: 'Log Me In!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('AAVN DEV DAY 2019'),
          ),
          body: LogInScreen(),
        ),
      ),
    );
  }
}