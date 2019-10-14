import 'package:books/bloc/base_bloc.dart';
import 'package:books/bloc/login_bloc/login_bloc.dart';
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

  final emailController =
      TextEditingController(text: 'devday2019@axonactive.com');
  final passwordController = TextEditingController(text: 'khongbiet');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(context),
            passwordField(context),
            Container(margin: EdgeInsets.only(top: 10.0)),
            submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget emailField(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          controller: emailController,
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

  Widget passwordField(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          controller: passwordController,
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

  Widget submitButton(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.pushNamed(context, "listbooks");
            },
          );
        });
  }
}
