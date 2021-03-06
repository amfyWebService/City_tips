import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/repositories/UserRepository.dart';
import 'package:city_tips/core/login/login.dart';
import 'package:city_tips/views/LoginForm.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;
  String title;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (BuildContext context, LoginState state,) {
        if(state is LoginMode){
          title = "Login";
        } else if(state is RegisterMode) {
          title = "Register";
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.redAccent,
          ),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: LoginForm(
                authenticationBloc: _authenticationBloc,
                loginBloc: _loginBloc,
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
