import 'package:books/bloc/base_bloc.dart';
import 'package:books/bloc/login_bloc/login_bloc.dart';
import 'package:books/bloc/login_bloc/login_bloc_provider.dart';
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

  final emailController =
      TextEditingController(text: 'devday2019@axonactive.com');
  final passwordController = TextEditingController(text: 'khongbiet');

  @override
  Widget build(BuildContext context) {
    final bloc = LoginBlocProvider.of(context);
    // final bloc = BlocProvider.of<LoginBloc>(context);
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

  Widget emailField(LoginBloc bloc) {
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

  Widget passwordField(LoginBloc bloc) {
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

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text("Login"),
            // onPressed: snapshot.hasData ? () {
            //   // bloc.btnLoginPressed();
            //   // Navigator.push(context, MaterialPageRoute(builder: (context) => BookListView()));
            //   Navigator.pushNamed(context, "listbooks");
            // } : null,

            onPressed: () {
              Navigator.pushNamed(context, "listbooks");
            },
          );
        });
  }
}
