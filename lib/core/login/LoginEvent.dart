import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class SwitchRegisterMode extends LoginEvent {
  @override
  String toString() =>
      'SwitchRegisterModes';
}

class SwitchLoginMode extends LoginEvent {
  @override
  String toString() =>
      'SwitchLoginMode';
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  bool isRegister;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    this.isRegister = false
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}