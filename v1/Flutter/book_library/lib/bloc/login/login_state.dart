import 'package:book_library/model/login_user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class UserLoginFail extends LoginState {
  final String errorDescription;
  UserLoginFail({this.errorDescription});

  @override
  String toString() {
    return errorDescription;
  }
}

class UserLoginSuccess extends LoginState {
  final LoginUser loggedUser;
  UserLoginSuccess({this.loggedUser});
}
