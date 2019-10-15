import 'dart:async';
import 'package:books/mixin/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:books/bloc/base_bloc.dart';

class LoginBloc extends BaseBloc with Validator {
  final _email = StreamController<String>.broadcast();
  final _password = StreamController<String>.broadcast();

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
  }

  btnLoginPressed() {  
  }
}

/*  
this is for Global Access approach
with scoped bloc approach, following line is not necessary anymore
 */

// final bloc = Bloc();
