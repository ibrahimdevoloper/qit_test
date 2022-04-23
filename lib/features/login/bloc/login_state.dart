part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginLoaded extends LoginState {
  String name;
  String email;
  String token;

  LoginLoaded(this.name, this.email, this.token);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginLoaded && o.token.compareTo(token) == 0;
  }

  @override
  int get hashCode => token.hashCode;
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
class LoginEmailCorrect extends LoginState {
  LoginEmailCorrect();
}
class LoginEmailIncorrect extends LoginState {
  LoginEmailIncorrect();
}
