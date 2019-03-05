import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/login/login.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null), assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await userRepository.authenticate(username: event.username, password: event.password);

        authenticationBloc.dispatch(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        try {
          if (error.code == "ERROR_USER_NOT_FOUND") {
            final user = await userRepository.createUser(username: event.username, password: event.password);
            authenticationBloc.dispatch(LoggedIn(user: user));
            yield LoginInitial();
          } else {
            throw error;
          }
        } catch(error) {
          yield LoginFailure(error: error.code);
        }
      }
    }
  }

}