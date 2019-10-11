import 'package:books/bloc/login_bloc/bloc.dart';
import 'package:books/bloc/login_bloc/provider.dart';
import 'package:books/mixin/validator.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> with Validator {
  final formKey = GlobalKey<FormState>();
  var _throwShotAway = false;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
      margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(bloc),
            passwordField(bloc),
            Container(margin: EdgeInsets.only(top: 10.0)),
            // rememberCheckbox(),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Please input your email",
            errorText: snapshot.error,
          ),
          // validator: validateEmail,
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Please input your password",
            errorText: snapshot.error,
          ),
          // validator: validatePassword,
        );
      },
    );
  }

  Widget rememberCheckbox() {
    return Row(children: <Widget>[
      Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.black,
          value: _throwShotAway,
          onChanged: (bool newValue) {
            setState(() {
              _throwShotAway = newValue;
            });
          }),
      Text("Remember me")
    ]);
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text("Login"),
            onPressed: snapshot.hasData ? () {
              bloc.btnLoginPressed();
            } : null,
          );
        });
  }
}

