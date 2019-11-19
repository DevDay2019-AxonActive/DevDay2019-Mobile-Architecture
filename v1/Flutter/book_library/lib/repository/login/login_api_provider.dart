import 'dart:convert';

import 'package:book_library/model/login_user.dart';
import 'package:http/http.dart';

import '../state.dart';

class LoginApiProvider {
  Client client = Client();

  final _baseUrl = "http://85.214.44.228:8082";
  // final _baseUrl = "http://127.0.0.1:8080";
  final _userLoginEndpoint = "/user/login";

  Future<State> login(String username, String password) async {
    final response = await client.get(
        "$_baseUrl$_userLoginEndpoint?username=$username&password=$password");
    if (response.statusCode == 200) {
      return State<LoginUser>.success(
          LoginUser.fromJson(json.decode(response.body)));
    } else {
      Map map = json.decode(response.body);
      return State.error(map);
    }
  }
}
