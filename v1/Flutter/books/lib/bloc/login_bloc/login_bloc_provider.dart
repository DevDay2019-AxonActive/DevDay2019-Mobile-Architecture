import 'package:books/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginBlocProvider extends InheritedWidget {
  final bloc = LoginBloc();

  LoginBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  
  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginBlocProvider) as LoginBlocProvider).bloc;
  }
}