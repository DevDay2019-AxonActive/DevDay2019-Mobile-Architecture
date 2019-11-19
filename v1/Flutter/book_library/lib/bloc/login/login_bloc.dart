import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_library/bloc/login/login_event.dart';
import 'package:book_library/bloc/login/login_state.dart';
import 'package:book_library/mixin/validator.dart';
import 'package:book_library/repository/repository.dart';
import 'package:book_library/repository/state.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validator {
  final _repository = Repository();

  @override
  get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    final currentState = state;
    if (event is UserLoginEvent) {
      if (currentState is LoginInitial) {
        yield LoginLoading();
        final state = await _repository.login(event.username, event.password);
        if (state is SuccessState) {
          yield UserLoginSuccess(loggedUser: state.value);
          yield LoginInitial();
        } else if (state is ErrorState) {
          yield UserLoginFail(errorDescription: state.msg);
          yield LoginInitial();
        }
      }
    }
  }

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
}
