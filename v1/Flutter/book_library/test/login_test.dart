import 'dart:convert';

import 'package:book_library/model/login_user.dart';
import 'package:book_library/repository/login/login_api_provider.dart';
import 'package:book_library/repository/state.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  final _loginApiProvider = LoginApiProvider();

  test('login success', () async {
    // expected user
    final loggingUser = LoginUser(
        username: 'simple', password: 'simple', fullName: null, email: null);

    // convert object to response format.
    final expectedResponse = json.decode(json.encode(loggingUser));

    // mock client
    _loginApiProvider.client = MockClient((request) async {
      return Response(expectedResponse, 200);
    });

    // call 'real' api
    final actualResult = await _loginApiProvider.login('simple', 'simple');

    // check 
    if (actualResult is SuccessState) {
      final loggedUser = json.decode(json.encode(actualResult.value));
      expect(loggedUser, expectedResponse);
    } else {
      throw Exception('Failed to login.');
    }
  });

  test('login fail', () async {
    final mapJson = {
      "status": 400,
      "error": "Bad Request",
      "message":
          "User failed to login. Exception: User cannot be found. Username: not-simple",
    };  

    _loginApiProvider.client = MockClient((request) async {
      return Response(json.encode(mapJson), 400);
    });

    final actualResult =
        await _loginApiProvider.login('not-simples', 'not-simple');
    if (actualResult is ErrorState) {
      expect(actualResult.msg,mapJson);
    } else {}
  });
}