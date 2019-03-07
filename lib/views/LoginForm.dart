import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/login/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  String authErrorToString(errorCode) {
    if(errorCode == "ERROR_INVALID_EMAIL" ||
        errorCode == "ERROR_INVALID_CREDENTIAL" ||
        errorCode == "ERROR_WRONG_PASSWORD" ||
        errorCode == "ERROR_EMAIL_ALREADY_IN_USE"
    ){
      return "Wrong email or password";
    }

    if(errorCode == "ERROR_WEAK_PASSWORD"){
      return "Password too weak";
    }

    return "An error has occurred. Please try again";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
          BuildContext context,
          LoginState state,
          ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(authErrorToString(state.error) ?? ''),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              Image.asset('images/icon.png'),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle, color: Colors.grey,),
                    labelText: 'username',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                ),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.grey,),
                    labelText: 'password',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),

                  ),
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              RaisedButton(

                color: Colors.redAccent,
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed:
                state is! LoginLoading ? _onLoginButtonPressed : null,
                child: Text('Login'),
              ),
              Container(
                child:
                state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}