part of 'auth_cubit.dart';

//todo: organize all states like this
abstract class AuthState {}

class AuthLoginSuccessState extends AuthState {
  User? user;
  bool? wasLogout;

  AuthLoginSuccessState({this.user, this.wasLogout});
}

class AuthLoginErrorState extends AuthState {
  String message;
  AuthLoginErrorState(this.message);
}

class AuthLogoutState extends AuthState {
  PhoneSignIn phoneSignInForm;
  AuthLogoutState(this.phoneSignInForm);
}

class AuthLoadingState extends AuthState {}
