part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStatusChange extends AuthEvent {
  final User? user;

  AuthStatusChange([this.user]);
}

class LoadingAuthEvent extends AuthEvent {}
