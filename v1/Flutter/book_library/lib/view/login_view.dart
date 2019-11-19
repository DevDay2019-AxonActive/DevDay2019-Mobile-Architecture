import 'package:book_library/bloc/login/login_bloc.dart';
import 'package:book_library/bloc/login/login_event.dart';
import 'package:book_library/bloc/login/login_state.dart';
import 'package:book_library/bloc/navigation/navigator_bloc.dart';
import 'package:book_library/bloc/navigation/navigator_event.dart';
import 'package:book_library/mixin/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> with Validator {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'simple');
  final passwordController = TextEditingController(text: 'simple');

  final loginBloc = LoginBloc();

  var _isLoading = false;

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginLoading) {
          _isLoading = true;
        }
        if (state is UserLoginSuccess) {
          _isLoading = false;

          BlocProvider.of<NavigatorBloc>(context)
              .add(NavigateToBookListEvent());
        }
        if (state is UserLoginFail) {
          _isLoading = false;
          _showDialog(state.errorDescription);
        }
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Stack(
          children: buildLoginForm(context),
        ),
      ),
    );
  }

  List<Widget> buildLoginForm(BuildContext context) {
    final stack = Column(
      children: <Widget>[
        emailField(context),
        passwordField(context),
        Container(margin: EdgeInsets.only(top: 10.0)),
        submitButton(context)
      ],
    );
    var loginForm = new List<Widget>();
    loginForm.add(stack);

    if (_isLoading) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.0,
            child: const ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      loginForm.add(modal);
    }

    return loginForm;
  }

  Widget emailField(BuildContext context) {
    return StreamBuilder(
      stream: loginBloc.email,
      builder: (context, snapshot) {
        return TextField(
          controller: emailController,
          // onChanged: loginBloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Username",
            hintText: "Please input your Username",
            errorText: snapshot.error,
          ),
          // validator: validateEmail,
        );
      },
    );
  }

  Widget passwordField(BuildContext context) {
    return StreamBuilder(
      stream: loginBloc.password,
      builder: (context, snapshot) {
        return TextField(
          controller: passwordController,
          // onChanged: loginBloc.changePassword,
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
    return RaisedButton(
      child: Text("Login"),
      onPressed: () {
        loginBloc.add(UserLoginEvent(
            username: emailController.text, password: passwordController.text));
      },
    );
  }

  void _showDialog(String errorString) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(errorString),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Try again"),
              onPressed: () {
                Navigator.of(context).pop();
                
              },
            ),
          ],
        );
      },
    );
  }
}
