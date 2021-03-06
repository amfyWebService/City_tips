import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/core/model/User.dart';
import 'package:city_tips/views/HistoryPage.dart';
import 'package:city_tips/views/MapPage.dart';
import 'package:city_tips/views/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationBloc authenticationBloc;
  MenuItem _menuItemSelected;
  User user;

  List<MenuItem> menu = [
    MenuItem(title: "History", icon: Icons.history, page: HistoryPage()),
    MenuItem(title: "Settings", icon:Icons.settings_applications, page: SettingsPage()),
    MenuItem(title: "Map", icon:Icons.map, page: MapPage()),
  ];

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _menuItemSelected = menu[0];
    authenticationBloc.userRepository.getUser().then((firebaseUser) => setState(() => user = firebaseUser));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> buildMenuDrawer() {
    List<Widget> menuDrawer = [];

    menuDrawer.add(DrawerHeader(
      child: Column(
        children: <Widget>[
          Text('City tips', style: TextStyle(color: Colors.white)),
          Text(user?.username ?? '', style: TextStyle(color: Colors.white))
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.redAccent,
      ),
    ));

    for (int i = 0; i < menu.length; i++) {
      menuDrawer.add(ListTile(
        leading: Icon(menu[i].icon),
        title: Text(menu[i].title ?? ''),
        onTap: () {
          setState(() {
            _menuItemSelected = menu[i];
          });
          Navigator.pop(context);
        },
      ));
    }

    menuDrawer.add(ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Logout'),
        onTap: () {
          authenticationBloc.dispatch(LoggedOut());
        }));

    return menuDrawer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_menuItemSelected.title}'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: buildMenuDrawer()),
      ),
      body: Container(
        child: Center(child: _menuItemSelected.page),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  Widget page;

  MenuItem({@required this.title, @required this.icon, @required this.page});
}
