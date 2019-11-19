/* This is a generic class which will help to manage the current state 
i.e success or error based on the network response. */

class State<T>{
  State._();
  factory State.success(T value) = SuccessState<T>;
  factory State.error(T msg) = ErrorState<T>;
}

class ErrorState<T> extends State<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends State<T> {
  SuccessState(this.value) : super._();
  final T value;
}