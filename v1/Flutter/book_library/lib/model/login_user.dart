import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class LoginUser extends Equatable {
  
  final String email;
  final String fullName;
  final String password;
  final String username;

  LoginUser({
    @required this.email,
    @required this.fullName,
    @required this.password,
    @required this.username,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => new LoginUser(
        email: json["email"] == null ? null : json["email"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        password: json["password"] == null ? null : json["password"],
        username: json["username"] == null ? null : json["username"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "fullName": fullName == null ? null : fullName,
        "password": password == null ? null : password,
        "username": username == null ? null : username,
      };

  @override
  List<Object> get props => [email, fullName, username, password];
}
