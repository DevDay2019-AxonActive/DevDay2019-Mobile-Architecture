import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoginEvent extends LoginEvent {
  final String username;
  final String password;

  UserLoginEvent({this.username, this.password});
}
