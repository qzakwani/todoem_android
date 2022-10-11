// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseApp fb;
  late final StreamSubscription<User?> _authSub;
  AuthBloc(this.fb) : super(LoadingAuth()) {
    _authSub = FirebaseAuth.instanceFor(app: fb)
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        add(AuthStatusChange());
      } else {
        add(AuthStatusChange(user));
      }
    });
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
