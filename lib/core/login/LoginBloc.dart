import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/login/login.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null), assert(authenticationBloc != null);

  LoginState get initialState => LoginMode();

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        User user;

        if(!event.isRegister){
          user = await userRepository.authenticate(username: event.username, password: event.password);
        } else {
          user = await userRepository.createUser(username: event.username, password: event.password);
        }

        authenticationBloc.dispatch(LoggedIn(user: user));
        yield LoginMode();
      } catch (error) {
        yield LoginFailure(error: error.code);
      }
    }

    if(event is SwitchLoginMode){
      yield LoginMode();
    }

    if(event is SwitchRegisterMode){
      yield RegisterMode();
    }
  }

}