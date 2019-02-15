import 'package:city_tips/components/LoadingIndicator.dart';
import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  MenuBloc menuBloc;
//  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
//    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
//    authenticationBloc.dispatch(AppStarted());
    menuBloc = MenuBloc();
    super.initState();
  }

  @override
  void dispose() {
//    authenticationBloc.dispose();
    menuBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider(
        bloc: menuBloc,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the Drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('History'),
                  onTap: () {
                    menuBloc.dispatch(HistoryPageSelected());
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    authenticationBloc.dispatch(LoggedOut());
                    // Update the state of the app
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Container(
            child: Center(
              child: BlocBuilder<MenuEvent, MenuState>(
                bloc: menuBloc,
                builder: (BuildContext context, MenuState state) {
                  if (state is HistoryPageShowed) {
                    return LoadingIndicator();
                  }
                },
              ),
            ),
          ),
        ));
  }
}
